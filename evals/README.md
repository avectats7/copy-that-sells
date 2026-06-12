# Evals

A regression suite for the `copy-that-sells` skill. The goal is not to fully grade output quality (a human still does that) but to catch the obvious regressions fast: banned words slipping back in, AI-tell dashes, format limits violated, CTAs going generic, diagnostic mode skipping the diagnosis.

## What is in this folder

- `prompts.md`. Twelve test briefs covering the formats and languages the skill targets.
- `rubric.md`. The scoring criteria. Five dimensions for generation prompts (25 points), six for diagnostic prompts (30 points).
- `check_banned_words.sh`. The static checker. Scans for banned English and Spanish vocabulary, connector em/en dashes (testimonial attribution dashes get a WARN instead), sycophantic openers, and compound-word hyphens (WARN only; dictionary compounds are legitimate). Portable across macOS BSD grep and Linux GNU grep; the dash detection runs in perl precisely because `grep -P` does not exist on macOS and used to fail silently there.
- `run_evals.sh`. The headless runner. Executes prompts through `claude -p` with the skill loaded, saves outputs, runs the checker, and optionally runs a critic session against the rubric.
- `outputs/`. Where outputs land. Gitignored except for `.gitkeep`.

## The fast loop

```bash
# run one prompt end to end (requires the claude CLI, authenticated)
./evals/run_evals.sh 01

# run everything
./evals/run_evals.sh

# run one prompt and have a fresh Claude session score it against the rubric
SCORE=1 ./evals/run_evals.sh 09

# pin a model for comparability across runs
MODEL=claude-sonnet-4-6 ./evals/run_evals.sh
```

Each run saves to `evals/outputs/<id>.md` (and `<id>.score.md` with `SCORE=1`), then runs the banned-words check. The runner's exit code is the number of outputs that failed the check, so it can gate CI or a pre-push hook.

## The manual loop

The original workflow still works: paste a prompt from `prompts.md` into a fresh session with the skill installed, save the full output to `evals/outputs/<id>.md`, run the checker on it, score against `rubric.md`.

## The checker, standalone

```bash
# scan any file
./evals/check_banned_words.sh evals/outputs/01-billboard-fintech-es.md

# scan only the copy inside a cookbook file (blockquotes + ```copy fences),
# because cookbook prose legitimately names banned words while teaching
./evals/check_banned_words.sh --copy-only skills/copy-that-sells/cookbook/01-billboard-latam-fintech.md

# verify the checker itself can still detect violations
./evals/check_banned_words.sh --self-test
```

The self-test exists because of a real incident: the previous version used `grep -P`, which BSD grep on macOS rejects, and the error was silenced, so em dashes passed undetected on the machine the skill was developed on. A checker that cannot fail is worse than no checker. CI runs the self-test before trusting anything else.

## What runs in CI

The `lint` job in `.github/workflows/build.yml` runs on every PR touching `skills/` or `evals/`:

1. the checker self-test,
2. the checker in `--copy-only` mode over the five cookbook files,
3. the checker over any saved outputs in `evals/outputs/`.

Running the twelve prompts themselves needs an authenticated `claude` CLI, so prompt runs stay local (or in a future workflow with an API key secret). Run `./evals/run_evals.sh` before any release commit.

## How to interpret results

- **All outputs pass static checks.** No regression.
- **One or two fail on the same banned word.** A new model generation is leaning on a word not yet listed. Add it to `references/self-edit.md`, the master list, and the checker's subset, then rerun.
- **Multiple outputs fail on format limits.** The skill is not respecting `formats.md`. Investigate the workflow files.
- **Outputs pass static checks but score poorly on the rubric.** Technically clean, craft missing. The fix lives in `craft.md` or `frameworks.md`.
- **Prompt 09 scores under 4 on dimension 6.** Diagnostic mode is rewriting before diagnosing. The fix lives in `diagnostics.md` and the SKILL.md mode-switch instruction.

## What the static checker does not catch

- Quality of the idea. A bland but technically clean output passes.
- Whether the headline survives the 4 U's. That is the rubric's job.
- Whether the voice is right for the brief.
- Truth checks. Fabricated proofs pass the static checker; the truth layer is the human's.

For all of the above, use the rubric and a human (or the `SCORE=1` critic) pass.
