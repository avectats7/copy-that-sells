# Install Guide

There are three install paths. They are in the order that most people use.

---

## Path 1: Claude Code (recommended for developers)

In a Claude Code session, run these commands:

```bash
/plugin marketplace add avectats7/copy-that-sells
/plugin install copy-that-sells
```

The skill is now available in every Claude Code session on this computer. When you ask Claude for copy, the skill starts automatically.

To make sure that the install worked, run this command:

```bash
/plugin list
```

The list must show `copy-that-sells`. Claude Code finds the bundled skill in `skills/copy-that-sells/SKILL.md` automatically.

To update the skill, run this command:

```bash
/plugin marketplace update avectats7/copy-that-sells
```

To remove the skill, run these commands:

```bash
/plugin uninstall copy-that-sells
/plugin marketplace remove avectats7/copy-that-sells
```

---

## Path 2: Claude Cowork (recommended for non-developers)

1. Download the packaged skill: [`dist/copy-that-sells.skill`](../dist/copy-that-sells.skill)
2. Open the file. Cowork finds the `.skill` format and asks if you want to install the skill.
3. Click **Install**.

After the install, the skill starts automatically when you ask Cowork for copy.

---

## Path 3: Manual install (any environment with Claude skill support)

1. Clone the repository:

   ```bash
   git clone https://github.com/avectats7/copy-that-sells.git
   ```

2. Copy `copy-that-sells/skills/copy-that-sells/` into the skills directory of your Claude client. For most clients, this directory is `~/.claude/skills/`. Check the documentation for your environment.

   ```bash
   # Example for a generic Claude client
   mkdir -p ~/.claude/skills/
   cp -r copy-that-sells/skills/copy-that-sells ~/.claude/skills/
   ```

3. Restart Claude. The skill must appear in your list of available skills.

---

## How to make sure that the skill works

After the install, paste this prompt into Claude:

> Write a billboard headline for a coffee shop that opens at 5am for shift workers. The audience is night-shift nurses leaving the hospital. The promise is fresh hot coffee and a warm seat. The brand is Saint Anne's Coffee.

If Claude loaded the skill, Claude does these steps:

1. Runs the briefing pass.
2. Makes some ideas before it writes headlines.
3. Returns the output in four parts: Idea, Final copy, Alternates, Notes.

If Claude writes only one general line, Claude did not load the skill.

---

## Troubleshooting

### Claude Code shows "Plugin not found"

Make sure that you ran the `marketplace add` command first. The plugin is inside its own marketplace in this repository. Claude Code must know the marketplace before it can install the plugin.

### The skill does not start on copy prompts

There are two usual causes:

1. **The prompt is too short or too general.** A skill starts on requests that have content, where the skill can help Claude. "Write copy" alone possibly does not start the skill. "Write a headline for X, for audience Y, with promise Z" starts it.
2. **A different copywriting skill has a higher priority.** Run `/plugin list` to see the other loaded skills.

### Cowork does not recognise the `.skill` file

Make sure that your version of Cowork can install skills. Some early versions cannot. If your version cannot, unzip the `.skill` file and put the contents into the skills directory of Cowork manually.

### The copy contains banned words

Open an issue. Include the prompt and the response. The self-edit pass must remove every word on the Era 1, Era 2, Era 3 and overused-vocabulary lists in `references/self-edit.md`. If a banned word gets through, that is a bug.

---

## Next steps

After the install, use the skill on a real brief to learn what it can do. Start with a small piece: a landing page hero, a subject line or a tagline. Then try longer pieces.

To learn more, read the reference files in this order: `frameworks.md`, `craft.md`, `examples.md`. They are short and dense. They teach you how to give the skill a better brief.
