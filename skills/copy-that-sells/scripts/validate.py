#!/usr/bin/env python3
"""
Copy That Sells — Quality Validator
Run: python validate.py "Your copy here" --format headline
"""

import re
import sys
import argparse
from pathlib import Path
from typing import List, Tuple

# Banned words live in ONE place, shared with evals/check_banned_words.py, so
# the two tools can never drift apart. See references/banned-patterns.txt.
PATTERNS_FILE = Path(__file__).resolve().parent.parent / "references" / "banned-patterns.txt"

# Word-boundary guards that also respect accented Spanish letters (Python's \b
# is unreliable around non-ASCII). Mirrors the shell checker's [^[:alpha:]] wrap.
_LEFT = r"(?<![0-9A-Za-zÀ-ÿ])"
_RIGHT = r"(?![0-9A-Za-zÀ-ÿ])"

PASSIVE_PATTERNS = [
    r"\bis\s+\w+ed\b", r"\bwas\s+\w+ed\b", r"\bbeen\s+\w+ed\b",
    r"\bare\s+\w+ed\b", r"\bwere\s+\w+ed\b",
]


def load_patterns() -> dict:
    """Read the shared pattern file into {category: [compiled regex, ...]}.
    Format per line: LANG  CATEGORY  PATTERN (ERE). The scorer uses banned,
    jargon, and superlative across both languages; opener is the shell's."""
    cats = {"banned": [], "jargon": [], "superlative": []}
    if not PATTERNS_FILE.exists():
        sys.stderr.write(f"warning: pattern file not found at {PATTERNS_FILE}\n")
        return cats
    for raw in PATTERNS_FILE.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        parts = line.split(None, 2)
        if len(parts) < 3:
            continue
        _lang, cat, pat = parts
        if cat not in cats:
            continue
        try:
            cats[cat].append(re.compile(_LEFT + r"(?:" + pat + r")" + _RIGHT, re.IGNORECASE))
        except re.error:
            sys.stderr.write(f"warning: skipping bad pattern: {pat}\n")
    return cats


_PATTERNS = load_patterns()

PROOF_INDICATORS = ["because", "since", "proven", "tested", "rated", "voted",
    "#1", "award", "study", "research", "data", "%", "percent", "times",
    "x ", "out of"]


def _matches(text: str, patterns: list) -> List[str]:
    found = []
    for rx in patterns:
        m = rx.search(text)
        if m:
            found.append(m.group(0).strip())
    return found


def check_banned_phrases(text: str) -> Tuple[bool, List[str]]:
    found = _matches(text, _PATTERNS["banned"])
    return len(found) == 0, found


def check_passive_voice(text: str) -> Tuple[bool, List[str]]:
    found = []
    for pattern in PASSIVE_PATTERNS:
        matches = re.findall(pattern, text, re.IGNORECASE)
        found.extend(matches)
    filtered = [m for m in found if not any(m.lower().endswith(x) for x in [
        "red", "bed", "led", "fed", "wed", "shed", "bred", "bled",
        "aged", "sized", "shaped", "toned", "hued", "natured"
    ])]
    return len(filtered) == 0, filtered[:5]


def check_jargon(text: str) -> Tuple[bool, List[str]]:
    found = _matches(text, _PATTERNS["jargon"])
    return len(found) == 0, found


def check_vague_superlatives(text: str) -> Tuple[bool, List[str]]:
    """Superlatives are only a problem WITHOUT nearby proof. "best" next to a
    stat or an award is legitimate; "best" on its own is puffery."""
    text_lower = text.lower()
    found = []
    for rx in _PATTERNS["superlative"]:
        m = rx.search(text)
        if not m:
            continue
        idx = m.start()
        surrounding = text_lower[max(0, idx - 30):idx + 60]
        if not any(p in surrounding for p in PROOF_INDICATORS):
            found.append(m.group(0).strip())
    return len(found) == 0, found


def check_specificity(text: str) -> Tuple[bool, str]:
    has_numbers = bool(re.search(r"\d", text))
    has_specifics = bool(re.search(
        r"\b(?:January|February|March|April|May|June|July|August|September|"
        r"October|November|December|Monday|Tuesday|Wednesday|Thursday|Friday|"
        r"Saturday|Sunday|\d{4}|\$|€|£|percent|%)\b", text, re.IGNORECASE))
    if has_numbers or has_specifics:
        return True, "Contains specific details (numbers, dates, currency)"
    return False, "No specific details found — add numbers, dates, or concrete facts"


