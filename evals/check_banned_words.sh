#!/usr/bin/env bash
# Scan copy output files for banned words (English and Spanish), AI-tell
# dashes, and compound-word hyphens.
#
# Portable by construction: BSD grep (macOS) has no -P, so the dash check
# runs in perl, which ships on both macOS and Linux. Everything else uses
# plain grep -E.
#
# Usage:
#   ./evals/check_banned_words.sh [--copy-only] <file> [<file>...]
#   ./evals/check_banned_words.sh --self-test
#
# Modes:
#   --copy-only   Scan only the copy itself: markdown blockquote lines (^>)
#                 and ```copy fenced blocks. Use for cookbook files, where
#                 prose ABOUT banned words is legitimate meta-discussion.
#   --self-test   Verify the checker's own detection on a built-in sample.
#                 CI runs this first; a checker that cannot fail is worse
#                 than no checker.
#
# Dash policy (mirrors references/self-edit.md):
#   Em/en dash as clause connector  -> FAIL.
#   Attribution dash in a testimonial ("quote. — Name") -> WARN, review by hand.
#
# Hyphen policy (mirrors references/self-edit.md):
#   Compound-word hyphens are a WARN, never a hard fail: dictionary compounds
#   ("high-yield", "4-hour") are correct English; invented decorative
#   compounds are the tell. A human decides which is which.
#
# Exit codes: 0 = clean (warnings allowed), 1 = violations, 2 = usage/self-test failure.

set -uo pipefail

# Accented characters must classify as alpha for the word-boundary regexes.
if locale -a 2>/dev/null | grep -qi '^en_US\.UTF-8$'; then
  export LC_ALL=en_US.UTF-8
elif locale -a 2>/dev/null | grep -qi '^C\.UTF-8$'; then
  export LC_ALL=C.UTF-8
fi

COPY_ONLY=0
SELF_TEST=0
FILES=()

for arg in "$@"; do
  case "$arg" in
    --copy-only) COPY_ONLY=1 ;;
    --self-test) SELF_TEST=1 ;;
    -*) echo "unknown flag: $arg" >&2; exit 2 ;;
    *) FILES+=("$arg") ;;
  esac
done

# ---------------------------------------------------------------------------
# Banned lists. Subsets of references/self-edit.md, weighted toward the
# patterns that actually show up in regressions. The full list lives in the
# reference file; this checker is the tripwire, not the law.
# ---------------------------------------------------------------------------

EN_BANNED=(
  "additionally"
  "align with"
  "at its core"
  "beacon"
  "bolster(s|ed|ing)?"
  "captivat(e|es|ed|ing)"
  "comprehensive"
  "crucial"
  "cutting.edge"
  "delicate dance"
  "delicate balance"
  "delv(e|es|ed|ing) into"
  "dynamic"
  "embark on"
  "empower(s|ed|ing|ment)?"
  "emphasi[sz]ing"
  "enduring"
  "enhanc(e|es|ed|ing)"
  "essentially"
  "ever.evolving"
  "foster(s|ed|ing)?"
  "fundamentally"
  "game.changer"
  "garner"
  "groundbreaking"
  "harness(es|ed|ing)?"
  "highlighting"
  "holistic"
  "i'?d be remiss"
  "in essence"
  "in many ways"
  "in today's (fast.paced )?world"
  "intricate"
  "intricacies"
  "landscape of"
  "leverag(e|es|ed|ing)"
  "meticulous(ly)?"
  "multifaceted"
  "navigate the"
  "noteworthy"
  "paramount"
  "pave the way"
  "pivotal"
  "realm of"
  "revolutionary"
  "robust"
  "seamless(ly)?"
  "showcas(e|es|ed|ing)"
  "spearhead(s|ed|ing)?"
  "streamline(s|d)?"
  "synergy"
  "tapestry"
  "testament to"
  "the beauty of (it|this)"
  "the reality is"
  "the truth is"
  "transformative"
  "underscore(s|d)?"
  "unleash(es|ed|ing)?"
  "unlock(s|ed|ing)? the (potential|power)"
  "unlock(s|ed|ing)? your"
  "utiliz(e|es|ed|ing)"
  "vibrant"
)

