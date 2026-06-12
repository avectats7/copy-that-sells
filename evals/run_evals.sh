#!/usr/bin/env bash
# Run the eval prompts headless against Claude Code, save the outputs, and
# check them for banned vocabulary. Optionally score each output with a
# second, fresh Claude session acting as the rubric critic.
#
# Requirements:
#   - the `claude` CLI on PATH, authenticated
#   - run from the repo root (paths are relative to it)
#
# Usage:
#   ./evals/run_evals.sh               # run all prompts in evals/prompts.md
#   ./evals/run_evals.sh 01 09         # run a subset by prompt id prefix
#   SCORE=1 ./evals/run_evals.sh 01    # also produce <id>.score.md per output
#   MODEL=claude-sonnet-4-6 ./evals/run_evals.sh 01   # override the model
#
# Each prompt:
#   1. extracted from evals/prompts.md (the blockquote under its ## heading)
#   2. run through `claude -p` with SKILL.md appended to the system prompt
#      and the Read tool allowed, so the model can open the reference files
#   3. output saved to evals/outputs/<id>.md
#   4. checked with ./evals/check_banned_words.sh
#   5. with SCORE=1, scored by a fresh `claude -p` against evals/rubric.md
#
# Exit code: number of prompts whose output failed the banned-words check
# (capped at 125), so CI can gate on it.

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

PROMPTS_FILE="evals/prompts.md"
SKILL_FILE="skills/copy-that-sells/SKILL.md"
OUT_DIR="evals/outputs"
CHECKER="evals/check_banned_words.sh"

command -v claude >/dev/null 2>&1 || {
  echo "error: the claude CLI is not on PATH. Install Claude Code first." >&2
  exit 2
}

mkdir -p "$OUT_DIR"

# When this script runs nested inside a Claude Code session, the session
# exports ANTHROPIC_BASE_URL (the host app's authenticated proxy) and SDK
# flags that tell a child CLI the host will refresh tokens for it. A child
# `claude` inheriting those dies with a 401. Strip the session plumbing so
# the child resolves its own auth like a fresh terminal. Even stripped, a
# nested run can still 401 when the host app owns the OAuth refresh token;
# in that case run this script from a normal terminal, where the CLI can
# refresh on launch. KEEP_ENV=1 disables the strip entirely.
CLAUDE_CMD=(claude)
if [[ -n "${CLAUDE_CODE_SESSION_ID:-}" && "${KEEP_ENV:-0}" != "1" ]]; then
  CLAUDE_CMD=(env -u ANTHROPIC_BASE_URL -u ANTHROPIC_API_KEY -u ANTHROPIC_AUTH_TOKEN \
    -u CLAUDE_CODE_SDK_HAS_HOST_AUTH_REFRESH -u CLAUDE_CODE_SDK_HAS_OAUTH_REFRESH claude)
  echo "(nested Claude Code session detected; running claude with a clean auth environment)"
fi

# An error message saved as an output would sail through the banned-words
# check: error prose contains no banned vocabulary. The same silent-pass
# class of bug the checker's --self-test exists to prevent. So every output
# gets validated before it counts.
looks_like_error() {
  local f="$1"
  grep -qiE "API Error|Failed to authenticate|authentication_error|invalid api key|credit balance|rate limit" "$f" && return 0
  [[ $(wc -w < "$f" | tr -d ' ') -lt 15 ]] && return 0
  return 1
}

# All prompt ids, in file order.
all_ids() {
  grep -E '^## [0-9]{2}-' "$PROMPTS_FILE" | sed 's/^## //'
}

# The blockquote body of one prompt section, with the "> " prefix stripped.
prompt_body() {
  local id="$1"
  awk -v id="$id" '
    $0 == "## " id { insec = 1; next }
    /^## /         { insec = 0 }
    insec && /^>/  { sub(/^> ?/, ""); print }
  ' "$PROMPTS_FILE"
}

SYSTEM_PROMPT="$(cat "$SKILL_FILE")

Operational note for this eval run: the reference files this skill cites live under skills/copy-that-sells/references/ and skills/copy-that-sells/cookbook/ relative to the working directory. Read them with the Read tool exactly as the skill instructs. Produce the full standard output format (Idea, Final copy, Alternates, Notes) unless the prompt is diagnostic, in which case use the diagnostic format."

# Resolve requested ids: full ids from prefixes, or everything.
REQUESTED=("$@")
IDS=()
if [[ ${#REQUESTED[@]} -eq 0 ]]; then
  while IFS= read -r id; do IDS+=("$id"); done < <(all_ids)
else
  for prefix in "${REQUESTED[@]}"; do
    match=$(all_ids | grep -E "^${prefix}" | head -1 || true)
    if [[ -z "$match" ]]; then
      echo "error: no prompt id starts with '$prefix'" >&2
      exit 2
    fi
    IDS+=("$match")
  done
fi

FAILED=0

for id in "${IDS[@]}"; do
  body=$(prompt_body "$id")
  if [[ -z "$body" ]]; then
    echo "error: prompt $id has no blockquote body in $PROMPTS_FILE" >&2
    exit 2
  fi

  outfile="$OUT_DIR/$id.md"
  echo "== running $id"

  "${CLAUDE_CMD[@]}" -p "$body" \
    --append-system-prompt "$SYSTEM_PROMPT" \
    --allowedTools "Read" \
    ${MODEL:+--model "$MODEL"} \
    > "$outfile" 2>&1

  if looks_like_error "$outfile"; then
    mv "$outfile" "$OUT_DIR/$id.error.log"
    echo "   RUN ERROR on $id (saved to $id.error.log):"
    sed 's/^/   | /' "$OUT_DIR/$id.error.log" | head -4
    FAILED=$((FAILED + 1))
    if grep -qiE "Failed to authenticate|authentication_error|invalid api key" "$OUT_DIR/$id.error.log"; then
      echo
      echo "aborting: authentication is broken, every remaining prompt would fail the same way." >&2
      echo "most common cause: running nested inside a Claude Code session whose host app owns" >&2
      echo "the OAuth refresh token. Run this script from a normal terminal instead; the CLI" >&2
      echo "refreshes its token on launch there. KEEP_ENV=1 skips the env strip if you need it." >&2
      exit 2
    fi
    continue
  fi

  echo "   saved $outfile ($(wc -w < "$outfile" | tr -d ' ') words)"

  # Copy-only: the output format mixes shippable copy (blockquoted) with
  # commentary that legitimately names banned words (self-edit reports,
  # diagnostic quotes). Only the copy is held to the banned list.
  if ! "$CHECKER" --copy-only "$outfile"; then
    echo "   BANNED-WORDS FAIL on $id"
    FAILED=$((FAILED + 1))
  fi

  if [[ "${SCORE:-0}" == "1" ]]; then
    scorefile="$OUT_DIR/$id.score.md"
    critic_prompt="Score the following copy output against the rubric below. For each dimension, give a number from 0 to 5 and one line of justification. Dimension 6 applies only if the original prompt pasted existing copy to diagnose. End with a total and a single sentence on the strongest and weakest dimension.

--- RUBRIC ---
$(cat evals/rubric.md)

--- ORIGINAL PROMPT ---
$body

--- OUTPUT TO SCORE ---
$(cat "$outfile")"
    "${CLAUDE_CMD[@]}" -p "$critic_prompt" ${MODEL:+--model "$MODEL"} > "$scorefile" 2>&1
    echo "   scored -> $scorefile"
  fi

  echo
done

echo "done: ${#IDS[@]} prompt(s) run, $FAILED failed the banned-words check."
exit $((FAILED > 125 ? 125 : FAILED))
