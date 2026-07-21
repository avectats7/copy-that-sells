# Validation Test Cases

## Test 1: Banned Phrases Detection
**Input:** "In today's fast-paced world, our cutting-edge solution leverages AI to unlock your potential."
**Expected:** FAIL — Banned phrases: "in today's fast-paced world", "cutting-edge", "leverage", "unlock your potential"
**Anti-AI Score:** ≤ 4

## Test 2: Passive Voice Detection
**Input:** "The product was designed to be used by professionals who are seeking better results."
**Expected:** FAIL — Passive voice: "was designed", "are seeking"
**Anti-AI Score:** ≤ 6

## Test 3: Jargon Detection
**Input:** "Our holistic approach synergizes core competencies to drive innovation and optimize your workflow."
**Expected:** FAIL — Jargon: "holistic", "synergizes", "core competencies", "drive innovation", "optimize"
**Anti-AI Score:** ≤ 3

## Test 4: Vague Superlatives Without Proof
**Input:** "This is the best mattress ever made. It will change your life."
**Expected:** FAIL — Vague superlatives: "best", "change your life" (no proof)
**Anti-AI Score:** ≤ 5

## Test 5: Specificity Check — Pass
**Input:** "Fall asleep in 8.3 minutes, guaranteed. 94% of testers slept through the night."
**Expected:** PASS — Contains specific numbers (8.3, 94%)
**Anti-AI Score:** ≥ 7

## Test 6: Headline Length — Billboard
**Input:** "Sleep better tonight with our revolutionary new mattress technology"
**Format:** billboard
**Expected:** FAIL — 9 words (max 7 for billboard)
**Anti-AI Score:** ≤ 6

## Test 7: Headline Length — Pass
**Input:** "Fall asleep in 8 minutes."
**Format:** billboard
**Expected:** PASS — 5 words (max 7)
**Anti-AI Score:** ≥ 8

## Test 8: Clean Copy — High Score
**Input:** "Your brain starts its nightly TED talk. Napwell shuts it up. 100 nights. Zero risk."
**Expected:** PASS — No banned phrases, active voice, specific, human
**Anti-AI Score:** ≥ 9

## Test 9: Mixed Issues
**Input:** "Our innovative, cutting-edge mattress leverages proprietary technology to deliver a seamless sleep experience that will transform your life."
**Expected:** FAIL — Multiple issues: banned phrases, adjective overload, vague superlative, no specifics
**Anti-AI Score:** ≤ 3

## Test 10: Edge Case — False Positive on "Red"
**Input:** "The red mattress is loved by thousands."
**Expected:** PASS — "is loved" is passive, but "red" should not trigger false positive
**Anti-AI Score:** ≥ 5 (passive voice still detected)
