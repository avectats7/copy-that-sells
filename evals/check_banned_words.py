#!/usr/bin/env python3
"""Scan copy files for banned words (English and Spanish), AI-tell dashes, and
compound-word hyphens.

Reads its banned patterns from the single source of truth shared with the
scorer (skills/copy-that-sells/scripts/validate.py), so the gate and the
scorer can never disagree. See references/banned-patterns.txt.

Usage:
  check_banned_words.py [--copy-only] <file> [<file>...]
  check_banned_words.py --self-test

Modes:
  --copy-only   Scan only the copy itself: ```copy fenced blocks, markdown
                blockquote lines (^>), and blockquote-prefixed table cells
                (| > headline |). Use for cookbook files, where prose ABOUT
                banned words is legitimate meta-discussion.
  --self-test   Verify the checker's own detection on a built-in sample. CI
                runs this first; a checker that cannot fail is worse than none.

Dash policy (mirrors references/self-edit.md):
  Em/en dash as clause connector -> FAIL.
  Attribution dash in a testimonial ("quote. — Name") -> WARN, review by hand.

Hyphen policy (mirrors references/self-edit.md):
  Compound-word hyphens are a WARN, never a hard fail: dictionary compounds
  ("high-yield", "4-hour") are correct English; invented decorative compounds
  are the tell. A human decides which is which.

Exit codes: 0 = clean (warnings allowed), 1 = violations, 2 = usage/self-test failure.
"""

import argparse
import os
import re
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
PATTERNS_FILE = Path(os.environ.get(
    "PATTERNS_FILE",
    SCRIPT_DIR / ".." / "skills" / "copy-that-sells" / "references" / "banned-patterns.txt",
))

# Letters, including accented, mirroring the shell checker's [:alpha:] under a
# UTF-8 locale. Word boundaries are "not a letter", so digits count as breaks.
_L = "A-Za-zÀ-ÿ"
_BOUND_L = rf"(?<![{_L}])"
_BOUND_R = rf"(?![{_L}])"

# Attribution dash: end punctuation (or line start) then an em/en dash then a
# capital. Allowed in testimonials, but flagged for a human to confirm.
_DASH = re.compile("[—–]")
_ATTR = re.compile("(^|[.!?\"”»’'])\\s*[—–]\\s*[A-ZÀ-Ý]")

_HYPHEN = re.compile(r"[A-Za-z]+-[A-Za-z]+")
_HYPHEN_OK = {
    "co-founder", "co-authored", "mit-style",
}


def load_patterns():
    """Return (en_banned, es_banned, openers) as [(source, compiled), ...].

    The gate loads the hard-fail categories — banned and jargon by language,
    plus opener. It skips superlative: those are legitimate copy WITH proof
    nearby, a proximity call only the scorer makes."""
    if not PATTERNS_FILE.exists():
        sys.stderr.write(f"error: shared pattern file not found: {PATTERNS_FILE}\n")
        sys.exit(2)
    en, es, openers = [], [], []
    for raw in PATTERNS_FILE.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        parts = line.split(None, 2)
        if len(parts) < 3:
            continue
        lang, cat, pat = parts
        if cat == "opener":
            openers.append(pat)
        elif cat in ("banned", "jargon"):
            (en if lang == "en" else es if lang == "es" else []).append(pat)
        # superlative: handled by the scorer, not this gate.
    return _compile(en), _compile(es), _compile(openers)


def _compile(patterns):
    out = []
    for pat in patterns:
        try:
            out.append((pat, re.compile(_BOUND_L + "(?:" + pat + ")" + _BOUND_R, re.IGNORECASE)))
        except re.error:
            sys.stderr.write(f"warning: skipping bad pattern: {pat}\n")
    return out


EN_BANNED, ES_BANNED, OPENERS = load_patterns()


def extract_copy(text):
    """Pull only the copy: ```copy fences, blockquote lines, and blockquote
    cells inside a markdown table (the RSA headline-inventory format)."""
    out = []
    infence = False
    for line in text.splitlines():
        if re.match(r"^```copy[ \t]*$", line):
            infence = True
            continue
        if line.startswith("```"):
            infence = False
            continue
        if infence:
            out.append(line)
            continue
        if line.startswith(">"):
            out.append(re.sub(r"^> ?", "", line))
            continue
        if re.match(r"^[ \t]*\|.*>", line):
            for cell in line.split("|"):
                c = cell.strip()
                if c.startswith(">"):
                    out.append(re.sub(r"^> ?", "", c))
    return "\n".join(out)


def _scan_patterns(lines, compiled, label_prefix, report):
    """One FAIL block per pattern that matches, echoing the offending lines."""
    hits = 0
    for source, rx in compiled:
        matched = [(i, ln) for i, ln in enumerate(lines, 1) if rx.search(ln)]
        if matched:
            report.append(f"FAIL [{label_prefix}: {source}]:")
            for i, ln in matched:
                report.append(f"  {i}:{ln}")
            hits += 1
    return hits


