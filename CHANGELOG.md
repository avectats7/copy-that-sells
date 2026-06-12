# Changelog

All notable changes to the `copy-that-sells` skill.

## [1.3.1]: 2026-06-12

### Fixed: the first real baseline run exposed a copy-vs-commentary gap

The first full 12-prompt eval run produced clean copy in all 12 outputs and 12 failures anyway: every hit came from commentary, not copy. Notes sections reported the self-edit pass by quoting the banned words they avoided; the diagnostic output quoted the user's broken copy to diagnose it; the model's own commentary leaked connector em dashes. Three changes close the gap:

- **Output format now separates copy from commentary structurally.** All shippable copy (final and alternates, in both generation and diagnostic modes) goes in markdown blockquotes; commentary stays outside. The checker and the eval runner scan blockquoted copy only, and an output with no blockquoted copy fails as a format violation instead of passing vacuously.
- **Notes hygiene rules in SKILL.md and self-edit.md.** Never enumerate the banned words you avoided ("banned-list check: clean" is the whole report), and the anti-dash rule applies to commentary too. Diagnostic mode keeps its exemption for quoting the pasted copy.
- **Runner and CI scan outputs with `--copy-only`**, matching how cookbook files were already scanned.

Version bumped to 1.3.1; bundle rebuilt.

## [1.3.0]: 2026-06-12

### Fixed: factual audit of the example libraries

Every doubtful attribution was checked against primary sources (festival archives, trade press, the brands themselves). The skill preaches "never invent proof"; its own proof library now holds to that.

- "Do you make these mistakes in English?" reattributed from John Caples to its actual author, Maxwell Sackheim (1919, Sherwin Cody School). Caples' real classic ("They laughed when I sat down at the piano," 1926) added to the long-copy section.
- Pepsi "Is Pepsi OK?" (2019) reattributed from TBWA\Chiat\Day to Goodby Silverstein & Partners.
- British Airways: "Magic of Flying" award corrected from Cannes Outdoor Grand Prix to Cannes **Direct** Grand Prix 2014 (OgilvyOne London); the 2023 Outdoor Grand Prix entry corrected to "A British Original" (Uncommon) with an accurate description, replacing a conflated write-up with an invented caption line.
- Maxell "Blown Away Guy" credit corrected to Scali McCabe Sloves, 1980, photographed by Steve Steigman.
- "Labour isn't working" reclassified out of the long-copy section (it was an image-plus-line poster, not a long-copy ad) into the cultural-moments section with an accurate description.
- Spanish verbatim library: five unverifiable lines replaced with verified ones. Aquarius now quotes "El ser humano es extraordinario" (Sra. Rushmore); Movistar "Compartida, la vida es más" reattributed to Mother London, 2008; Banco Galicia's invented line replaced by Quilmes "El sabor del encuentro" (era Agulla & Baccetti); YPF's invented line replaced by the verified "Si te digo Energía Argentina, decís YPF" (2024); Águila corrected to "Sin igual y siempre igual"; DGT replaced with the verified 2025 line "En un siniestro de tráfico puedes morir o perder tu vida"; Doritos corrected to "Para los atrevidos"; Mercado Libre corrected to "Encontrá lo que buscás."
- New editorial rule in both example files: no entry ships without a verified attribution; unverifiable entries get replaced, not defended.
- Self-reported counts corrected across the repo: examples.md header now says 122 (was "Seventy-plus"); cookbook 04's word count corrected to the measured 129 (was 122); cookbook 05's character counts corrected to the measured 22 and 166 and 134 (were 23, 167, 162). Notes must now report measured counts, not estimates.
- Metadata and credits: award-window claims corrected from "2001-2026" to "2001-2025" (Cannes 2026 has not happened yet); anti-AI ruleset reference updated from "era 1-3" to "era 1-4."

### Fixed: tooling

- `evals/check_banned_words.sh` rewritten. The previous version used `grep -P`, which macOS BSD grep rejects; the error was silenced, so **em dashes were never detected on macOS and the checker reported PASS on files that should fail**. Dash detection now runs in perl (portable), with a `--self-test` mode so a broken detector can never silently pass again. Also fixed: the per-line exception filter that let one allowed acronym exonerate a whole line (now per-match), the hyphen WARN whose comment claimed half-weight scoring that did not exist (now an honest warning), and the `bolstered?` regex that missed "bolster"/"bolsters."
- CI now actually runs the checker (the previous workflow only verified the dist bundle): a new `lint` job runs the self-test, scans cookbook copy in `--copy-only` mode, and scans any saved eval outputs on every PR.

### Added

