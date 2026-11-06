# Context Labs

**Build anything with AI by giving it context, not longer prompts.**

Context Labs is three Claude skills that run one loop:

```
your project ──► setup ──► CONTEXT.md ──► handoff ──► Claude Design / Claude Code
                    ▲                                         │
                    └──────── review ◄── screenshots ◄────────┘
```

| Skill | What it does | Say |
|---|---|---|
| **setup** | Scans your project (or researches the category for a new idea), asks you short pop-up questions built from what it found, and writes `CONTEXT.md`: one file with your product, direction, design tokens, build rules and decisions. Every line says where it came from. | "set up context" · "update my context" |
| **handoff** | Turns `CONTEXT.md` into a ready-to-paste prompt for the next tool: a Claude Design pass, a Claude Code plan-mode build, or a Claude artifact. It carries only what that tool needs. | "send this to claude design" · "write the plan mode prompt" |
| **review** | Checks your screenshots against `CONTEXT.md` and the handoff's checks: pass/fail with evidence, asks your taste where rules can't decide, writes a narrow fix prompt and saves approved decisions back. | "review these" · "is this on brand" |

Free. Made by [Khalid](https://x.com/khalerdameen). More context files and skills at [context-labs.net](https://context-labs.net).

---

## Prompt vs context vs skill

- **Prompt:** the ask. One message.
- **Context:** the facts about *this* project. Lives in `CONTEXT.md`.
- **Skill:** a method Claude reuses on every project. These three.

A great prompt with no context gets you the average app in your category. Context is why two people with the same prompt get different results.

---

## Install

### Claude Code (recommended)

Inside Claude Code:

```
/plugin marketplace add KhalerdAmeen/context-labs
/plugin install context-labs@context-labs
```

Then run `/context-labs:setup`, `/context-labs:handoff` or `/context-labs:review`, or just say the phrases above.

**Without the plugin system:** download the three zips from [Releases](https://github.com/KhalerdAmeen/context-labs/releases), unzip them into `~/.claude/skills/` (all projects) or `.claude/skills/` (one project).

### Codex, Cursor, Gemini CLI, Copilot and other agents

The skills follow the open Agent Skills standard (a folder with a `SKILL.md`), so any agent that reads skills can use them. The quickest install:

```
npx skills add KhalerdAmeen/context-labs
```

It finds the agents on your machine and installs `context-labs-setup`, `context-labs-handoff` and `context-labs-review` into each. Add `-g` to install for all projects.

**Manual:** copy the three folders from [`skills/`](skills/) into your agent's skills folder: `.agents/skills/` in a project works for Codex, Cursor, Gemini CLI, Copilot, OpenCode and most others.

**What changes outside Claude:** setup asks its questions as a short numbered list in chat instead of pop-ups, and it points your agent at CONTEXT.md through `AGENTS.md` instead of `CLAUDE.md`. Everything else is the same.

### Claude app (claude.ai / desktop)

1. Download `context-labs-setup.zip`, `context-labs-handoff.zip`, `context-labs-review.zip` from [Releases](https://github.com/KhalerdAmeen/context-labs/releases).
2. Open **Settings → Features → Skills** and upload each zip. Code execution must be on (paid plans).
3. Start a chat and say "set up context for my app idea".

Skills don't sync between the Claude app and Claude Code; install in each place you use them.

---

## Use it

**1. Set up** (in your project, in Claude Code or any agent):

> set up context

It works in three modes and picks one itself:

- **Extract:** you have code. It reads your code, docs, plans, memory and inspiration folder, then asks only what the code can't answer.
- **Create:** you have an idea. It researches the category, then asks about product, feel and what to refuse.
- **Update:** `CONTEXT.md` exists. It checks what changed since the last update and asks about the changes.

It asks before adding `@CONTEXT.md` to your `CLAUDE.md`, so every future session loads it.

**2. Hand off:**

> next design pass for onboarding

You get a prompt in a code block. Paste it into Claude Design (or Claude Code plan mode with Shift+Tab). A copy is saved in `.context-labs/handoffs/`.

**3. Review:** export screenshots and drop them in the chat:

> review these

You get what works, what fails (with evidence), a fix prompt to paste back, and the option to save approved decisions into `CONTEXT.md`. Two to four rounds is normal.

**4. Build:** when the design is approved, ask for the plan-mode prompt and build it in Claude Code. After building, say "update my context".

---

## What CONTEXT.md looks like

```markdown
# Cram — Context
> Last updated: 2026-10-19 · Mode: create

## Product
- What it is: a revision timer that turns an exam list into today's blocks [you]
- Refused defaults: no streaks, no mascots, no pastel cards [you]

## Design
| Role   | Value   | Where it's allowed            | Source |
|--------|---------|-------------------------------|--------|
| Accent | #FFC400 | next/current block only       | [you] [design: pass 1] |

## Build
### Rules that have bitten before
- Always map every column in rows.ts: an omitted column is nulled on upsert [code: src/db/rows.ts]

## Decisions log
- 2026-10-19: kept the big timer and the Start block [you] [design: pass 1]
```

Source tags: `[code: path]` `[doc: path]` `[plan: file]` `[memory]` `[you]` `[research]` `[rule]`. If a line has no source, it doesn't go in.

Never put API keys, `.env` values or passwords in `CONTEXT.md`; the skill refuses to.

---

## Files

```
.claude-plugin/marketplace.json   ← lets Claude Code install from this repo
plugin/
  .claude-plugin/plugin.json
  skills/
    setup/    SKILL.md + references/ (where-to-look, questions, template, mobile-rules)
    handoff/  SKILL.md + references/ (design, plan-mode, artifact)
    review/   SKILL.md + references/ (tells, fix-prompt)
skills/                           ← generated copies for npx skills / other agents (don't edit by hand)
build.sh                          ← regenerates skills/ and the Claude app zips in dist/ from plugin/skills
```

## Contribute

Have a context file or skill that made your work better? Submit it at [context-labs.net/submit](https://context-labs.net/submit). Issues and PRs welcome.

## License

[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Use it, change it, share it; credit Context Labs.
