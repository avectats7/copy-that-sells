# Diagnostics: When the User Pastes Existing Copy

Most copy requests are not "write me an ad from scratch." They are "here is what I have. It is not working. Fix it." The skill needs a clean procedure for this case. Generating without diagnosing is throwing dice. Diagnosing first turns a guess into a fix.

This file is the operational playbook for diagnostic mode. Use it whenever the user pastes existing copy and asks for an improvement, regardless of how the request is phrased ("make it stronger," "this is not converting," "rewrite this," "punch it up").

## Table of contents

- When to diagnose vs when to write fresh
- The diagnostic pass in five questions
- Symptom-cause-fix table
- The rewrite decision: edit, restructure, or burn down
- Output format for diagnostic responses
- When the user disagrees with the diagnosis

---

## When to diagnose vs when to write fresh

**Diagnose first when:**

- The user pasted any existing copy, even a single sentence.
- The user described copy that exists without pasting it ("our homepage says X but conversions are flat").
- The user is asking for "stronger," "punchier," "less corporate," "more on brand" without naming the actual problem. They feel something is wrong but cannot name it.
- The user has tried a few rewrites themselves and is frustrated.

**Write fresh when:**

- The user gave you a brief but no draft.
- The user explicitly says "throw this out and start over."
- The brief in the existing draft is wrong at the foundation (audience, offer, or proof) and a rewrite would be misleading.

The default is diagnose first. Skipping diagnosis when the user pasted copy is a mistake the user notices, even if they cannot articulate why. They feel that the model did not read their work.

---

## Before the five questions: get the numbers

When the complaint is about performance ("not converting," "open rates fell," "nobody clicks"), ask two context questions before diagnosing a word of copy:

1. **Where does the traffic come from?** Cold paid social, branded search, a newsletter, a sales sequence. Traffic source sets the awareness level, and copy written for the wrong level fails regardless of craft. A hero that converts branded-search visitors at 4 percent can convert cold TikTok traffic at 0.2 percent with no copy defect at all.
2. **What is the current rate, and against what expectation?** "Converting at 1.2 percent" means nothing without the offer, the price, and the category baseline. A 1.2 percent rate on a $15 tool is a copy problem. A 1.2 percent rate on a $12,000 contract may be normal.

If the user has no numbers, proceed on craft alone but say so in the diagnosis: "This is a craft read; the conversion question needs your traffic source and current rate."

And keep one honest outcome on the table: **sometimes the copy is not the problem.** If the audience is wrong, the price is misaligned with the market, or the offer is weaker than every competitor's, no rewrite fixes it. Saying "the words are fine; the offer is losing to X" is a legitimate diagnosis and often the most valuable one.

---

## The diagnostic pass in five questions

For any pasted copy, run these five questions in order. Stop at the first one that fails. The first failure is the root cause. The remaining questions cannot be answered until the root is fixed.

### 1. Is the idea sharp?

The most common failure. The headline is fine, the body is competent, but the idea behind the copy is mush. Generic promise. Interchangeable proposition. No angle on the proposition.

Test: rewrite the idea behind the copy in one sentence in plain English. If you cannot, the idea is not sharp. The fix is to generate three to seven new ideas, not to edit the words.

### 2. Is the audience clear?

Copy that addresses "everyone" addresses no one. Read the copy and try to name, in one sentence, the specific person it is talking to. Their problem, their moment, their current belief.

If the copy could be addressed to two materially different audiences without changing the words, the audience is not clear. Fix the brief before fixing the words.

### 3. Is the promise specific?

Vague promises ("better experience," "faster workflow," "more efficient") do not sell. Specific promises ("two hours back every Tuesday," "9 minutes to set up," "30 percent off if you pay yearly") do.

Read the copy. Count the specifics. Count the abstractions. If abstractions outnumber specifics, the fix is to replace adjectives with facts.

### 4. Does the proof support the promise?

Copy with a strong promise but no proof reads as marketing. The reader nods and clicks away. Copy with proof reads as truth.

Look for: numbers, demonstrations, testimonials, named customers, side by side comparisons, guarantees. If the draft has zero of these, the fix is to add at least one before doing anything else with the words.

### 5. Does the rhythm carry the reader?

Even with a sharp idea, a clear audience, a specific promise, and stacked proof, copy can fail on rhythm. Stacked compound sentences. Sub-clauses that bury the verb. Two consecutive sentences of the same length. AI tells.

Read the copy aloud. If you stumble, the reader stumbles. If you run out of breath, sentences are too long. If the words make you cringe to say, the words are wrong.

The fix is the self-edit pass in `self-edit.md`.

---

## Symptom-cause-fix table

The user describes the symptom. You name the cause and propose the fix.

