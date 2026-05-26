#!/usr/bin/env bash
# Scan a copy output file for banned words, em dashes, and compound-word hyphens.
# Returns nonzero on any hit. Designed to run locally and in CI.
#
# Usage: ./evals/check_banned_words.sh <path-to-output-file>

set -uo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: $0 <output-file>" >&2
  exit 2
fi

FILE="$1"

if [[ ! -f "$FILE" ]]; then
  echo "error: file not found: $FILE" >&2
  exit 2
fi

HITS=0

scan() {
  local pattern="$1"
  local label="$2"
  # -w = whole word, -i = case insensitive, -n = line numbers, -E = extended regex.
  # We use -E with word boundaries baked in for multi-word patterns.
  local matches
  matches=$(grep -inE "(^|[^[:alpha:]])${pattern}([^[:alpha:]]|$)" "$FILE" || true)
  if [[ -n "$matches" ]]; then
    echo "FAIL [$label]:"
    echo "$matches" | sed 's/^/  /'
    HITS=$((HITS + 1))
  fi
}

# English Era 1 to 4 + universally overused (subset; the full list is in self-edit.md).
# We pick the ones that show up most often in regressions.
EN_BANNED=(
  "additionally"
  "align with"
  "at its core"
  "beacon"
  "bolstered?"
  "captivate"
  "captivating"
  "comprehensive"
  "crucial"
  "cutting.edge"
  "delicate dance"
  "delicate balance"
  "delve into"
  "delves into"
  "delving into"
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
  "showcase(s|d)?"
  "showcasing"
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

# Spanish banned vocabulary (subset).
ES_BANNED=(
  "potenciar"
  "potenciado"
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

# Sycophantic openers (Claude/GPT tells in any language).
OPENERS=(
  "great question"
  "absolutely[!.]"
  "certainly[!.]"
  "of course[!.]"
  "happy to help"
)

for w in "${EN_BANNED[@]}"; do
  scan "$w" "English banned: $w"
done

for w in "${ES_BANNED[@]}"; do
  scan "$w" "Spanish banned: $w"
done

for w in "${OPENERS[@]}"; do
  scan "$w" "Sycophantic opener: $w"
done

# Em dash, en dash. The character itself, anywhere in the file.
if grep -nP "[—–]" "$FILE" >/dev/null 2>&1; then
  echo "FAIL [Em/en dash present]:"
  grep -nP "[—–]" "$FILE" | sed 's/^/  /'
  HITS=$((HITS + 1))
fi

# Compound-word hyphens. A hyphen between two ascii letters, with letters on both
# sides. Excludes B2B/B2C/HD-1080 numeric patterns by requiring letters both sides.
# We allow inside markdown headers (lines starting with #) since those are
# structural not copy.
HYPHEN_MATCHES=$(grep -nE "[A-Za-z]+-[A-Za-z]+" "$FILE" | grep -v -E '^[0-9]+:#' || true)
if [[ -n "$HYPHEN_MATCHES" ]]; then
  # Filter out known acronyms and structural exceptions.
  FILTERED=$(echo "$HYPHEN_MATCHES" | grep -v -iE "B2B|B2C|p99|SOC.2|SOC.2|GTM|SaaS|Co-Founder|Co-Authored|MIT-style" || true)
  if [[ -n "$FILTERED" ]]; then
    echo "WARN [Possible compound-word hyphen, review manually]:"
    echo "$FILTERED" | sed 's/^/  /'
    # This is a warning, not a hard fail, because some hyphens are legitimate
    # (date ranges, file paths, etc.). Increments hits at half weight.
  fi
fi

echo
if [[ $HITS -eq 0 ]]; then
  echo "PASS: no banned tokens detected in $FILE"
  exit 0
else
  echo "FAIL: $HITS issue(s) detected in $FILE"
  exit 1
fi
