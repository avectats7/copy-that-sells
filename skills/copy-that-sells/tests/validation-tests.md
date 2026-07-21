# Validation Test Cases

These cases exercise `scripts/validate.py`. Each lists the input, the format,
and the Anti-AI Score threshold the validator must satisfy. Run them all with
`./tests/run-tests.py` (from the skill root); it exits non-zero if any case
drifts, so it doubles as a regression guard for the scoring model.

The thresholds are asserted, not decorative: they were measured against the
current validator, so a change that silently weakens scoring will fail here.

## Test 1: Banned phrases stack
**Input:** "In today's fast-paced world, our cutting-edge solution leverages AI to unlock your potential."
**Format:** general
**Expect:** score ≤ 4 — four banned phrases must sink the score, not cost a flat −2.

## Test 2: Weak but not slop
**Input:** "The product was designed to be used by professionals who are seeking better results."
**Format:** general
**Expect:** score ≤ 8 — one real passive ("was designed") plus no specifics. Note: "are seeking" is active progressive, **not** passive; the validator correctly leaves it alone.

## Test 3: Jargon pile-up
**Input:** "Our holistic approach synergizes core competencies to drive innovation and optimize your workflow."
**Format:** general
**Expect:** score ≤ 3 — banned phrases plus "holistic" jargon.

## Test 4: Vague superlative + hype cliché, no proof
**Input:** "This is the best mattress ever made. It will change your life."
**Format:** general
**Expect:** score ≤ 6 — "best" without proof, the "change your life" cliché, and no specifics land it in the warn band.

## Test 5: Specific and clean
**Input:** "Fall asleep in 8.3 minutes, guaranteed. 94% of testers slept through the night."
**Format:** general
**Expect:** score ≥ 7 — real numbers, no tells.

## Test 6: Billboard over length
**Input:** "Sleep better tonight with our revolutionary new mattress technology"
**Format:** billboard
**Expect:** score ≤ 6 — 9 words (max 7) plus "revolutionary".

## Test 7: Billboard clean
**Input:** "Fall asleep in 8 minutes."
**Format:** billboard
**Expect:** score ≥ 8 — 5 words, specific, no tells.

## Test 8: Human and specific
**Input:** "Your brain starts its nightly TED talk. Napwell shuts it up. 100 nights. Zero risk."
**Format:** general
**Expect:** score ≥ 9 — concrete, active, zero AI-tells.

## Test 9: Everything wrong at once
**Input:** "Our innovative, cutting-edge mattress leverages proprietary technology to deliver a seamless sleep experience that will transform your life."
**Format:** general
**Expect:** score ≤ 3 — stacked banned phrases, "innovative" puffery, "transform your life" cliché.

## Test 10: No false positive on "red"
**Input:** "The red mattress is loved by thousands."
**Format:** general
**Expect:** score ≥ 5 — "is loved" is real passive and gets flagged, but "red" must not trip the passive filter.