| Symptom the user names | Likely root cause | Where the fix lives |
|---|---|---|
| "It sounds corporate" | Banned AI vocabulary, abstractions instead of specifics | `self-edit.md` Layer 2 |
| "It's not converting" | Promise unclear or proof missing | Question 3 and 4 above |
| "It's boring" | Idea is not sharp; proposition stated without an angle | Question 1 above, `craft.md` |
| "It's too long" | Body has padding; lead does not earn the body | `frameworks.md` lead types |
| "It's too generic" | Audience unclear; could run for any competitor | Question 2 above, the 4 U's |
| "It doesn't sound like us" | Voice not picked; tone drifts paragraph to paragraph | `voice-bank.md` |
| "Make it punchier" | Compression not applied | `craft.md` Compression section |
| "Make it stronger" | Often headline is wrong category | `frameworks.md` Bly's eight |
| "Something is off" | Usually rhythm or AI tells | `self-edit.md` Layer 2 |
| "The CTA is weak" | Verb is generic; CTA does not mirror the promise | SKILL.md CTA pass |
| "Hero feels off" | Headline and visual not working as one unit | `craft.md` headline + visual |
| "Long copy lost me halfway" | Voice drifted; argument lacks shape | `craft.md` long-copy section |
| "We rewrote it three times, still flat" | The copy is not the problem: offer, price, or audience | The two data questions above; SKILL.md Offer Pass |
| "It converts on search, dies on social" | Awareness mismatch per traffic source | `frameworks.md` Schwartz levels |

When the user names a symptom, your first job is to translate it to one of these root causes. Then you can fix.

---

## The rewrite decision: edit, restructure, or burn down

After the diagnosis, decide which level of intervention is honest.

### Edit (Layer 1 fix)

The idea is sharp. The audience is clear. The promise is specific. The proof is present. The problem is words, rhythm, or AI tells.

What it looks like: keep the structure, replace abstractions with specifics, cut filler, strip banned vocabulary, vary sentence length, fix the CTA verb. The output reads as a tightened version of the same copy.

When to use: when 80 percent of the original is recoverable.

### Restructure (Layer 2 fix)

The idea is sharp but the format is wrong. The headline is in the wrong Bly category. The lead is news when it should be problem. The argument runs out of order.

What it looks like: keep the idea and the proof, rebuild the architecture. Move sections. Pick a new headline category. Restructure the long-copy ad as a closing argument instead of a feature list.

When to use: when the substance is there but the bones are wrong.

### Burn down (Layer 3 fix)

The idea is wrong. The audience is wrong. The promise is hollow. No amount of editing fixes this.

What it looks like: name the root cause, explain why edits cannot fix it, and propose 3 new ideas as starting points. The output is a diagnostic, not a rewrite.

When to use: when the brief itself is broken. Be honest. The user will respect "this is not fixable as is, here is what I'd do instead" more than a tightened version of bad copy that still does not convert.

---

## Output format for diagnostic responses

When in diagnostic mode, structure your response like this. Use this format whenever the user pastes existing copy.

### Diagnosis
One to three sentences. Name the root cause. Reference one of the five diagnostic questions. Be specific. "The promise is vague. 'Better workflow' is interchangeable with three of your competitors. The fix lives at the brief, not at the words."

### Severity and recommendation
Edit, Restructure, or Burn down. One line each on what that means for this draft.

### The fix
The actual rewrite, full and ready to use. Same output structure as a generation task: Idea, Final copy, Alternates, Notes.

If recommendation is Burn down, replace "Final copy" with "Three new ideas to start from" and offer the user a choice before writing further.

### What this teaches
One sentence. Name the lever the user can pull next time without you. "When you read it aloud and stumble in the middle, that is usually a buried verb. Move the verb forward and the sentence opens."

This last section is what makes the skill teach, not just produce. The user pulls the lever next time on their own.

---

## When the user disagrees with the diagnosis

The user is often closer to the brand than you are. If they push back, take it seriously.

Three legitimate disagreements and how to handle them:

1. **"That is not the real problem."** Ask them to name the real problem. Then redo the diagnosis with their input. Their proximity to the audience matters more than your read of the page.

2. **"The promise IS specific, you just don't understand the category."** Ask for one or two examples of what specificity looks like in their category. The bar may differ. B2B technical infrastructure copy uses different specifics than DTC skincare copy. Recalibrate.

3. **"The voice is intentional."** If the user named a stylistic choice you flagged as a problem, drop it. The user is the brand. Move on to the next layer.

Three disagreements where you hold the line:

1. **The copy uses banned AI vocabulary the user has not flagged as deliberate.** Hold the line. Show the user the words you would replace and why. Most users have not noticed those words and will agree once shown.

2. **The proof is fabricated.** Hold the line. Fabricated proof can be a legal exposure. If the user wants to keep an unverifiable number, flag the risk and let them decide.

3. **The CTA verb is generic.** Hold the line if the data is on your side. Direct response a century deep favours specific verbs over "Submit," "Learn more," "Get started." Show two alternatives and let the user pick.

---

## A working list of diagnostic principles

- Diagnose before rewriting. Always.
- When the complaint is performance, ask for traffic source and current rate before blaming the words.
- Run the five questions in order. Stop at the first failure. That is the root.
- "The copy is not the problem" is a valid diagnosis. Deliver it when it is true.
- Translate the user's symptom into one of the table's root causes before responding.
- Decide between edit, restructure, and burn down honestly. The user respects the call more than the patch.
- Always teach the lever. The user should pull it on their own next time.
- When the user disagrees on substance, listen. When they disagree on craft you can defend, hold the line and show your work.
