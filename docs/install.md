# Install Guide

Three install paths, in rough order of how most people will use this skill.

---

## Path 1: Claude Code (recommended for developers)

Inside any Claude Code session, run:

```bash
/plugin marketplace add avectats7/copy-that-sells
/plugin install copy-that-sells
```

That is it. The skill is now available in every Claude Code session on this machine. It triggers automatically when you ask Claude for copy.

To verify it installed:

```bash
/plugin list
```

You should see `copy-that-sells` in the list. The bundled skill is auto-discovered from `skills/copy-that-sells/SKILL.md`.

To update later:

```bash
/plugin marketplace update avectats7/copy-that-sells
```

To remove:

```bash
/plugin uninstall copy-that-sells
/plugin marketplace remove avectats7/copy-that-sells
```

---

## Path 2: Claude Cowork (recommended for non-developers)

Download the packaged skill:

[`dist/copy-that-sells.skill`](../dist/copy-that-sells.skill)

Open the file. Cowork will detect the `.skill` format and offer to install. Click install.

After install, the skill triggers automatically when you ask Cowork for copy.

---

## Path 3: Manual install (any environment with Claude skill support)

Clone the repo and copy the skill folder into your local skills directory.

```bash
git clone https://github.com/avectats7/copy-that-sells.git
```

Then copy `copy-that-sells/skills/copy-that-sells/` into whichever skills directory your Claude client uses. For most clients this is `~/.claude/skills/` but check the docs for your environment.

```bash
# Example for a generic Claude client
mkdir -p ~/.claude/skills/
cp -r copy-that-sells/skills/copy-that-sells ~/.claude/skills/
```

Restart Claude. The skill should now appear in your available skills list.

---

## How to confirm the skill is working

After install, paste this prompt into Claude:

> Write a billboard headline for a coffee shop that opens at 5am for shift workers. The audience is night-shift nurses leaving the hospital. The promise is fresh hot coffee and a warm seat. The brand is Saint Anne's Coffee.

If the skill is loaded, Claude will run the briefing pass, generate a few ideas before writing headlines, and return output structured as Idea / Final copy / Alternates / Notes. If it just writes a single generic line, the skill is not loaded.

---

## Troubleshooting

### "Plugin not found" in Claude Code

Make sure you ran the marketplace add command first. The plugin lives inside its own marketplace in this repo, so Claude Code needs to know about the marketplace before it can install the plugin.

### Skill does not trigger on copy prompts

Two common causes:

1. The prompt is too short or too generic. Skills trigger on substantive requests where Claude would benefit from consulting them. "Write copy" alone may not trigger. "Write a headline for X, for audience Y, with promise Z" will.
2. Another copywriting skill is also installed and outranks this one. Run `/plugin list` and see what else is loaded.

### Cowork does not recognise the `.skill` file

Make sure Cowork is updated to a version that supports skill installs. Some early versions did not. As a fallback, you can unzip the `.skill` file and place the contents in Cowork's skills directory manually.

### The skill produces copy with banned words anyway

File an issue with the prompt and the response. The self-edit pass should strip every word on the Era 1, Era 2, Era 3, and overused-vocabulary lists in `references/self-edit.md`. If a banned word slips through, that is a bug.

---

## Where to go next

Once the skill is installed, the best way to learn what it can do is to use it on a real brief. Start small. A landing page hero. A subject line. A tagline. Then escalate to longer pieces.

For deeper study, read the reference files in order: `frameworks.md`, then `craft.md`, then `examples.md`. They are short and dense and they teach you to brief the skill better.