ES_BANNED=(
  "potencia(r|do|ndo)"
  "robust[oa]s?"
  "fomenta(r|ndo)"
  "óptim[oa]"
  "innovador[ae]?s?"
  "transforma(r|ndo)"
  "empodera(r|ndo|miento)"
  "sinergi(a|as)"
  "aprovechar al máximo"
  "maximiza(r|ndo)"
  "optimiza(r|ndo|ción)"
  "holístic[oa]"
  "vibrante"
  "cautiva(r|dor)"
  "apasionante"
  "revolucionari[oa]"
  "disruptiv[oa]"
  "trascendental"
  "trascender"
  "multifacétic[oa]"
  "apuntala(r|miento)"
  "implementar"
  "llevar a cabo"
  "posibilita(r|ndo)"
  "facilita(r|ndo)"
  "materializa(r|ndo)"
  "plasma(r|ndo)"
  "en el mundo actual"
  "en la era digital"
  "hoy en día"
  "en la actualidad"
  "en el dinámico mundo"
  "más que nunca"
  "cabe destacar"
  "vale la pena (señalar|mencionar)"
  "en conclusión"
  "en definitiva"
  "en última instancia"
  "al final del día"
  "desbloque(a|á)(r|s)?"
  "libera(r|á) el poder"
  "marca(r|á) la diferencia"
  "construi(r|í) el futuro"
  "súmate al cambio"
  "sumate a la revolución"
  "no es (sólo|solo) .+, es"
  "no se trata de .+, sino"
)

OPENERS=(
  "great question"
  "absolutely[!.]"
  "certainly[!.]"
  "of course[!.]"
  "happy to help"
)

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

# Extract only the copy from a markdown file: blockquote lines plus
# ```copy fenced blocks. Line numbers in the report are relative to the
# extracted copy, not the source file.
extract_copy() {
  awk '
    /^```copy[[:space:]]*$/ { infence = 1; next }
    /^```/                  { if (infence) { infence = 0; next } }
    infence                 { print; next }
    /^>/                    { sub(/^> ?/, ""); print }
  ' "$1"
}

# Dash classifier. Reads a file, prints one line per finding:
#   FAILDASH:<line>:<content>   connector em/en dash (banned)
#   WARNATTR:<line>:<content>   attribution-style dash (review by hand)
DASH_PROG='
  while (<>) {
    my $line = $_;
    chomp $line;
    if ($line =~ /[\x{2014}\x{2013}]/) {
      my $attr = 0;
      if ($line =~ /(^|[.!?"\x{201D}\x{00BB}\x{2019}'"'"'])\s*[\x{2014}\x{2013}]\s*[[:upper:]]/) {
        # Dash preceded by end punctuation (or line start) and followed by a
        # capitalised name: testimonial attribution. Allowed, but flagged.
        $attr = 1 if $line !~ /[\x{2014}\x{2013}].*[\x{2014}\x{2013}]/;
      }
      print(($attr ? "WARNATTR" : "FAILDASH") . ":$.:$line\n");
    }
  }
'