- **Schwartz's five levels of awareness and market sophistication** in `frameworks.md`, with a mapping table from awareness level to headline category, lead type, and copy length. The briefing pass now names the awareness level; the headline pass selects categories by it. This is the selector that decides which of the skill's own tools apply.
- **The So-What ladder** (feature, advantage, benefit, deeper benefit) in `frameworks.md`: Bly's features-into-benefits move, with the double "so what?" test.
- **The Research Pass** in SKILL.md: when the product is real, fetch the current landing page, mine voice-of-customer language, and read competitor headlines before the idea pass. Research informs copy; it never enters copy unverified.
- **The Offer Pass** in SKILL.md, between body and CTA: the deal, the guarantee (specific, ideally tied to the promise), honest urgency (never manufactured), and bonuses that solve the buyer's next problem.
- **A four-question idea selection test** in SKILL.md, replacing the adjectives ("sharpest, freshest") with operable criteria: meets the reader's awareness level, the competition could not sign it, survives the billboard test, slightly uncomfortable to publish.
- **Diagnostic mode now asks for data**: traffic source and current-vs-expected rate before blaming the words, plus a legitimate "the copy is not the problem" outcome and two new symptom-table rows (offer/price/audience failure, awareness mismatch by traffic source).
- **Three native Spanish voices** in the voice bank (Voice 13 porteña seca, Voice 14 mexicana directa, Voice 15 castellana conceptual), cross-linked with `spanish-craft.md`, plus a country question in the 60-second picker.
- **Paid search rewritten for responsive search ads** (the 3-headline expanded text ad format died in 2022): headline inventory by job, all four descriptions, pinning trade-offs.
- **Email preheader guidance**: the 40 to 90 characters the inbox shows after the subject, written as the subject's next thought.
- **A 15-structure hook bank** for paid social in `formats.md`, grouped by mechanism and mapped to awareness levels.
- **Regulated-category compliance checklist** in `self-edit.md` Layer 3 (fintech, health, legal, alcohol/gambling/lending, comparative claims), and a compliance flag added to the App Store cookbook's APY and FDIC claims.
- **`evals/run_evals.sh`**: headless eval runner via `claude -p` with the skill loaded; saves outputs, runs the checker, optional `SCORE=1` critic pass against the rubric.
- **Rubric dimension 6, diagnostic discipline** (diagnostic prompts score out of 30): diagnose before rewriting, reference the five questions, make the edit/restructure/burn-down call, teach the lever.

### Changed

- Dash rule scoped in `self-edit.md`: connector em/en dashes stay banned; the testimonial attribution dash ("quote. — Name") is now an explicit exception, because the skill's own gold standard (the Economist line) depends on it. The checker enforces the same split (FAIL connector, WARN attribution).
- Compound-hyphen rule scoped: invented decorative compounds stay banned; standard dictionary compound modifiers ("high-yield," "4-hour," "money-back") keep their hyphen, ending the grammatically wrong "high yield savings account" outputs. Cookbook copy updated accordingly.
- `examples.md` moved out of the read-on-every-task core (its own usage notes say "when stuck"); the core is now three files, saving roughly 5k tokens per task with no behaviour change.
- SKILL.md description now states boundaries against adjacent skills (page structure belongs to CRO/page skills, non-sales editing to editing skills).
- Version bumped to 1.3.0 in `SKILL.md` and `.claude-plugin/plugin.json`; bundle rebuilt.

## [1.2.0]: 2026-05-26

### Added
- `references/spanish-craft.md`. Full Spanish writing reference. The 20 percent rule, verb position, regional variants (rioplatense, mexicano, castellano, andino, caribeño), vos/tú/usted decision tree, banned Spanish vocabulary and phrases, 16 verbatim Cannes/Clio LatAm headlines with rationale, list of LatAm and Spanish maestros to study.
- `references/formats.md`. Per-format blueprints with word counts, structures, dos and don'ts for: email subject line, cold email, lifecycle email, landing page hero, pricing page, sales page, product page, billboard/OOH, paid social, paid search, push notification, App Store listing, manifesto, pre-roll video script.
- `references/voice-bank.md`. Twelve named voices with two-line samples each: dry confident, quiet intimate, manifesto, folksy slow, conspirator, sober authority, cheeky rebel, founder narrator, technical precise, hostile funny, plain spoken trader, public service grave. Each includes when to use, when to avoid, and brand examples.
- `references/diagnostics.md`. Critique-first procedure for when the user pastes existing copy. Five-question diagnostic. Symptom-cause-fix table. Edit vs Restructure vs Burn down decision. Diagnostic output format.
- `cookbook/`. Five end-to-end worked examples with brief, full output, and postmortem: billboard for a LatAm fintech (Spanish, OOH), B2B SaaS pricing page (English, conversion structure), DTC manifesto (English, voice-first), founder cold email (English, outbound), App Store listing (English, ASO + selling).
- `evals/`. Lightweight regression suite. 12 test prompts, scoring rubric, static checker (`check_banned_words.sh`) that scans output files for banned English and Spanish vocabulary, em dashes, en dashes, and compound-word hyphens.
- `scripts/build-skill.sh`. Reproducible build script for the `.skill` bundle. Idempotent, runs in CI.
- `.github/workflows/build.yml`. CI workflow that rebuilds the bundle on PRs and verifies that committed `dist/` matches source.

