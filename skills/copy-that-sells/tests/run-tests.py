#!/usr/bin/env python3
"""Run the validation-tests.md cases against the scorer and assert each
Anti-AI Score threshold. Exits non-zero on the first drift, so it doubles as a
regression guard for the scoring model.

Unlike a shell runner, this imports validate.py and checks the value that
validate() actually returns — no scraping of printed output. Run from
anywhere: `python3 tests/run-tests.py` or `./tests/run-tests.py`.
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "scripts"))
import validate  # noqa: E402  (path set above)

# (id, format, comparison, threshold, text). Mirrors tests/validation-tests.md.
CASES = [
    ("T1", "general", "<=", 4,
     "In today's fast-paced world, our cutting-edge solution leverages AI to unlock your potential."),
    ("T2", "general", "<=", 8,
     "The product was designed to be used by professionals who are seeking better results."),
    ("T3", "general", "<=", 3,
     "Our holistic approach synergizes core competencies to drive innovation and optimize your workflow."),
    ("T4", "general", "<=", 6,
     "This is the best mattress ever made. It will change your life."),
    ("T5", "general", ">=", 7,
     "Fall asleep in 8.3 minutes, guaranteed. 94% of testers slept through the night."),
    ("T6", "billboard", "<=", 6,
     "Sleep better tonight with our revolutionary new mattress technology"),
    ("T7", "billboard", ">=", 8,
     "Fall asleep in 8 minutes."),
    ("T8", "general", ">=", 9,
     "Your brain starts its nightly TED talk. Napwell shuts it up. 100 nights. Zero risk."),
    ("T9", "general", "<=", 3,
     "Our innovative, cutting-edge mattress leverages proprietary technology to deliver a "
     "seamless sleep experience that will transform your life."),
    ("T10", "general", ">=", 5,
     "The red mattress is loved by thousands."),
]


def main():
    passed = failed = 0
    print("Running validation tests against validate.py")
    print("-" * 60)
    for cid, fmt, op, want, text in CASES:
        score = validate.validate(text, fmt)["anti_ai_score"]
        ok = score <= want if op == "<=" else score >= want
        print(f"  {cid:<4} {'PASS' if ok else 'FAIL'}  (score {score}, need {op}{want})")
        if ok:
            passed += 1
        else:
            failed += 1
    print("-" * 60)
    print(f"Result: {passed} passed, {failed} failed")
    sys.exit(0 if failed == 0 else 1)


if __name__ == "__main__":
    main()