def scan_text(text, name, copy_only, report):
    scope = " (copy-only scan; line numbers relative to extracted copy)" if copy_only else ""
    report.append(f"== {name}{scope}")

    scan_text_body = extract_copy(text) if copy_only else text

    # A copy-only scan of a file with no blockquoted copy would scan nothing
    # and pass vacuously. That is an output-format violation, not a clean run.
    if copy_only and not scan_text_body.strip():
        report.append("FAIL [No blockquoted copy found]: the output format requires "
                      "shippable copy in markdown blockquotes (>).")
        report.append(f"FAIL: 1 issue(s) detected in {name}")
        return 1

    lines = scan_text_body.splitlines()
    hits = 0
    hits += _scan_patterns(lines, EN_BANNED, "English banned", report)
    hits += _scan_patterns(lines, ES_BANNED, "Spanish banned", report)
    hits += _scan_patterns(lines, OPENERS, "Sycophantic opener", report)

    # Dashes: connector dashes fail, attribution dashes warn.
    dash_fails, dash_warns = [], []
    for i, ln in enumerate(lines, 1):
        if not _DASH.search(ln):
            continue
        two = len(_DASH.findall(ln)) >= 2
        if _ATTR.search(ln) and not two:
            dash_warns.append(f"  {i}:{ln}")
        else:
            dash_fails.append(f"  {i}:{ln}")
    if dash_fails:
        report.append("FAIL [Em/en dash as connector]:")
        report.extend(dash_fails)
        hits += 1
    if dash_warns:
        report.append("WARN [Attribution-style dash, allowed in testimonials, review]:")
        report.extend(dash_warns)

    # Compound-word hyphens: WARN only, filtered per match (not per line).
    hyphen_hits = []
    for i, ln in enumerate(lines, 1):
        for m in _HYPHEN.finditer(ln):
            if m.group(0).lower() not in _HYPHEN_OK:
                hyphen_hits.append(f"  {i}:{m.group(0)}")
    if hyphen_hits:
        report.append("WARN [Compound-word hyphen, dictionary compounds are fine, "
                      "review the invented ones]:")
        report.extend(hyphen_hits)

    if hits == 0:
        report.append(f"PASS: no banned tokens detected in {name}")
    else:
        report.append(f"FAIL: {hits} issue(s) detected in {name}")
    return hits


def scan_file(path, copy_only, report):
    text = Path(path).read_text(encoding="utf-8")
    return scan_text(text, path, copy_only, report)


def run_self_test():
    """The checker must be able to fail. A silently broken detector reports
    PASS forever (the grep -P on macOS bug the shell version replaced)."""
    failed = False

    dirty = ("This sentence uses a connector dash — the classic tell.\n"
             "We leverage robust synergy to unlock the potential of teams.\n"
             "Vamos a potenciar la sinergia en el dinámico mundo de hoy.\n"
             "Great question! Absolutely.\n")
    clean = ("Plain copy. Short sentences. A number: 312 pounds saved.\n"
             "I never read The Economist. — Management trainee. Aged 42.\n")

    report = []
    rc = scan_text(dirty, "<dirty>", False, report)
    out = "\n".join(report)
    if rc == 0:
        print("SELF-TEST FAIL: dirty sample passed. Detection is broken.")
        print(out)
        failed = True
    for expected in ("Em/en dash as connector", "English banned", "Spanish banned",
                     "Sycophantic opener"):
        if expected not in out:
            print(f"SELF-TEST FAIL: expected a hit for '{expected}' and found none.")
            failed = True

    report = []
    rc = scan_text(clean, "<clean>", False, report)
    out = "\n".join(report)
    if rc != 0:
        print("SELF-TEST FAIL: clean sample (attribution dash only) failed; "
              "it should pass with a WARN.")
        print(out)
        failed = True
    if "Attribution-style dash" not in out:
        print("SELF-TEST FAIL: attribution dash did not produce its WARN.")
        failed = True

    # Table-cell extraction: a banned word inside a markdown table cell (the RSA
    # headline-inventory format) must be caught in --copy-only mode.
    table = ("| # | Headline | Chars | Job |\n"
             "|---|----------|-------|-----|\n"
             "| 1 | > We leverage robust tooling | 27 | Query echo |\n")
    report = []
    rc = scan_text(table, "<table>", True, report)
    if rc == 0:
        print("SELF-TEST FAIL: banned word in a table cell passed the copy-only scan. "
              "Table extraction is broken.")
        print("\n".join(report))
        failed = True

    if not failed:
        print("SELF-TEST PASS: detection working (connector dash, EN, ES, openers, "
              "attribution WARN, table-cell copy).")
        return 0
    return 2


def main():
    parser = argparse.ArgumentParser(add_help=True, description=__doc__)
    parser.add_argument("--copy-only", action="store_true")
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("files", nargs="*")
    args = parser.parse_args()

    if args.self_test:
        sys.exit(run_self_test())

    if not args.files:
        sys.stderr.write(f"usage: {sys.argv[0]} [--copy-only] <file> [<file>...]\n")
        sys.stderr.write(f"       {sys.argv[0]} --self-test\n")
        sys.exit(2)

    total = 0
    for f in args.files:
        if not Path(f).is_file():
            sys.stderr.write(f"error: file not found: {f}\n")
            sys.exit(2)
        report = []
        total += scan_file(f, args.copy_only, report)
        print("\n".join(report))
        print()

    sys.exit(0 if total == 0 else 1)


if __name__ == "__main__":
    main()
