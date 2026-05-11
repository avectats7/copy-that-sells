# Copy That Sells

> A Claude skill that writes copy which sells. Print ads, OOH, headlines, landing pages, emails, manifestos. Built on D&AD Copy Book craft, Robert Bly direct-response frameworks, and Cannes Lions plus Clio Award print and OOH winners from the last twenty-five years.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE) [![Claude Code](https://img.shields.io/badge/Claude-Code-orange)](https://claude.com/claude-code) [![Claude Cowork](https://img.shields.io/badge/Claude-Cowork-orange)](https://claude.com) [![Skills](https://img.shields.io/badge/skill-copywriting-purple)](skills/copy-that-sells/SKILL.md)

If you have ever asked Claude to write an ad and it came back with "unlock the potential," "delve into," or "in today's fast-paced world," this skill is the fix. The Claude default voice is corporate. The copywriting tradition that made Volkswagen, Avis, Economist, Patek Philippe, Nike, and Penny famous is not. This skill loads the second tradition.

**Two install paths in one repo.** Claude Code users install it as a plugin. Claude Cowork users drop in the bundled `.skill` file. Same skill, same references, both audiences.

---

## What's inside

A single skill, `copy-that-sells`, with one entry point and four reference files.

- `SKILL.md` (193 lines). The workflow. Briefing pass, idea pass, headline pass, body pass, CTA pass, self-edit pass. Decides what the skill does and when it runs.
- `references/frameworks.md` (255 lines). Bly's eight headline categories. The 4 U's. AIDA. PAS. BFD. The seven-step direct-response sales letter. Long-copy architecture for sales pages. Voice-of-customer mining. Checklists.
- `references/craft.md` (191 lines). The D&AD Copy Book in working form. Find the idea before the words. Make headline and visual one unit. Compress. Vary rhythm. Read aloud. Truth against self. Long-copy seduction. What to do when nothing works.
- `references/examples.md` (253 lines). 122 individual campaigns organised into 17 technique sections. Mix of timeless classics and recent Cannes Lions plus Clio winners. Lookup table you scan when stuck.
- `references/self-edit.md` (149 lines). Three-layer final pass. Craft check, anti-AI tells (Era 1 / Era 2 / Era 3 banned word list plus compound-hyphen rule and weak-verb table), truth check. Stops AI tells before they ship.

The skill works in any language. It writes Spanish in Spanish, not as a translation. Latino Spanish and Castilian Spanish are treated as different.

---

## Install

### For Claude Code users

Add the plugin from this repo. Two commands.

```bash
/plugin marketplace add avectats7/copy-that-sells
/plugin install copy-that-sells
```

Skills are auto-discovered. After install, the `copy-that-sells` skill is available in any Claude Code session. It triggers on phrases like "write an ad," "billboard copy," "headline ideas," "rewrite this so it sells."

To uninstall:

```bash
/plugin uninstall copy-that-sells
/plugin marketplace remove avectats7/copy-that-sells
```

### For Claude Cowork users

Download the packaged skill file:

[**Download copy-that-sells.skill**](dist/copy-that-sells.skill)

In Cowork, open the file. Cowork will offer to install the skill. After install, mention copywriting in a Cowork conversation and the skill loads itself.

### For manual install (any environment running Claude with skill support)

Clone the repo and copy the skill folder into your local skills directory.

```bash
git clone https://github.com/avectats7/copy-that-sells.git
cp -r copy-that-sells/skills/copy-that-sells ~/.claude/skills/
```

Path varies by client. Check your environment's skills directory.

---

## When the skill triggers

The skill is built to trigger on real copywriting requests, not generic writing requests. Tells that fire it:

- "Write an ad for..."
- "Write a billboard for..."
- "Headline ideas for..."
- "Tagline for..."
- "Rewrite this so it converts"
- "Make this hero stronger"
- "Make this email punchier"
- "I need 5 headlines for..."
- "Write outdoor copy for..."
- "Write a manifesto for..."
- "Write long-copy for..."

When it triggers, it runs a structured workflow: briefing → idea → headline → body → CTA → self-edit. It refuses to write past missing brief inputs (audience, promise, proof, CTA, voice). It produces an output block with the idea, the final copy, alternates, and notes.

---

## What this is and what it is not

### What it is

A persuasion skill. The job is to write copy that gets read and acted on. Print ads, OOH, headlines, taglines, hero sections, landing pages, paid social, emails, product descriptions, manifestos, sales letters, deck cover slides.

A craft skill. It runs a workflow rather than guessing. The workflow is the difference between random good lines and reliable good copy.

A truth skill. It never invents proof. Numbers, testimonials, comparisons, claims. All must be supplied or verifiable.

### What it is not

A long-form blog or article skill. Those are persuasive but their job is to inform or entertain. Use a different skill for that.

A naming or visual identity skill. Naming is upstream of copy.

A reports and memos skill. Internal documents want clarity, not selling.

---

## Why this skill exists

Most Claude output is technically correct and commercially dead. It hedges. It uses "leverage" as a verb. It opens with "in today's fast-paced world." It reaches for the rule of three by reflex. It pads.

The copywriting tradition that built the modern advertising industry rejects every one of those moves. Bill Bernbach, David Ogilvy, David Abbott, Tim Delaney, Tony Cox, Indra Sinha, John Webster, Lee Clow, Robert Bly, Claude Hopkins. They wrote short. They wrote specific. They wrote with a stance. They sold things.

This skill teaches Claude that voice. The references are the syllabus. The workflow is the rehearsal. The self-edit is the standard.

---

## What good looks like (a quick before-and-after)

**Before** (Claude default, generic AI voice)

> Unlock the potential of your inbox with our innovative email platform. In today's fast-paced world, staying connected is more important than ever. Our seamless solution helps you delve into deeper conversations while showcasing key features that drive meaningful impact.

**After** (using this skill, applied to the same brief)

> Most inbox tools assume you want more email. We assume you want less. Our app reads your week, drafts your replies, surfaces the three things actually waiting on you. Try it free for ten days. If your inbox is not lighter on day eleven, we will refund you and write you an apology by hand.

Same product. Different tradition.

The second version uses self-deprecation against the category, specificity (three things, ten days, day eleven), reason-why proof (the mechanism, briefly), risk reversal (refund plus apology), and a CTA that continues the promise. None of these moves are accidental. They are in the references.

---

## Example output format

When you ask the skill for copy, it returns four blocks.

```
Idea
A single sentence stating what the reader walks away believing.

Final copy
The actual copy, ready to ship. No annotation.

Alternates
2 to 4 alternates of the headline and CTA. One-line rationale each.

Notes
Which framework or principle is doing the work. Assumptions made.
Open questions that would sharpen the copy further.
```

This makes the work auditable. You see the idea behind the line. You see what would change if you wanted a different lever pulled.

---

## Frequently asked questions

### What is the Copy That Sells skill?

A skill for the Claude family of products (Claude Code, Claude Cowork, the Claude desktop and web apps) that teaches Claude the craft and structure of conversion copywriting. It runs a structured workflow whenever the user asks for copy that should sell. The skill bundles four reference files covering Bly's direct-response frameworks, D&AD Copy Book craft principles, 122 award-winning ad examples, and a final self-edit pass that strips AI tells.

### Who is this for?

Founders writing their own landing pages. Marketing operators building campaigns. Agency creatives prototyping with AI. Solopreneurs writing emails and social. Anyone who would rather have Claude write like a copywriter than like an LLM.

### How is this different from a generic AI copywriting prompt?

A prompt is a one-shot instruction. A skill is a workflow Claude loads on its own, with references it consults as needed. The skill makes Claude do the briefing pass before writing. It generates ideas before headlines. It runs a multi-pass self-edit. It refuses to write past missing inputs. A prompt cannot do those things reliably.

### How is this different from the Anthropic-published Ogilvy and copywriting skills?

The Anthropic-published `ogilvy` skill is excellent and narrower. It applies David Ogilvy's specific advertising principles. The Anthropic-published `copywriting` skill is also excellent and aimed at marketing pages. This skill, `copy-that-sells`, combines a wider Copy Book tradition with Bly's direct-response toolkit, treats print and OOH as the gold standard, and adds an explicit anti-AI writing layer. Different tools for different jobs. Install all three if you want range.

### Does it work in Spanish?

Yes. The skill writes Spanish in Spanish rather than translating from English. It treats Latino Spanish and Castilian Spanish as different and asks if the brief is unclear about which. The reference files are in English but the writing they instruct is language-agnostic.

### What award shows does the example library reference?

Cannes Lions Print and Outdoor (Grand Prix winners and notable shortlisted work, 2001 to 2026). Clio Awards (Grand Clio and Gold for Print and OOH). D&AD Pencils. One Show. Plus pre-2001 classics from the agency tradition (DDB, Doyle Dane Bernbach, Saatchi & Saatchi, Ogilvy & Mather, AMV BBDO, BBDO, JWT, Leo Burnett, Wieden+Kennedy, CDP, AlmapBBDO).

### Can I use this commercially?

Yes. MIT license. Use it, modify it, ship it. Attribution is appreciated but not required.

### How do I contribute?

See [CONTRIBUTING.md](CONTRIBUTING.md). Pull requests welcome for new example campaigns, additional frameworks, translation notes, and bug fixes to the skill itself.

### Will this skill make my copy good?

It will make your copy better. The skill is a craft amplifier, not a substitute for the briefing work only you can do. A bad brief plus this skill produces sharper bad copy. A good brief plus this skill produces copy you can ship.

---

## Repo structure

```
copy-that-sells/
├── .claude-plugin/
│   ├── plugin.json              Claude Code plugin manifest
│   └── marketplace.json         Single-plugin marketplace manifest
├── skills/
│   └── copy-that-sells/
│       ├── SKILL.md             Entry point. The workflow.
│       └── references/
│           ├── frameworks.md    Bly. AIDA. PAS. Eight headline types.
│           ├── craft.md         D&AD Copy Book lessons.
│           ├── examples.md      122 campaigns by technique.
│           └── self-edit.md     Anti-AI rules. Final pass.
├── dist/
│   └── copy-that-sells.skill    Cowork-ready zipped bundle.
├── docs/
│   ├── examples-preview.md      Teaser of the example library.
│   └── install.md               Detailed install guide.
├── README.md                    This file.
├── LICENSE                      MIT.
├── CONTRIBUTING.md              How to add examples or fix bugs.
└── CHANGELOG.md                 Version history.
```

---

## Credits and sources

This skill stands on four bodies of work.

- **The Copy Book** (D&AD, multiple editions). Essays from 32+ great copywriters including Bill Bernbach, David Abbott, Tim Delaney, Tony Cox, Indra Sinha, Neil French, John Webster, Adrian Holmes, Tony Brignull, Lionel Hunt, Norman Berry, Steve Hayden, Lee Clow.
- **The Copywriter's Handbook** by Robert Bly. The standard direct-response copywriting reference, in its multiple editions.
- **Cannes Lions International Festival of Creativity**. Print and Outdoor Grand Prix winners and notable work, 2001 to 2026. Archive at [canneslions.com](https://www.canneslions.com).
- **The Clio Awards**. Grand Clio and Gold winners for Print and OOH, 2001 to 2026. Archive at [clios.com](https://clios.com/awards/winners/).

Adjacent references and galleries used during research:
- [Ads of the World](https://www.adsoftheworld.com) by The Clio Network
- [D&AD Pencil archive](https://www.dandad.org/awards/)
- [Lürzer's Archive](https://www.luerzersarchive.com)

If you build on this skill, an acknowledgement is appreciated.

---

## Maintainer

Tato Polanco. Senior marketing operator. 10+ years in fintech, SaaS, and Web3. Six Telly Awards including one for copywriting. Based in Vigo, Spain.

GitHub: [@avectats7](https://github.com/avectats7)

---

## Keywords

For people and search engines who find this page by accident: this is a Claude skill, a Claude Code skill, a Claude Cowork skill, a copywriting skill, an AI copywriting plugin, a marketing copy assistant, an ad copy generator, a headline generator, a landing page copy tool, a long-copy ad writer, a direct-response copywriter for AI, a Bly-style copywriting skill, an Ogilvy-tradition copywriting skill, a D&AD Copy Book skill, a Cannes Lions inspired skill, a Clio Award inspired skill, an anti-AI writing tool, a copy editor for AI output, a tagline writer, a manifesto writer.

That is the SEO paragraph. The rest of this page is the truth.
