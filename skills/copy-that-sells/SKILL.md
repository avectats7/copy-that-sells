---
name: copy-that-sells
description: Write copy that gets attention and makes the reader act. Print ads, OOH/billboards, headlines, taglines, long-copy ads, landing pages, ads, emails, social, product descriptions, manifestos. Use this skill when the user wants copy that sells, not decoration. Triggers on phrases like "write an ad," "write a headline," "billboard copy," "outdoor copy," "tagline," "manifesto," "long copy," "print ad," "rewrite this so it sells," "make this convert," "make this hit," "make this stronger," or when the user shares a draft and wants it sharper. Combines D&AD Copy Book craft with Bly direct-response frameworks and Schwartz awareness levels. Use this skill and not generic writing when the goal is persuasion, not information. Do not use it for long-form articles or blog posts (use a content skill), or to remove AI tells from prose that does not sell (use an editing skill). This skill owns the copy whose job is to convert.
metadata:
  source: "The Copy Book (D&AD, 32+ great copywriters) + The Copywriter's Handbook (Robert Bly) + Breakthrough Advertising (Eugene Schwartz, awareness framework) + Cannes Lions and Clio Award Print & Outdoor winners 2001-2025, attributions verified + Tats anti-AI writing rules (full era 1-4 banned word/phrase/structure ruleset)"
  version: 2.1.0
---

# Copy That Sells

You write copy that people must read, remember and act on. You do not write copy that only fills a space.

This skill uses two traditions:

- **Craft.** The D&AD Copy Book teaches an idea worth having, words worth using, and a visual and a line that work together.
- **Direct response.** The Copywriter's Handbook by Bly teaches structured headlines, structured leads and structured arguments that convert.

The best copy uses both. The strongest line on a billboard and the best opening of a sales email come from the same skill at different lengths.

The print and OOH posters that win Cannes Lions are the standard for compression. If a headline and an image can carry the idea on a billboard with nothing else, the idea is good. Apply the same test to a homepage hero, a paid social ad, a subject line and a deck cover slide. If the copy does not work as a poster, it is probably not finished.

---

## Read These Before You Write

If the copy task is not trivial, read the reference files. They are short and dense.

**Core craft (read for every task):**
- `references/frameworks.md`. Schwartz's awareness levels and market sophistication, Bly's headline categories, the modern extensions (Listicle, Negative, Outcome-first), the 4 U's, the So-What ladder, AIDA, PAS, BFD, structured leads, long-copy architecture, direct-response checklists.
- `references/craft.md`. D&AD Copy Book lessons: idea-first thinking, headline-visual logic, compression, voice, rhythm, the test of reading aloud.
- `references/self-edit.md`. The final checklist. It includes the anti-AI writing rules (English Era 1 to 4 and Spanish). Every output must obey these rules.

**Format and language (read when relevant):**
- `references/formats.md`. Blueprints for each format, with word counts: subject line, cold email, landing hero, pricing page, sales page, billboard, paid social (with hook bank), paid search (RSA), push, App Store, manifesto, pre-roll.
- `references/spanish-craft.md`. The 20 percent rule, verb position, regional variants (rioplatense, mexicano, castellano, andino, caribeño), vos/tú/usted, banned Spanish vocabulary, verbatim LatAm winners. Read it for every Spanish task.
- `references/voice-bank.md`. Fifteen voices with two-line samples each, including three native Spanish registers. Use it when there is no voice guide, or when the symptom is "it does not sound like us."
- `references/diagnostics.md`. The critique-first procedure for copy that the user pastes. It has a symptom-cause-fix table and the Edit, Restructure or Burn down decision.

**Lookup (read when you are stuck or need a way in):**
- `references/examples.md`. 152 print, OOH, social and direct-response examples with verified attribution. They are in 19 technique and benchmark sections, plus tonal masterclasses. Open the section for the technique that your idea needs. Read three or four entries aloud. Then write.
- `references/swipe-file.md`. A shorter swipe file with format tags. Use it when you want two or three proven patterns quickly, without the full examples library.
- `references/anti-ai-rules.md`. The quick anti-AI companion to `self-edit.md`. It has a plain-English swap table (leverage → use, unlock → open, seamless → easy), before/after structural fixes and three fast tests (So-What, read-aloud, 1995). Use it to fix a marked line quickly. It is not a banned list. `self-edit.md` (prose) and `references/banned-patterns.txt` (machine) own the banned list, so this file cannot become different from them.
- `cookbook/`. Five full worked examples: billboard (Spanish), pricing page, manifesto, cold email and App Store listing. Each example has the brief, the full output and a postmortem.

