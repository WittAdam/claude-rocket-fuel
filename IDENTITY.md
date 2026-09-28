# claude-rocket-fuel: map

A Claude Code skill (`/rocket-fuel`) that seats Claude as Visionary and OpenAI Codex as
Integrator, plus the docs, field notes and example that explain it.

```
claude-rocket-fuel/
├── README.md                    # start here: what, why, install, use
├── CLAUDE.md                    # rules + routing, and how a Claude should help a new reader
├── IDENTITY.md                  # this map
├── skills/rocket-fuel/          # the skill (what gets installed)
│   ├── SKILL.md                 #   entry point: rules, modes, the flow
│   ├── SAME-PAGE-MEETING.md     #   the plan-review protocol
│   └── CODEX-INTEGRATOR.md      #   exact codex commands and the traps they avoid
├── docs/
│   ├── how-it-works.md          # the system explained, step by step
│   ├── field-notes.md           # lessons from real use: traps, cost, when to use it
│   ├── apply-it-to-your-work.md # using the pattern beyond this skill
│   └── faq.md                   # questions + troubleshooting
├── examples/                    # sample VTO / PLAN / SAME-PAGE-LOG from a made-up project
├── windows/codex                # git-bash shim so Claude Code can find Codex on Windows
├── assets/hero.png
├── install.sh                   # Mac/Linux installer
└── install.ps1                  # Windows installer
```
