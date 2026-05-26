# Changelog

All notable changes to the `copy-that-sells` skill.

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