def check_headline_length(text: str, fmt: str) -> Tuple[bool, str]:
    lines = text.strip().split("\n")
    headline = lines[0] if lines else text
    words = headline.split()
    word_count = len(words)
    limits = {"billboard": 7, "ooh": 7, "headline": 12, "digital": 10, "tagline": 7}
    limit = limits.get(fmt, 15)
    if word_count > limit:
        return False, f"{word_count} words (max {limit} for {fmt})"
    return True, f"{word_count} words (max {limit})"


def calculate_anti_ai_score(results: dict) -> int:
    """Deductions scale with the NUMBER of violations, not just their presence.
    Four banned phrases must cost more than one — otherwise stacked slop
    scores the same as a single slip and the validator rubber-stamps it."""
    score = 10
    # Banned phrases are the loudest AI-tell: -2 for the first, -1 each after.
    banned = results["banned_phrases"][1]
    if banned:
        score -= 2 + (len(banned) - 1)
    # Jargon and vague superlatives: -1 per distinct offender.
    score -= len(results["jargon"][1])
    score -= len(results["vague_superlatives"][1])
    # Passive voice: -1 per hit (detection already caps the list at 5).
    score -= len(results["passive_voice"][1])
    # Structural misses: flat -1 each.
    if not results["specificity"][0]: score -= 1
    if not results["headline_length"][0]: score -= 1
    return max(1, score)


def validate(text: str, fmt: str = "general") -> dict:
    results = {
        "banned_phrases": check_banned_phrases(text),
        "passive_voice": check_passive_voice(text),
        "jargon": check_jargon(text),
        "vague_superlatives": check_vague_superlatives(text),
        "specificity": check_specificity(text),
        "headline_length": check_headline_length(text, fmt),
    }
    results["anti_ai_score"] = calculate_anti_ai_score(results)
    return results


def print_report(results: dict, text: str):
    print("=" * 60)
    print("COPY THAT SELLS — QUALITY VALIDATION REPORT")
    print("=" * 60)
    print(f"\nInput: \"{text[:80]}{'...' if len(text) > 80 else ''}\"\n")
    checks = [
        ("Banned Phrases", "banned_phrases", "PASS", "FAIL"),
        ("Passive Voice", "passive_voice", "PASS", "FAIL"),
        ("Corporate Jargon", "jargon", "PASS", "FAIL"),
        ("Vague Superlatives", "vague_superlatives", "PASS", "FAIL"),
        ("Specificity", "specificity", "PASS", "NEEDS WORK"),
        ("Headline Length", "headline_length", "PASS", "TOO LONG"),
    ]
    for label, key, pass_msg, fail_msg in checks:
        passed, details = results[key]
        status = f"PASS: {pass_msg}" if passed else f"FAIL: {fail_msg}"
        detail_str = ""
        if isinstance(details, list) and details:
            detail_str = f" — Found: {', '.join(details[:3])}"
        elif isinstance(details, str) and details:
            detail_str = f" — {details}"
        print(f"  {label:<20} {status}{detail_str}")
    score = results["anti_ai_score"]
    score_bar = "█" * score + "░" * (10 - score)
    print(f"\n  Anti-AI Score: [{score_bar}] {score}/10")
    if score >= 8:
        print("  PASS: Excellent — This copy passes the human test.")
    elif score >= 5:
        print("  WARN: Decent — Some AI-tells detected. Review flagged items.")
    else:
        print("  FAIL: Needs rewrite — Too many AI indicators. Start over.")
    print("=" * 60)


def main():
    parser = argparse.ArgumentParser(description="Validate copy for AI-tells and quality issues.")
    parser.add_argument("text", help="The copy text to validate")
    parser.add_argument("--format", "-f", default="general",
        choices=["headline", "billboard", "ooh", "tagline", "digital", "general"],
        help="Format type for length checking")
    args = parser.parse_args()
    results = validate(args.text, args.format)
    print_report(results, args.text)
    if results["anti_ai_score"] < 5:
        sys.exit(1)


if __name__ == "__main__":
    main()
