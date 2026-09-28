# How Rocket Fuel works

## Why two models

A model that writes a plan, builds it, and checks it makes the same blind spot three times.
It reads its own work the way it meant it, not the way it is. A second model from a
different company, trained differently, misses different things. Putting it in the loop is
the cheapest real second opinion you can get.

But two models arguing with no rules just produces an endless meeting or a fake "looks
good." So the skill borrows an operating system for two co-founders: clear seats, a bounded
meeting, and a human who breaks ties.

## The seats

| | Visionary (Claude) | Integrator (Codex) |
|---|---|---|
| Owns | the plan, the standards, the final review | filtering the plan, building it, honest reports |
| Never does | write the implementation while Codex holds the build | change the plan, commit code |
| Wins ties on | vision and scope | execution details: file layout, order, library choice |

"When more than one is accountable, nobody is." Each job has exactly one owner.

## The flow (a full Kickoff)

1. **The Grill.** Claude interviews you one question at a time, each with a recommended
   answer. It looks up facts itself; only decisions come to you. Output: `VTO.md` (Vision /
   Traction Organizer): one-sentence Core Focus, what done looks like, non-goals,
   constraints, 3-7 goals.
2. **The plan.** `PLAN.md`: 3 to 7 **Rocks** (chunks of work) in order. Every Rock has a
   "done looks like" and a **proof command**, something runnable that shows it works: a
   test, a build, a `curl`. More than 7 Rocks means cut or merge.
3. **Same Page Meeting.** Codex reads the plan in read-only mode and tags every problem:
   `KILL` (doesn't serve the Core Focus), `DEFER` (real, not now), `FIX` (broken as
   written), `CLARIFY` (needs an answer). Claude accepts or rejects each one with a reason,
   revises, and sends it back. Ends when Codex's last line is `VERDICT: SAME PAGE`, or at
   5 rounds, when you decide. Every round is logged verbatim in `SAME-PAGE-LOG.md`.
4. **Codex builds.** One Rock at a time, from a frozen contract (goal, spec, paths,
   constraints, non-goals, proof), inside Codex's own sandbox. Claude doesn't touch the
   code meanwhile. New ideas mid-build go on the Issues List, not into the diff.
5. **Level 10 Review.** Claude reads the full `git diff`, not Codex's summary, and **runs
   the proof command itself**. Codex's pasted output never counts. Problems go back as one
   fix round (max 2); after that Claude takes over and says so.
6. **Close.** Scorecard (Rocks done, proof results, deviations, deferred issues), then you
   decide whether to commit. Codex never commits.

## The four modes

| Mode | When | What happens |
|---|---|---|
| Kickoff | new project | the full flow above |
| Clarity Break | existing messy repo | Claude audits and writes `ISSUES.md`, you pick 3-7, then plan → meeting → build |
| Same Page Meeting | you already have a plan | just step 3, on your file |
| Build a Rock | one clear task | contract → build → review. The one you'll use most. |

## The six rules and why

1. **Same page before code.** Fixing a plan costs a paragraph; fixing built code costs a
   rebuild.
2. **No end runs.** "Just quickly change X" mid-build makes the diff impossible to review
   against the plan.
3. **Integrator breaks ties on execution.** Stops the Visionary micromanaging.
4. **Bounded meetings.** Two models can argue forever. A flagged deadlock you decide beats a
   fake approval.
5. **Every finding answered.** Nothing gets quietly dropped, so the log is trustworthy.
6. **One run per repo at a time.** The artifacts have fixed names; two runs overwrite each
   other.

## The mechanics that make it reliable

`skills/rocket-fuel/CODEX-INTEGRATOR.md` holds the exact commands. The non-obvious ones:

- Prompts go to Codex through a file, never typed into the command. An unredirected call
  can hang forever doing nothing.
- Each round writes to a fresh output file. Reusing one means a failed round can serve the
  previous round's "approved" and look like success.
- Later rounds resume the same Codex conversation by its exact ID, so Codex remembers what
  it already flagged. Resuming "the last one" can grab the wrong conversation.
- Read-only really has to be forced on resume; otherwise Codex can quietly edit files during
  a review. Claude snapshots the repo before each call and checks nothing changed.
- Before a build, everything is committed, so the diff afterwards is exactly Codex's work.
