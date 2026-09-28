# Field notes

What I found setting this up and running it, beyond what the original skill says.

## Cost reality: it's a quality tool, not a savings tool

The code writing moves to your ChatGPT subscription, but Claude still reads every diff and
re-runs every proof. A full Kickoff uses **more** Claude usage than just asking Claude to
build it, not less.

Where it pays off:

- **Build a Rock** for scoped tasks: `/rocket-fuel have codex add X. Proof: npm test`.
  Codex's wrong turns and dead ends stay in Codex's session instead of filling up Claude's.
- **Same Page Meeting** on any plan that's expensive to get wrong. A second model attacking
  the plan before anything is built catches things Claude reviewing its own plan won't.

For small, obvious changes, just ask Claude directly.

Also: Codex loads its own config and plugins on every call (for me ~16k tokens of baseline
even for a tiny prompt). Keep `~/.codex/AGENTS.md` and enabled plugins lean.

## Trap 1: Windows, "codex: command not found"

Claude Code runs commands through git-bash on Windows. On Windows `codex` is a `.cmd` file,
which only PowerShell and cmd know how to run. So Codex works fine in your terminal but
Claude Code says it doesn't exist, and the skill dies on its first check.

It's not a broken install. The fix is a tiny script named `codex` (no extension) somewhere
on git-bash's PATH that runs the real `codex.exe` directly. `windows/codex` in this repo is
that script; `install.ps1` offers to put it in `~/bin` for you.

## Trap 2: Windows, don't npm-install a second Codex

If you have the Codex desktop app, it already ships the CLI. The upstream skill's advice
(`npm i -g @openai/codex@latest`) installs a second copy that fights with the first. Check
`codex --version` in PowerShell before installing anything.

## Trap 3: new environment variables are invisible to programs already running

If you give Codex a token through an environment variable (for example a GitHub token for
its GitHub plugin), a Claude Code window that was already open can't see it, and neither can
the Codex it starts. The plugin just fails to authenticate with no obvious cause. Restart
Claude Code once after adding any env var.

(Related: `codex mcp login github` didn't work for me; GitHub rejects Codex's automatic
sign-up. What worked: `codex mcp add github --url "https://api.githubcopilot.com/mcp/"
--bearer-token-env-var GITHUB_PERSONAL_ACCESS_TOKEN`. The token stays in the env var, never
in the config file.)

## Trap 4: never drive Codex through an MCP server

If a project registers a `codex` MCP server, Claude may be tempted to call Codex through it
instead of the command line. Don't. It skips the file-based prompt that prevents the silent
hang. One of my runs sat for 30 minutes with no output until it was killed. The skill now
says "CLI only" in three places for that reason.

## Trap 5: two runs, one repo

The skill writes `PLAN.md`, `VTO.md`, `ISSUES.md` and `SAME-PAGE-LOG.md` at the repo root.
Its built-in rename only kicks in if those files hold *unrelated* content, so a second
`/rocket-fuel` run (another person, or your own second terminal) lands on top of the first.
In my own setup I added a shared lock both machines check first. The version here does a
simpler check: if there's an unfinished run's files, it stops and asks.

If you build a lock: a lock you *couldn't write* (drive offline, no permission) must count
as "unknown, stop", never as "free, go".

## Safety

The build step runs Codex **unsupervised** with write access to the project folder. Don't
run it in folders holding credentials, deploy scripts, or anything live. For sensitive
projects, use the Same Page Meeting to get the plan right and then let Claude write the code
itself.

## What held up when I tested it

- Read-only review and sandboxed build both work from the command line.
- Resuming a Codex session by ID really keeps context across rounds (I gave it a number in
  round 1 and it recalled it in round 2). The multi-round argument depends on that.
- The "Claude runs the proof itself" rule is the most valuable part. A report that says
  "tests pass" is a claim; running them is evidence.