scan_file() {
  local original="$1"
  local hits=0
  local scanfile="$original"
  local scope_note=""

  if [[ $COPY_ONLY -eq 1 ]]; then
    scanfile=$(mktemp)
    extract_copy "$original" > "$scanfile"
    scope_note=" (copy-only scan; line numbers relative to extracted copy)"
  fi

  echo "== $original$scope_note"

  # A copy-only scan of a file with no blockquoted copy would scan nothing
  # and pass vacuously. That is an output-format violation, not a clean run.
  if [[ $COPY_ONLY -eq 1 ]] && ! grep -q '[^[:space:]]' "$scanfile"; then
    echo "FAIL [No blockquoted copy found]: the output format requires shippable copy in markdown blockquotes (>)."
    rm -f "$scanfile"
    echo "FAIL: 1 issue(s) detected in $original"
    return 1
  fi

  scan_pattern() {
    local pattern="$1"
    local label="$2"
    local matches
    matches=$(grep -inE "(^|[^[:alpha:]])${pattern}([^[:alpha:]]|$)" "$scanfile" || true)
    if [[ -n "$matches" ]]; then
      echo "FAIL [$label]:"
      echo "$matches" | sed 's/^/  /'
      hits=$((hits + 1))
    fi
  }

  for w in "${EN_BANNED[@]}"; do scan_pattern "$w" "English banned: $w"; done
  for w in "${ES_BANNED[@]}"; do scan_pattern "$w" "Spanish banned: $w"; done
  for w in "${OPENERS[@]}";   do scan_pattern "$w" "Sycophantic opener: $w"; done

  # Dashes: connector dashes fail, attribution dashes warn.
  local dash_report
  dash_report=$(perl -CSD -e "$DASH_PROG" "$scanfile" 2>/dev/null || true)
  if [[ -n "$dash_report" ]]; then
    local dash_fails dash_warns
    dash_fails=$(echo "$dash_report" | grep '^FAILDASH:' || true)
    dash_warns=$(echo "$dash_report" | grep '^WARNATTR:' || true)
    if [[ -n "$dash_fails" ]]; then
      echo "FAIL [Em/en dash as connector]:"
      echo "$dash_fails" | sed 's/^FAILDASH:/  /'
      hits=$((hits + 1))
    fi
    if [[ -n "$dash_warns" ]]; then
      echo "WARN [Attribution-style dash, allowed in testimonials, review]:"
      echo "$dash_warns" | sed 's/^WARNATTR:/  /'
    fi
  fi

  # Compound-word hyphens: WARN only. Filter the exception list per match,
  # not per line, so one allowed acronym cannot exonerate the rest of a line.
  local hyphen_matches
  hyphen_matches=$(grep -onE "[A-Za-z]+-[A-Za-z]+" "$scanfile" 2>/dev/null \
    | grep -v -iE ":(B2B|B2C|GTM|SaaS|p99|SOC-2|Co-Founder|Co-Authored|MIT-style)$" || true)
  if [[ -n "$hyphen_matches" ]]; then
    echo "WARN [Compound-word hyphen, dictionary compounds are fine, review the invented ones]:"
    echo "$hyphen_matches" | sed 's/^/  /'
  fi

  [[ $COPY_ONLY -eq 1 ]] && rm -f "$scanfile"

  if [[ $hits -eq 0 ]]; then
    echo "PASS: no banned tokens detected in $original"
  else
    echo "FAIL: $hits issue(s) detected in $original"
  fi
  return $hits
}

# ---------------------------------------------------------------------------
# Self-test: the checker must be able to fail. A silently broken detector
# (the grep -P on macOS bug this replaced) reports PASS forever.
# ---------------------------------------------------------------------------

run_self_test() {
  local dirty clean out rc failed=0

  dirty=$(mktemp)
  cat > "$dirty" <<'SAMPLE'
This sentence uses a connector dash — the classic tell.
We leverage robust synergy to unlock the potential of teams.
Vamos a potenciar la sinergia en el dinámico mundo de hoy.
Great question! Absolutely.
SAMPLE

  clean=$(mktemp)
  cat > "$clean" <<'SAMPLE'
Plain copy. Short sentences. A number: 312 pounds saved.
I never read The Economist. — Management trainee. Aged 42.
SAMPLE

  out=$(scan_file "$dirty"); rc=$?
  if [[ $rc -eq 0 ]]; then
    echo "SELF-TEST FAIL: dirty sample passed. Detection is broken."
    echo "$out"
    failed=1
  fi
  for expected in "Em/en dash as connector" "English banned" "Spanish banned" "Sycophantic opener"; do
    if ! echo "$out" | grep -q "$expected"; then
      echo "SELF-TEST FAIL: expected a hit for '$expected' and found none."
      failed=1
    fi
  done

  out=$(scan_file "$clean"); rc=$?
  if [[ $rc -ne 0 ]]; then
    echo "SELF-TEST FAIL: clean sample (attribution dash only) failed; it should pass with a WARN."
    echo "$out"
    failed=1
  fi
  if ! echo "$out" | grep -q "Attribution-style dash"; then
    echo "SELF-TEST FAIL: attribution dash did not produce its WARN."
    failed=1
  fi

  rm -f "$dirty" "$clean"

  if [[ $failed -eq 0 ]]; then
    echo "SELF-TEST PASS: detection working (connector dash, EN, ES, openers, attribution WARN)."
    return 0
  fi
  return 2
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

if [[ $SELF_TEST -eq 1 ]]; then
  run_self_test
  exit $?
fi

if [[ ${#FILES[@]} -lt 1 ]]; then
  echo "usage: $0 [--copy-only] <file> [<file>...]" >&2
  echo "       $0 --self-test" >&2
  exit 2
fi

TOTAL=0
for f in "${FILES[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "error: file not found: $f" >&2
    exit 2
  fi
  scan_file "$f"
  TOTAL=$((TOTAL + $?))
  echo
done

if [[ $TOTAL -eq 0 ]]; then
  exit 0
fi
exit 1
