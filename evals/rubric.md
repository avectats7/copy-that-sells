# Rubric

Score each output across five dimensions, plus a sixth when the prompt is diagnostic (the user pasted existing copy). Total possible: 25 for generation prompts, 30 for diagnostic prompts. Failing runs: under 18/25 for generation, under 22/30 for diagnostic.

You can score by hand, paste this rubric and the output into a fresh Claude session, or use `SCORE=1 ./evals/run_evals.sh <id>` to automate the critic. Keep the same critic prompt across runs so the scores are comparable.

---

## 1. Clean of AI tells (5 points)

The output passes `./evals/check_banned_words.sh` cleanly.

- 5 = no hits in the static checker.
- 4 = one hit on a marginal banned word, easily defensible.
- 3 = two to three hits.
- 2 = four or more hits, or any em dash / en dash.
- 1 = the output reads as generic AI prose.
- 0 = unusable; full rewrite needed.

## 2. Idea is sharp (5 points)

- 5 = idea can be stated in one sentence and survives the billboard test (would work on a poster with no body copy).
- 4 = idea is named but slightly fuzzy.
- 3 = idea is implied; the user could not name it back to you in one sentence.
- 2 = no idea; just a description of the product.
- 1 = literally a feature list.
- 0 = idea is wrong (would not move the reader).

## 3. Specifics replace abstractions (5 points)

Count specifics in the body: numbers, names, dates, places, demonstrations.

- 5 = at least one specific per paragraph; no filler adjectives survived.
- 4 = mostly specifics; one or two adjectives slipped in.
- 3 = roughly half specifics, half abstractions.
- 2 = mostly abstractions; few or no numbers.
- 1 = no specifics at all.

## 4. Format discipline (5 points)

The output respects the word counts and structural limits in `references/formats.md` for the format requested.

- 5 = within format limits, structure correct.
- 4 = within format limits, structure slightly off.
- 3 = one section over the format limit.
- 2 = multiple sections over the format limit, or structure wrong for the format.
- 1 = wrong format produced.

## 5. CTA continues the promise (5 points)

The CTA verb is specific (not Submit, Click here, Learn more, Continue). The CTA language mirrors the headline. There is one primary CTA.

- 5 = strong verb, mirrors the headline, microcopy reduces risk.
- 4 = strong verb, mirrors loosely.
- 3 = verb is okay but not specific.
- 2 = generic verb.
- 1 = no CTA or competing CTAs.

## 6. Diagnostic discipline (5 points, diagnostic prompts only)

Scored only when the prompt pasted existing copy (e.g. prompt 09). The skill must diagnose before it rewrites, per `references/diagnostics.md`.

- 5 = names the root cause referencing one of the five diagnostic questions before any rewrite; states the Edit / Restructure / Burn down call; ends with the "what this teaches" lever.
- 4 = diagnoses first, but the root cause is loosely tied to the framework or the teaching line is missing.
- 3 = a diagnosis exists but is generic ("it sounds corporate") with no question referenced.
- 2 = rewrite delivered first, diagnosis bolted on after.
- 1 = no diagnosis; just a rewrite.
- 0 = the rewrite contradicts the pasted copy's own brief (did not read it).

---

## Critic-prompt template

If you want to use a second Claude session as the scorer, paste this and the output and rubric together:

> Score the following copy output against the rubric below. For each of the five dimensions, give a number from 0 to 5 and one line of justification. End with a total out of 25 and a single sentence on the strongest and weakest dimension.
>
> [paste rubric here]
>
> [paste output here]

The critic should produce a score in the format:

> 1. Clean of AI tells: 5. No banned words detected.
> 2. Idea is sharp: 4. Idea is named ("ahorrar sin querer") but slightly fuzzy on whose belief it shifts.
> 3. Specifics: 5. "0.3 segundos," "$42 a month," "4.5% APY" all present.
> 4. Format discipline: 5. Billboard at 5 words.
> 5. CTA: 4. "Bajala" is strong but the microcopy under it could reduce risk further.
>
> Total: 23/25. Strongest: AI-tell discipline. Weakest: idea sharpness.

---

## What this rubric does not capture

- Truth of claims. A fabricated specific scores the same as a real one in dimension 3. The truth check is the human's job.
- Voice fit. A correct-voice output and a wrong-voice output can both score 25. Voice fit is the human's job.
- Brand fit. The skill cannot know whether the output sounds like the user's brand without the user reading it.

Use the rubric to catch regressions. Use the human read for the final yes.
