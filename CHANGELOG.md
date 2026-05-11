# Changelog

All notable changes to the `copy-that-sells` skill.

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