### Changed
- `SKILL.md`. Added a two-mode workflow (generation vs diagnostic) and a brief-detection branch so the skill no longer interrogates users who have already supplied a complete brief. Expanded the CTA pass into a full section with a verb bank by commitment level, microcopy patterns, and a mirror test. Output format now requires word count and voice name in the Notes block.
- `references/frameworks.md`. Added three modern headline categories as extensions to Bly's eight: Listicle, Negative, Outcome-first. Each with when-it-works and when-it-fails guidance.
- `references/self-edit.md`. Added Era 4 banned words (Claude 4.x and Opus 4.5 to 4.7 generation, 2026 fingerprints). Added a full Spanish banned-word and banned-phrase section. Split the master quick-reference list into English and Spanish.
- `README.md`. Expanded the "What's inside" section to reflect the new file inventory. Added two new before/after examples (founder cold email, Spanish OOH). Updated the repo-structure diagram.
- Version bumped to 1.2.0 in `SKILL.md` and `.claude-plugin/plugin.json`.

### Notes
- The skill more than doubled in surface area in this release: from 4 reference files to 8, plus a five-example cookbook and an eval suite. The reading discipline is unchanged. Read the core four on every task, add format and Spanish files when relevant, dip into voice-bank and diagnostics when the workflow calls for them.
- The bundle in `dist/copy-that-sells.skill` was rebuilt from the new source via `scripts/build-skill.sh`.

## [1.1.1]: 2026-05-12

### Changed
- Dogfooding pass. Stripped all em dashes (—) from the skill's own prose. The skill teaches "no em dashes in copy" so the skill files now follow that rule. Em dashes inside historical ad quotes (notably the Economist "I never read The Economist. — Management trainee. Aged 42." line) are preserved because the dash is part of the original copy as it ran.
- Section headings that previously used " — " now use ": " (cleaner read in section titles anyway).
- Quick-reference file lists in `SKILL.md` switched from " — description" form to ". Description." form.
- Bullet labels in `references/frameworks.md` and `references/examples.md` cleaned of em-dash connectors.

### Notes
- No behavioural change. Same workflow, same references, same example library. The skill itself does not run any differently.
- Bundle in `dist/copy-that-sells.skill` rebuilt from the cleaned source.

## [1.1.0]: 2026-05-11

### Added
- Section 17 in `references/examples.md`: Latin-American agency print to study. AlmapBBDO, DM9DDB, DAVID, Africa, Sancho BBDO, Ogilvy & Mather Mexico, Leo Burnett Mexico City. Spanish-language copy notes.
- Clio Award winners woven into existing technique sections: The Zimbabwean "Trillion Dollar Campaign" (TBWA\Hunt\Lascaris), Havaianas Nest (AlmapBBDO), British Heart Foundation "Til I Died" (Saatchi & Saatchi London).
- Full Era 1, Era 2, Era 3 AI-tells ruleset in `references/self-edit.md`, including the compound-word hyphen rule and the weak-verb substitution table.
- Master banned-word quick-reference list at the bottom of `references/self-edit.md`.

### Changed
- `SKILL.md` metadata source string updated to credit Cannes Lions and Clio Award archives plus the full anti-AI writing ruleset.

## [1.0.0]: 2026-05-11

### Added
- Initial release. `SKILL.md` workflow (briefing, idea, headline, body, CTA, self-edit).
- `references/frameworks.md`: Bly's eight headline categories, the 4 U's, AIDA, PAS, BFD, six lead types, seven-step direct-response letter, long-copy sales-page architecture, reason-why copy, voice-of-customer mining, direct-response checklists.
- `references/craft.md`: D&AD Copy Book lessons. Idea before words, headline-and-visual logic, compression, voice and rhythm, reading aloud, truth and self-deprecation, long-copy seduction, what to do when nothing is working.
- `references/examples.md`: 100+ campaigns across 16 technique sections. Mix of timeless classics and Cannes Lions Print and Outdoor Grand Prix winners 2001 to 2026.
- `references/self-edit.md`: Three-layer final pass. Craft check, AI-tells, truth check.
