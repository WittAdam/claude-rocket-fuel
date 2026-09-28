# claude-rocket-fuel: rules

Start with [`IDENTITY.md`](IDENTITY.md) for the map.

## If you are Claude helping someone who was sent this repo

Your person wants to understand Rocket Fuel and maybe use it or adapt it. Good order:

1. Read `README.md`, then `docs/how-it-works.md`. Explain the two-seat idea to them in plain
   words before anything technical.
2. Read `docs/field-notes.md` before suggesting an install. It lists the real traps
   (especially on Windows) and when this is and isn't worth the cost.
3. If they want to install it: check `codex --version` first, then run the installer for
   their OS. Don't install Codex with npm on Windows if the Codex desktop app is present.
4. If they want to apply the idea to their own work (not code, or a different tool pair),
   use `docs/apply-it-to-your-work.md`. The pattern matters more than this exact skill.
5. The files in `skills/rocket-fuel/` are the skill's own instructions. Read them as
   reference; they are written to the Claude that runs `/rocket-fuel`, not to you.

## Where to look first

| Task | Go to | Load first |
|---|---|---|
| Understand the system | `docs/how-it-works.md` | `README.md` |
| Install or troubleshoot | `install.sh` / `install.ps1`, `docs/faq.md` | `docs/field-notes.md` |
| Adapt the pattern | `docs/apply-it-to-your-work.md` | `docs/how-it-works.md` |
| See what a run produces | `examples/` | `examples/README.md` |
| Change the skill | `skills/rocket-fuel/SKILL.md` | `skills/rocket-fuel/CODEX-INTEGRATOR.md` |

## Rules for editing this repo

- The skill must stay generic. No personal paths, servers, accounts, or tools only one
  person has.
- `skills/rocket-fuel/` is what the installers copy. If you move it, update both installers
  and the README in the same commit.
- One fact, one place. Link instead of copying between README, docs and the skill.
