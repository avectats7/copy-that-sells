# Anti-AI Quick Fixes

The fast-fix companion to `self-edit.md`. When a line trips the banned-word check, or just smells like a model wrote it, this is how you fix it in one pass.

This file is deliberately **not** a banned-word list. Two places own that, and a third hand-kept copy would only drift from them:

- **`references/self-edit.md`** — the canonical prose ruleset: English Era 1 to 4, the full Spanish list, structural patterns, and the quick-reference master lists. This is the authority.
- **`references/banned-patterns.txt`** — the machine-readable list the scorer (`scripts/validate.py`) and the CI checker (`evals/check_banned_words.py`) both read. New words go here.

Use this file for the move you make *after* something is flagged: the human word that replaces the AI one, the shape that replaces the AI shape.

## The swap table

The tell is on the left. The right column is a starting point; the exact word depends on the sentence.

| AI word | Say instead |
|---|---|
| leverage | use, put to work, wield |
| utilize | use |
| optimize | fix, tune, make faster |
| empower | let, give you the tools to |
| unlock | open, get, reach |
| delve into | dig into, look at |
| seamless | easy, smooth, no setup |
| robust | solid, holds up, tested |
| revolutionary | new, different, first |
| transformative | changes how you work |
| holistic | complete, end to end |
| streamline | speed up, cut steps |
| drive (growth) | grow, push, add |
| harness | use, tap |
| synergy | working together |
| bandwidth (figurative) | time, room |
| actionable insights | what to do next |
| deep dive | the detail, a closer look |
| move the needle | change the number, matter |
| circle back | follow up, come back to it |
| at the end of the day | in the end, what matters is |
| going forward | from now on, next |

Spanish swaps live in `spanish-craft.md`; the logic is the same (potenciar → mejorar or hacer crecer, aprovechar → usar, optimizar → afinar).

## Structural fixes (before, after)

The banned-word check catches vocabulary. These are the shapes that read as AI even when every word is clean. `self-edit.md` lists them; here is how each one looks fixed.

### Passive to active
- AI: The product is designed to save time.
- Human: We built this to save you time.

### Adjective pile to one strong adjective (or a fact)
- AI: our innovative, cutting-edge, reliable solution
- Human: the only mattress tested 10,000 times before it ships

### Abstract to concrete
- AI: our commitment to excellence drives outcomes
- Human: we test every unit 10,000 times before it leaves the factory

### Hedge to commitment
- AI: this may help you potentially get better results
- Human: fall asleep in 8 minutes or your money back

### List of adjectives to varied rhythm
- AI: innovative, reliable, and scalable
- Human: It works. It lasts. It does not break.

### Generic opener to specific hook
- AI: In today's world, businesses face many challenges.
- Human: Your competitor just took your best customer.

## Three fast tests

### The So-What test
Ask "so what?" three times. Each answer digs one level closer to the reason a person actually acts.
- Line: Our software streamlines your workflow.
- So what? You save time.
- So what? You get home for dinner.
- So what? Your kids remember what you look like.
- Rewrite: Be home for dinner. Two hours back, every day.

### The read-aloud test
Say it out loud. Stumble over a word, cut it. Sounds like a press release, rewrite it. Would not say it to a friend, change it.

### The 1995 test
Would the line still work in 1995? If it only makes sense riding a trend ("AI-powered blockchain platform"), it will date. "The pen that never leaks" will not.
