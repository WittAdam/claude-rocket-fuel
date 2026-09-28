# FAQ

**Do I need a paid OpenAI API key?**
No. `codex login` with a ChatGPT account works. Usage counts against that subscription.

**The skill says "Fable 5". I use a different Claude model.**
It works with whichever Claude model your Claude Code session runs. "Fable 5" is just the
seat's name from the original write-up.

**Which mode should I start with?**
Build a Rock: `/rocket-fuel have codex <one clear task>. Proof: <command that shows it works>`.
It's the smallest loop and shows you the whole review cycle in a few minutes.

**`codex: command not found` on Windows, but it works in PowerShell.**
Trap 1 in `docs/field-notes.md`. Run `install.ps1` again and accept the shim, or copy
`windows/codex` into a folder on git-bash's PATH (e.g. `~/bin`), then restart Claude Code.

**A Codex call seems stuck with no output.**
Codex only writes its answer when it finishes, and a review can take several minutes. If
it's been over 10 minutes, check Claude isn't calling Codex through an MCP tool
(`mcp__codex__*`) instead of the command line. See Trap 4.

**Codex says it won't run in this folder.**
The skill passes `--skip-git-repo-check` on every call. If you're calling Codex by hand,
add it.

**Codex keeps saying `NOT YET`.**
After 5 rounds the skill stops and asks you. That's by design. Read the open findings in
`SAME-PAGE-LOG.md`, pick, and it records your call as a `USER OVERRIDE`.

**Can Codex break my stuff?**
During review it's read-only, and Claude checks nothing changed. During a build it can
write anywhere inside the project folder, unsupervised. Commit first (the skill makes you),
and don't run builds in folders with credentials or live deploy scripts.

**Where do the files go? Should I commit them?**
Project root: `VTO.md`, `PLAN.md`, `SAME-PAGE-LOG.md`, `ISSUES.md`. Committing them is
useful; the log is the record of why the code looks the way it does.

**How do I update?**
`git pull` in this repo, then run the installer again.

**How do I uninstall?**
Delete `~/.claude/skills/rocket-fuel/`. On Windows also delete `~/bin/codex` if you
installed the shim.
