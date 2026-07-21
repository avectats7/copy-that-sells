#!/usr/bin/env python3
"""Run the eval prompts headless against Claude Code, save the outputs, and
check them for banned vocabulary. Optionally score each output with a second,
fresh Claude session acting as the rubric critic.

Requirements:
  - the `claude` CLI on PATH, authenticated
  - run from anywhere; paths resolve relative to the repo root

Usage:
  python3 evals/run_evals.py               # run all prompts in evals/prompts.md
  python3 evals/run_evals.py 01 09         # run a subset by prompt id prefix
  SCORE=1 python3 evals/run_evals.py 01    # also produce <id>.score.md per output
  MODEL=claude-sonnet-4-6 python3 evals/run_evals.py 01   # override the model

Each prompt:
  1. extracted from evals/prompts.md (the blockquote under its ## heading)
  2. run through `claude -p` with SKILL.md appended to the system prompt and
     the Read tool allowed, so the model can open the reference files
  3. output saved to evals/outputs/<id>.md
  4. checked with evals/check_banned_words.py
  5. with SCORE=1, scored by a fresh `claude -p` against evals/rubric.md

Exit code: number of prompts whose output failed the banned-words check
(capped at 125), so CI can gate on it.
"""

import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
PROMPTS_FILE = REPO_ROOT / "evals" / "prompts.md"
SKILL_FILE = REPO_ROOT / "skills" / "copy-that-sells" / "SKILL.md"
OUT_DIR = REPO_ROOT / "evals" / "outputs"
CHECKER = [sys.executable, str(REPO_ROOT / "evals" / "check_banned_words.py")]

ERROR_PATTERNS = re.compile(
    r"API Error|Failed to authenticate|authentication_error|invalid api key|"
    r"credit balance|rate limit", re.IGNORECASE)
AUTH_ERROR = re.compile(
    r"Failed to authenticate|authentication_error|invalid api key", re.IGNORECASE)

OPERATIONAL_NOTE = (
    "\n\nOperational note for this eval run: the reference files this skill "
    "cites live under skills/copy-that-sells/references/ and "
    "skills/copy-that-sells/cookbook/ relative to the working directory. Read "
    "them with the Read tool exactly as the skill instructs. Produce the full "
    "standard output format (Idea, Final copy, Alternates, Notes) unless the "
    "prompt is diagnostic, in which case use the diagnostic format.")


def claude_env():
    """When nested inside a Claude Code session, strip the host's auth plumbing
    so the child CLI resolves its own auth like a fresh terminal. KEEP_ENV=1
    disables the strip."""
    env = os.environ.copy()
    if env.get("CLAUDE_CODE_SESSION_ID") and env.get("KEEP_ENV", "0") != "1":
        for var in ("ANTHROPIC_BASE_URL", "ANTHROPIC_API_KEY", "ANTHROPIC_AUTH_TOKEN",
                    "CLAUDE_CODE_SDK_HAS_HOST_AUTH_REFRESH", "CLAUDE_CODE_SDK_HAS_OAUTH_REFRESH"):
            env.pop(var, None)
        print("(nested Claude Code session detected; running claude with a clean auth environment)")
    return env


def looks_like_error(path: Path) -> bool:
    """An error message saved as output would sail through the banned-words
    check, so validate every output before it counts."""
    text = path.read_text(encoding="utf-8", errors="replace")
    if ERROR_PATTERNS.search(text):
        return True
    return len(text.split()) < 15


def all_ids():
    text = PROMPTS_FILE.read_text(encoding="utf-8")
    return [m.group(1) for m in re.finditer(r"^## ([0-9]{2}-\S*.*)$", text, re.MULTILINE)]


def prompt_body(pid: str) -> str:
    lines = PROMPTS_FILE.read_text(encoding="utf-8").splitlines()
    out, insec = [], False
    for line in lines:
        if line == f"## {pid}":
            insec = True
            continue
        if line.startswith("## "):
            insec = False
        if insec and line.startswith(">"):
            out.append(re.sub(r"^> ?", "", line))
    return "\n".join(out)


