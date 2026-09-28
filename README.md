# Rocket Fuel for Claude Code

![Claude and Codex, co-founders](assets/hero.png)

Two AI models, one project, each in its own seat. Claude plans and reviews. OpenAI Codex
pokes holes in the plan, then builds it. Neither one gets to grade its own homework.

This is the setup I (Adam Witt, NeuroByte) use, packaged so you can install it, read how it
works, and borrow the idea for your own work. It's based on
[`NulightJens/rocket-fuel-skill`](https://github.com/NulightJens/rocket-fuel-skill) (MIT),
with fixes I found running it on Windows and notes from real use.

**If you're Claude reading this repo for someone:** start with [`CLAUDE.md`](CLAUDE.md).

## The idea in one minute

The name comes from *Rocket Fuel* by Gino Wickman and Mark C. Winters. Their point: the best
companies have two leaders with different jobs.

- The **Visionary** sees where things should go: ideas, plans, standards, the final call.
- The **Integrator** makes it real: filters the ideas, cuts scope creep, does the work,
  reports honestly.

One person doing both jobs goes badly, and one AI model doing both goes badly the same way.
If a model writes the plan, builds it, and checks it, it keeps making the same blind spot
at every step. Put a second model in the Integrator seat and you get a real second opinion.

| Seat | Held by | Does |
|---|---|---|
| Visionary | Claude (your Claude Code session) | interviews you, writes the plan, reads every line of the result, runs the proof itself |
| Integrator | Codex CLI | attacks the plan read-only until it agrees, then builds each piece in a sandbox |

You make three decisions per run: your answers to the interview, the rare tie-break when
they can't agree, and whether to commit the result.

More detail: [`docs/how-it-works.md`](docs/how-it-works.md).

## What's in here

| Path | What it is |
|---|---|
| `skills/rocket-fuel/` | The skill itself: the three files that get installed |
| `docs/how-it-works.md` | The full flow, the four modes, and why each rule exists |
| `docs/field-notes.md` | What I learned using it: traps, cost reality, when it's worth it |
| `docs/apply-it-to-your-work.md` | Using the two-seat pattern outside of coding, or with other tools |
| `docs/faq.md` | Common questions and troubleshooting |
| `examples/` | A sample run on a made-up project: `VTO.md`, `PLAN.md`, `SAME-PAGE-LOG.md` |
| `windows/codex` | A small fix file Windows users may need (see Install) |
| `install.sh` / `install.ps1` | One-command installers |

## Install

You need [Claude Code](https://claude.com/claude-code), the
[Codex CLI](https://github.com/openai/codex) (version 0.130 or newer), and git. A ChatGPT
account works for Codex; no API key needed.

**1. Get Codex working first.**

- Mac/Linux: `npm i -g @openai/codex@latest`, then `codex login`.
- Windows: if you already have the **Codex desktop app**, you already have Codex. Do not also
  install it with npm, or you get two competing copies. Run `codex --version` in PowerShell
  to check. If you don't have the app, the npm command above works too.

**2. Install the skill.**

```bash
git clone https://github.com/WittAdam/claude-rocket-fuel.git
cd claude-rocket-fuel
./install.sh          # Mac/Linux
.\install.ps1         # Windows PowerShell
```

The Windows installer also checks whether Claude Code can actually see Codex (it often
can't, see Trap 1 in [`docs/field-notes.md`](docs/field-notes.md)) and offers the fix.

**3. Restart Claude Code.** Type `/rocket-fuel` to check it's there.

## Use

One command, plain English. It works out which mode you want:

| You say | You get |
|---|---|
| `/rocket-fuel have codex add a dark mode toggle` | **Build a Rock**: one scoped task, built by Codex, checked by Claude. The everyday one. |
| `/rocket-fuel review PLAN.md` | **Same Page Meeting**: Codex attacks your plan until it agrees or you break the tie |
| `/rocket-fuel this repo is a mess, clean it up` | **Clarity Break**: audit, ranked issue list, you pick 3-7 fixes, then build |
| `/rocket-fuel build me a habit tracker` | **Kickoff**: interview, plan, review, build, verify, the whole thing |

Everything the two models argue about is saved to `SAME-PAGE-LOG.md` in your project,
next to `PLAN.md`, so you can read why each decision was made.

## Credits

Visionary/Integrator model from *Rocket Fuel* by Gino Wickman and Mark C. Winters. Original
skill by Jens Heitmann ([@NulightJens](https://github.com/NulightJens)). Windows fixes, docs
and field notes by Adam Witt. MIT License.
