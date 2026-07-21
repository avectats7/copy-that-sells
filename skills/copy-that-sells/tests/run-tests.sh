#!/usr/bin/env bash
# Run every case in validation-tests.md against scripts/validate.py and assert
# its Anti-AI Score threshold. Exits non-zero on the first drift so CI and the
# user can trust that the validator still scores the way the tests document.
#
# Usage: ./tests/run-tests.sh   (run from the skill root)

set -uo pipefail

SKILL_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VALIDATE="$SKILL_ROOT/scripts/validate.py"

pass=0
fail=0

# id | format | op(-le/-ge) | threshold | text
run() {
  local id="$1" fmt="$2" op="$3" want="$4" text="$5"
  local got
  got="$(python3 "$VALIDATE" "$text" --format "$fmt" 2>&1 | grep -o '[0-9]\+/10' | cut -d/ -f1)"
  if [[ -z "$got" ]]; then
    echo "  $id  ERROR: no score produced"
    fail=$((fail + 1)); return
  fi
  if [[ "$op" == "-le" ]]; then cmp="<="; else cmp=">="; fi
  if [ "$got" "$op" "$want" ]; then
    echo "  $id  PASS  (score $got, need $cmp$want)"
    pass=$((pass + 1))
  else
    echo "  $id  FAIL  (score $got, need $cmp$want)"
    fail=$((fail + 1))
  fi
}

echo "Running validation tests against $VALIDATE"
echo "------------------------------------------------------------"
run "T1 " general  -le 4 "In today's fast-paced world, our cutting-edge solution leverages AI to unlock your potential."
run "T2 " general  -le 8 "The product was designed to be used by professionals who are seeking better results."
run "T3 " general  -le 3 "Our holistic approach synergizes core competencies to drive innovation and optimize your workflow."
run "T4 " general  -le 6 "This is the best mattress ever made. It will change your life."
run "T5 " general  -ge 7 "Fall asleep in 8.3 minutes, guaranteed. 94% of testers slept through the night."
run "T6 " billboard -le 6 "Sleep better tonight with our revolutionary new mattress technology"
run "T7 " billboard -ge 8 "Fall asleep in 8 minutes."
run "T8 " general  -ge 9 "Your brain starts its nightly TED talk. Napwell shuts it up. 100 nights. Zero risk."
run "T9 " general  -le 3 "Our innovative, cutting-edge mattress leverages proprietary technology to deliver a seamless sleep experience that will transform your life."
run "T10" general  -ge 5 "The red mattress is loved by thousands."
echo "------------------------------------------------------------"
echo "Result: $pass passed, $fail failed"
[[ "$fail" -eq 0 ]]
