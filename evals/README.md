# Evals

A lightweight regression suite for the `copy-that-sells` skill. The goal is not to fully grade output quality (a human still does that) but to catch the obvious regressions: banned words slipping back in, format limits getting violated, voice drift across sections, CTAs going generic. These checks run locally with no paid API and take about 30 seconds.

## What is in this folder

- `prompts.md`. Twelve test briefs covering the formats and languages the skill targets. Run any of these in a fresh Claude session against the skill and save the output to `outputs/<prompt-id>.md`.
- `rubric.md`. The scoring criteria. Used by the static checker, and as a paste-in prompt if you want a second-opinion LLM to score the output.
- `check_banned_words.sh`. A bash script that scans an output file for banned English and Spanish vocabulary, em dashes, en dashes, and compound-word hyphens. Returns nonzero on any hit.
- `outputs/`. Where you save model outputs after running the prompts. Gitignored.

## How to run a full pass

1. Open a fresh Claude Code or Cowork session with the skill installed.
2. Paste a prompt from `prompts.md` into the session.
3. Save the output to `evals/outputs/01-billboard-fintech.md` (or whichever prompt you ran).
4. Run `./evals/check_banned_words.sh evals/outputs/01-billboard-fintech.md`.
5. Score against `rubric.md` by hand or by pasting both the output and the rubric into a second Claude session and asking for a score.
6. Repeat for as many prompts as you want to cover.

## How to interpret results

- **All twelve outputs pass static checks.** No regression.
- **One or two fail on the same banned word.** Probably a new model is leaning on a word that was not yet on the list. Add it to `references/self-edit.md` and the master list, then rerun.
- **Multiple outputs fail on format limits.** The skill is not respecting `formats.md`. Investigate the workflow files.
- **Outputs pass static checks but score poorly on the rubric.** The skill is technically clean but missing craft. The fix is in `craft.md` or `frameworks.md`.

## What the static checker does not catch

- Quality of the idea. A bland but technically clean output passes.
- Whether the headline survives the 4 U's. That is the rubric's job.
- Whether the voice is right for the brief.
- Truth checks. Fabricated proofs pass the static checker.

For all of the above, use the rubric and a human (or a critic LLM) pass.

## Future work

Once Anthropic ships a proper skill eval framework, port these prompts and rubric into that framework so the suite can run on every PR via CI. Until then, the static checker runs in CI (see `.github/workflows/build.yml`) and the rest is manual.
