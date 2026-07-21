# Copy That Sells 🎯

A Claude Code Skill that writes award-winning, sales-driving copy — built on D&AD Copy Book craft, Bly direct-response frameworks, and Cannes Lions + Clio Award winners.

> **"Every word must earn its place."**

## What It Does

Generates:
- **Headlines** — Bly's 4U formula (Urgent, Unique, Ultra-specific, Useful)
- **Taglines** — brand positioning in 5-7 words
- **Billboards / OOH** — one visual idea, 7 words or less
- **Print Ads** — long and short form
- **Landing Pages** — Before/After/Bridge + social proof structure
- **Emails** — PAS (Problem, Agitate, Solve) framework
- **Manifestos** — brand belief statements
- **Product Descriptions** — feature → benefit → outcome

## Installation

```bash
# Clone into your Claude skills directory
git clone https://github.com/avectats7/copy-that-sells.git ~/.claude/skills/copy-that-sells

# Or copy just the SKILL.md to your skills folder
mkdir -p ~/.claude/skills/copy-that-sells
cp SKILL.md ~/.claude/skills/copy-that-sells/
```

## Quick Start

```
@copy-that-sells Write a headline for a premium mattress targeting sleep-deprived professionals
```

## Input Requirements

For best results, provide:

| Field | Required | Example |
|-------|----------|---------|
| Brand name | ✅ | "Napwell" |
| Product | ✅ | "Organic latex mattress" |
| Target audience | ✅ | "Sleep-deprived professionals, 30-45, high income" |
| Key benefit | ✅ | "Fall asleep in under 10 minutes" |
| Tone | ✅ | "Confident but empathetic" |
| Format | ✅ | "headline" / "landing_page" / "email" / etc. |
| Constraints | ❌ | "Max 8 words" / "Must rhyme" |
| Competitor context | ❌ | "Vs. Casper, Purple" |

## Output Format

Every response includes:
1. **Strategy Note** — why this approach works
2. **3 Variations** — different angles
3. **Recommended** — top pick with reasoning
4. **Anti-AI Score** — self-assessment (1-10)

## Commands

| Command | What It Does |
|---------|-------------|
| `/shorter` | Tighten copy, cut 30% |
| `/punchier` | More impact, stronger verbs |
| `/softer` | Less aggressive, more empathetic |
| `/longer` | Expand into long-form |
| `/test-headline` | Score against swipe file |
| `/anti-ai-check` | Audit for AI-tells |

## Examples

See [`examples/`](examples/) for real-world before/after outputs.

## Validation

Run quality checks:
```bash
python scripts/validate.py "Your headline here"
```

## License

MIT — see [LICENSE](LICENSE).

## Companion Tool

Pair with [`anti-ai-writing`](https://github.com/avectats7/anti-ai-writing) to clean up existing drafts.