**Templates (optional scaffolds, not fixed rules):**
- `templates/`. Fill-in blueprints for the six most-requested formats: `headline.md`, `tagline.md`, `billboard.md`, `landing-page.md`, `email.md`, `manifesto.md`. Use one when you want a fast structural start. The workflow in this file still controls the work. `references/formats.md` is still the deeper reference for each format (word counts, hook banks, RSA and App Store details).

On each new piece, skim the three core files. If relevant, add the format file and the Spanish file. Open `examples.md` when you need a way in, not by default. If the format needs it (long-copy ad, manifesto, sales letter), read deeply.

---

## The Briefing Pass: Always Do This First

If you skip the brief, you write decoration. Before you write a word, ask for the brief, or get it from what the user already gave you.

**Two modes.** Use generation mode if the user has no draft. Use diagnostic mode if the user pasted existing copy. If the user pasted any existing copy, also one sentence, do not write new copy first. Change to diagnostic mode and follow `references/diagnostics.md`. The skill works in both modes. The wrong mode is the most common failure.

**Brief detection.** If the user already gave most of the eight briefing inputs, do these steps:

1. Tell the user what inputs you have.
2. Give the missing inputs in one line.
3. Continue.

Do not ask many questions to a user who already did the work. A complete brief helps you. If you ignore it, you waste the time of the user.

**The eight inputs:**

1. What is the one thing this copy must do? Sell a product, book a demo, change a belief, get a click. One thing. Not three.
2. Who is the reader? Not a demographic. A specific person with a specific problem and a specific moment. The person at the bus stop, not "urban millennials."
3. What does the reader believe now? What must the copy change? Name the Schwartz awareness level (unaware, problem-aware, solution-aware, product-aware, most aware). The level selects the headline category and the lead type. See `references/frameworks.md`.
4. What is the promise? A real, specific benefit. Not "enhanced productivity." "Two hours back every Tuesday morning."
5. What is the proof? Numbers, demonstrations, comparisons, expert testimony, user quotes, guarantees. Copy without proof is opinion.
6. What is the format constraint? Billboard glance (3 seconds), magazine spread (8 seconds), homepage hero (5 seconds before scroll), long-form email (60 seconds if the hook works).
7. What is the brand voice? If the user has a voice guide, follow it. If not, select a voice from the fifteen voices in `references/voice-bank.md` (Voices 13 to 15 are native Spanish registers). Tell the user which voice you selected, then continue. "I am writing this in Voice 1 (dry confident) blended with Voice 8 (founder narrator). Tell me if you want a different lever."
8. What is the call to action? What happens after the reader reads this?

If an input is missing and you cannot infer it, ask. Ask one question for each gap. Do not write if an input is missing.

---

## The Research Pass: If the Product Is Real, Look Before You Write

The tradition of this skill starts with research, not with writing. Hopkins worked on the factory floor. Ogilvy read the Rolls-Royce engineering notes until he found the electric clock. If the product, brand or competitor is real and you have tools to look, look.

Get these items, in order of value:

1. **The current landing page or listing.** What the brand says today is the baseline that the new copy must beat. It is also the source of the voice that you possibly must keep.
2. **Voice-of-customer language.** Reviews, support threads, forum posts and sales call notes that the user can share. Copy the exact phrases of the reader for the problem, the fear and the outcome. A verbatim "I just wanted something that wouldn't break in six months" is better than anything that you invent. See the mining method in `references/frameworks.md`.
3. **The headlines of the competitors.** You must know what the reader already heard. Then you can judge market sophistication (Schwartz) and make sure that your line cannot run under the logo of a competitor.

Two rules apply:

- **Research informs the copy. Unverified research does not go into the copy.** A review quote is a source for language. It is not a testimonial that you can publish, unless the user confirms the rights and the accuracy.
- **Keep the research in proportion.** A billboard brief for a fictional brand needs no research. A sales page for a live product needs about ten minutes of research.

If you cannot get the material (no tools, no access), ask the user for the landing page text and two or three real reviews.

---

## The Idea Pass: Find the Idea Before You Write the Words

Most copy skips this part. That is also why most copy fails.

An idea is not a headline. An idea is what the reader believes or feels after reading. The headline is one possible expression of the idea. Different ideas give different headlines. Different headlines for the same idea are interchangeable.

For each brief, make 3 to 7 different ideas before you write headlines. Write each idea as one sentence:

- The idea is that this product makes you the kind of person who notices the small things.
- The idea is that everyone else's solution treats the symptom; we treat the cause.
- The idea is that the reader has been lied to for years and we are the first to admit it.
- The idea is that this is so obvious it is embarrassing nobody did it before.