def resolve_ids(requested):
    ids = all_ids()
    if not requested:
        return ids
    resolved = []
    for prefix in requested:
        match = next((i for i in ids if i.startswith(prefix)), None)
        if match is None:
            sys.exit(f"error: no prompt id starts with '{prefix}'")
        resolved.append(match)
    return resolved


def main():
    if shutil.which("claude") is None:
        sys.exit("error: the claude CLI is not on PATH. Install Claude Code first.")

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    env = claude_env()
    model = os.environ.get("MODEL")
    score_mode = os.environ.get("SCORE", "0") == "1"

    system_prompt = SKILL_FILE.read_text(encoding="utf-8") + OPERATIONAL_NOTE
    ids = resolve_ids(sys.argv[1:])
    failed = 0

    for pid in ids:
        body = prompt_body(pid)
        if not body.strip():
            sys.exit(f"error: prompt {pid} has no blockquote body in {PROMPTS_FILE}")

        outfile = OUT_DIR / f"{pid}.md"
        print(f"== running {pid}")

        cmd = ["claude", "-p", body,
               "--append-system-prompt", system_prompt,
               "--allowedTools", "Read"]
        if model:
            cmd += ["--model", model]
        result = subprocess.run(cmd, env=env, capture_output=True, text=True)
        outfile.write_text(result.stdout + result.stderr, encoding="utf-8")

        if looks_like_error(outfile):
            errlog = OUT_DIR / f"{pid}.error.log"
            outfile.replace(errlog)
            print(f"   RUN ERROR on {pid} (saved to {pid}.error.log):")
            for line in errlog.read_text(encoding="utf-8").splitlines()[:4]:
                print(f"   | {line}")
            failed += 1
            if AUTH_ERROR.search(errlog.read_text(encoding="utf-8")):
                print()
                print("aborting: authentication is broken, every remaining prompt would fail "
                      "the same way.", file=sys.stderr)
                print("most common cause: running nested inside a Claude Code session whose host "
                      "app owns the OAuth refresh token. Run this from a normal terminal instead; "
                      "the CLI refreshes its token on launch there. KEEP_ENV=1 skips the env strip.",
                      file=sys.stderr)
                sys.exit(2)
            continue

        print(f"   saved {outfile} ({len(outfile.read_text(encoding='utf-8').split())} words)")

        check = subprocess.run(CHECKER + ["--copy-only", str(outfile)], env=env)
        if check.returncode != 0:
            print(f"   BANNED-WORDS FAIL on {pid}")
            failed += 1

        if score_mode:
            scorefile = OUT_DIR / f"{pid}.score.md"
            critic_prompt = (
                "Score the following copy output against the rubric below. For each "
                "dimension, give a number from 0 to 5 and one line of justification. "
                "Dimension 6 applies only if the original prompt pasted existing copy to "
                "diagnose. End with a total and a single sentence on the strongest and "
                "weakest dimension.\n\n"
                "--- RUBRIC ---\n" + (REPO_ROOT / "evals" / "rubric.md").read_text(encoding="utf-8") +
                "\n\n--- ORIGINAL PROMPT ---\n" + body +
                "\n\n--- OUTPUT TO SCORE ---\n" + outfile.read_text(encoding="utf-8"))
            scmd = ["claude", "-p", critic_prompt]
            if model:
                scmd += ["--model", model]
            sres = subprocess.run(scmd, env=env, capture_output=True, text=True)
            scorefile.write_text(sres.stdout + sres.stderr, encoding="utf-8")
            print(f"   scored -> {scorefile}")

        print()

    print(f"done: {len(ids)} prompt(s) run, {failed} failed the banned-words check.")
    sys.exit(min(failed, 125))


if __name__ == "__main__":
    main()