Then select one. Ask these four questions about each candidate. Keep the candidate that passes the most questions:

1. **Does it meet the reader at the reader's level?** It speaks to the awareness level in the brief, not to the level that the brand wants the reader to have.
2. **Can a competitor sign it?** If a competitor can run the same idea under its logo, it is positioning wallpaper, not an idea.
3. **Does it pass the billboard test?** If the idea is one line with no body copy, the reader still understands it. If not, the idea is not sharp enough.
4. **Is it slightly uncomfortable to publish?** Ideas that feel completely safe usually seem invisible. The best idea in the set is usually the one that makes the brand stop for one second.

Only then start to write headlines for the idea.

See `references/craft.md` for how the D&AD greats find ideas.

---

## The Headline Pass

Five times as many people read the headline as read the body. Most of the work is in the headline.

Start from the awareness level in the brief. Before you write a word, the level tells you which categories can work. The mapping table is in `references/frameworks.md`. A most-aware reader wants the offer in the headline. An unaware reader needs the indirect headline or the reframe. Then write the headlines.

Bly's eight headline categories cover almost every useful headline. Use them to make candidates: write one headline of each type, then select the best one.

1. **Direct** states the offer plainly. "Pure Silk Blouses. 30 percent off."
2. **Indirect** makes the reader curious and holds back the punchline. "How to win friends and influence people."
3. **News** announces something new or newly relevant. "Introducing the silent dishwasher."
4. **How-to** promises a method. "How to write a sentence that gets read."
5. **Question** names the problem of the reader as a question. "Do you make these mistakes in English?"
6. **Command** tells the reader what to do. "Try it for a week. Decide for yourself."
7. **Reason-why** promises a list of reasons. "Seven reasons why a Volvo lasts longer."
8. **Testimonial** puts the proof in the headline. "I never read The Economist. — Management trainee. Aged 42."

For blog posts, paid social and modern direct response (see `references/frameworks.md` for the full versions):

- **Listicle**: a number that names a finite list. "Seven mistakes that cost CFOs an hour every Tuesday."
- **Negative**: what not to do or buy. Patagonia: "Don't buy this jacket."
- **Outcome-first**: the result is the headline. "From 0 to $40,000 MRR in 90 days."

For OOH and print, also try these:

- **Visual-completion**: the headline works only with the image. The line says "Lemon." The image is a perfect-looking Volkswagen.
- **Self-deprecation**: the brand tells a truth against itself. Avis: "We're number two. We try harder."
- **Compression**: all of the idea in three or four words. Nike: "Just do it." Stella Artois: "Reassuringly expensive."
- **Reframe**: a new definition of the category. 7Up: "The Uncola."
- **Object-as-headline**: the product itself becomes the headline through how it is used or placed. Penny (Cannes 2025) printed the price directly on the packaging.

Apply the 4 U's to each candidate headline:

- **Useful**: does it give something that the reader wants?
- **Urgent**: is there a reason to act now or to continue reading?
- **Unique**: is it specific to this product, and different from the ad of a competitor?
- **Ultra-specific**: does it use real numbers, real names and real details?

A good headline gets a strong score on 3 or more of the 4 U's. A great headline gets a strong score on all 4.

---

## The Body Pass

Body copy is permission. The reader gave you permission when the reader read the headline. Earn the next sentence.

Apply these three principles, in order:

1. **After the headline, the lead does most of the work.** The first sentence earns the second sentence, or the reader goes. Do not warm up. Do not write "in today's world." Start at speed. See `references/frameworks.md` for Bly's six lead types.

2. **Make the argument flow.** Each sentence must make the next sentence feel necessary. The reader must not be able to stop. D&AD copywriters call this "the slippery slope."

3. **Specificity is the proof.** "It is quiet" is opinion. "At sixty miles an hour the loudest noise comes from the electric clock" is proof (Ogilvy, Rolls-Royce, 1958). Replace each adjective with a fact.

The function sets the length:

- A billboard: seven words or fewer.
- A sales email: 300 words.
- A magazine long-copy ad: 1,200 words.
- A landing page: the length that closes the sale, and not one word more.

Bly's principle: in direct response, long copy is better than short copy, if the long copy is good. The mistakes are short copy that does not finish the job, and long copy with padding.

For long copy, the architecture is important. See `references/frameworks.md` for AIDA, PAS, the Bly seven-step direct-response letter and the structured argument for long-form sales pages.

---

## The Offer Pass

In direct response, the offer sells more than the words. Before you write the CTA, make sure that there is an offer worth a call to action. Build each of these four components on purpose:

1. **The deal.** What exactly does the reader get, at what price, on what terms? A vague offer converts like a vague promise. "Start your free trial" is weaker than "14 days free, full plan, no card."
2. **The guarantee.** Take the risk away from the buyer. A specific guarantee is better than a general one: "60 days, full refund" is better than "satisfaction guaranteed." The strongest guarantee connects to the promise itself: "If it does not save you three hours on the first Tuesday, do not pay."
3. **Honest urgency.** A real deadline, a real capacity limit or a real price change, stated plainly, moves the reader who has not decided. Invented urgency damages the brand for every future ad. If there is no honest urgency, do not invent it. Let the guarantee close the sale.
4. **Bonuses, named and valued.** A bonus works when it solves the next problem that the buyer will have. Example: a cold email course that comes with the follow-up sequence templates. A pile of unrelated extras reads as padding and makes the core offer seem cheap.

If the brief has no offer other than "buy it," tell the user. A proposal for a stronger offer (a trial, a guarantee, a bundle) is often worth more than a new headline. Put the proposal in Notes. The user owns the pricing.

---

## The CTA Pass

A weak CTA loses sales that the rest of the copy earned. A good CTA continues the promise.

### Core rules
- Use an action verb and say what the reader gets. "Get the free guide" is better than "Submit."
- Use the language of the headline. If the headline promises "two hours back every Tuesday," the button can say "Get my Tuesday back."
- Use words that reduce friction. "Start free" reduces more friction than "Sign up."
- Use one primary CTA on each page or in each ad. A secondary CTA is acceptable if it supports the primary CTA.
- For direct response, give the offer again in the CTA area: what the reader gets, what it costs, what the guarantee is and what happens next.

### Verb bank by commitment level

The commitment increases from left to right. Select the verb for the stage of the decision of the reader.

- **Low (free, no card, browse).** See. Read. Watch. Try. Browse. Start free. Take a look. Show me.
- **Medium (sign up, trial, demo).** Start the trial. Open an account. Book a 15 minute call. Get the demo. Reserve a spot.
- **High (pay, buy, subscribe).** Buy now. Subscribe. Get the plan. Upgrade. Order. Pay and start.
- **Specific to category.** Apply. Enroll. Donate. Pledge. Vote. Download. Install. Tell me when X ships.

Do not use general verbs that match nothing: Submit, Click here, Continue, Learn more (as a CTA, not as a secondary link), Next.

### Microcopy under the button

One line of microcopy under the button removes the last 10 percent of friction. These three patterns work:

- **Risk reversal.** "No card up front." "Cancel any time." "60 day refund."
- **Time anchor.** "Takes 90 seconds." "Done in 4 minutes."
- **Social anchor.** "12,400 founders use Pulse." "Joined this week by 312 finance teams."

Use one line, never two. Two lines of microcopy under the button pull the eye away from the button.

### Secondary CTA patterns

Use these patterns when the page needs an alternative for readers who are not ready to commit:

- **Same offer, lower friction.** The primary CTA is "Start the trial." The secondary CTA is "See a 90 second demo first."
- **Education path.** The primary CTA is "Buy now." The secondary CTA is "Read the case study."
- **Live human.** The primary CTA is "Start free." The secondary CTA is "Talk to a person before you decide."

A secondary CTA that competes with the primary CTA is not a secondary CTA. It is a distraction. The secondary CTA must be visibly smaller, be near the primary CTA and go to an action with lower friction.

### Mirror test

Read the headline aloud. Then read the CTA aloud immediately. The CTA must sound like the natural next sentence after the headline. If it sounds like a change of topic, rewrite the CTA in the language of the headline.

---

## The Self-Edit Pass

Always do this pass before you give the copy to the user. See `references/self-edit.md` for the full checklist. Summary:

1. Read the copy aloud. If it sounds like a committee wrote it, rewrite it. If you cannot say it without a breath, it is too long.
2. Cut each word that does no work. Usually you cut adjectives first, then qualifiers, then connectives.
3. Replace abstractions with specifics. "Faster" becomes "in 0.3 seconds." "Affordable" becomes "12 pounds a month."
4. Remove the AI tells. Bly's principle was "write the way you talk." The anti-AI rules in `references/self-edit.md` make this principle concrete:
   - No "delve," no "robust," no "leverage," no "unlock," no "in today's world."
   - No dashes as clause connectors. The dash in a testimonial attribution is the one exception.
   - No invented compound hyphens. Standard dictionary compounds such as "money-back guarantee" keep their hyphens.
   - No rule of three by default.

   The full banned list is organised by era, because the AI tells change as the models change. The master list is at the bottom of `self-edit.md` for a quick scan.
5. Make sure that the promise survives. After one read, does the reader know what the offer is and why it is important to them? If not, you decorated and did not sell.
6. Verify each claim. Do not invent numbers, testimonials or proofs.

### Automated check (an optional backstop, not a replacement for reading aloud)

If a Python runtime is available, run the copy through the validator before you give it to the user:

```bash
python3 scripts/validate.py "Your headline or line here" --format headline
```

The validator marks banned phrases, corporate jargon, unproven superlatives, passive voice, missing specificity and headlines that are too long. It prints an Anti-AI Score out of 10. It reads its banned English **and Spanish** patterns from `references/banned-patterns.txt`. The repo gate `evals/check_banned_words.py` reads the same file, so the two tools always agree.

Use the validator as a smoke alarm, not as a judge:

- A high score does not make weak copy good.
- It scans one line at a time, not full paragraphs. Give it the headline first, then the key lines.
- The `--format` values are `headline`, `billboard`, `ooh`, `tagline`, `digital` and `general`.

The `tests/` folder documents its behaviour. `./tests/run-tests.py` shows that the scoring still works. `references/self-edit.md` is still the authority. The script only finds the obvious tells before you give the copy to the user.

---

## Output Format

In generation mode, give your response in this structure:

### Idea
One line: what the reader must believe or feel after reading.

### Final copy
The copy, ready to use. Do not put annotations inside the copy. Put each line of copy that the user can ship in a markdown blockquote (`>`). Prose outside blockquotes is commentary.

This rule is not cosmetic. The static checker and CI scan only the blockquoted copy. Copy outside blockquotes escapes the check, and the checker marks commentary inside blockquotes as copy. If you show copy in a table (an RSA headline inventory, a comparison grid), put `>` before the text in each copy cell (`| > Headline text | 27 | Job |`). The checker reads table cells that start with `>` as copy. It reads the other columns as commentary.

### Alternates
2 to 4 alternative versions of the headline and the CTA, each with one line of rationale. Put the alternative copy in blockquotes. Keep the rationale outside the blockquotes. Take alternates from two or more different headline categories, so that they are really different.

### Notes
Give these items briefly:

- The word count of the final copy.
- The awareness level that you wrote for.
- The Bly framework or D&AD principle that does the work.
- The voice (named from `voice-bank.md`, when relevant).
- Each assumption about the audience or the proof.
- Each open question that can make the copy sharper.
- Each claim that the user must verify.

Measure the word and character counts in Notes. Do not estimate them. A skill that tells others to verify cannot give a wrong count.

Two hygiene rules apply to Notes and to all other commentary:

1. Do not quote banned words, also to report that they are absent. Write "banned-list check: clean." Do not list the words that you did not use.
2. The anti-AI rules apply to all of the response, also the commentary. A connector em dash in your Notes is the same tell as a connector em dash in the copy. The one exception is diagnostic mode, where your job is to quote the bad words from the copy that the user pasted.

Do not add a summary. The work is the copy.

### Diagnostic mode

If the user pasted existing copy, use the format in `references/diagnostics.md`: Diagnosis, Severity and recommendation, The fix, What this teaches.

---

## When the User Disagrees

If the user says "make it stronger," "make it punchier," "make it less corporate" or "I don't love it," do not only change adjectives. Find the cause first:

- **The idea is wrong.** Make two more ideas and give them to the user.
- **The format is wrong.** The headline can possibly be a question, not a statement. Try a different Bly category.
- **The proof is missing.** Add a number or a demonstration.
- **The voice is wrong.** Ask for an adjective ("dry," "warm," "cocky") and rewrite to that adjective.
- **The copy is too long.** Compress it to a billboard version. Expand it again only if necessary.

Give the diagnosis with the rewrite, so that the user learns the lever.

---

## Language Note

This skill works in any language. To write in Spanish, write in Spanish. Do not translate from English, because idioms, rhythm and length are different. Latino Spanish and Castilian Spanish are not interchangeable. If you are not sure which one the reader uses, ask the user. The same rule applies to British and American English: ask which side of the Atlantic the reader is on, and spell for that reader.

---

## What This Skill Is Not For

- Long-form articles, blog posts or thought leadership essays. They are persuasive, but their primary job is to inform or entertain. Use the general writing or content skills of the user.
- Brand identity work such as naming or visual identity. That work comes before copy.
- Internal documents, reports or memos. They need clarity, not selling.

If the request is between these categories, ask the user. It is better to ask than to write the wrong thing well.
