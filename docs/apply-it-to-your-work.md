# Apply it to your own work

The skill is one implementation. The pattern underneath works almost anywhere you use AI to
produce something that matters.

## The pattern in five lines

1. **Separate the seats.** One model plans and judges; a different model critiques and does.
2. **Agree before doing.** The doer attacks the plan first, with tagged findings
   (kill / defer / fix / clarify), and every finding gets an answer.
3. **Cap the argument.** A fixed number of rounds, then a human decides.
4. **Proof, not claims.** Every chunk of work has a check defined up front, and the judge
   runs it personally.
5. **Keep the log.** Write down each finding and the answer, so you can see why.

## Outside of code

The Same Page Meeting works on anything written: a proposal, a pitch deck outline, a
marketing plan, a contract summary, a script, an SOP.

- **Visionary drafts** (e.g. Claude writes the proposal outline from your notes).
- **Integrator attacks** (paste it into a different model, ChatGPT, Gemini, with the review
  prompt from `skills/rocket-fuel/SAME-PAGE-MEETING.md`, swapping "plan" for your document
  and "Core Focus" for the one sentence the document must achieve).
- **Visionary answers each finding** with accept / reject / defer and a reason.
- **Two to three rounds, then you decide.**
- **"Proof"** becomes a checklist written before drafting: "a client can tell the price in
  10 seconds," "every claim has a source," "fits in one page."

You don't need Codex or the command line for this version. Two chat windows and discipline
is enough.

## With other tool pairs

- Any two coding agents can hold the seats. The skill is Claude + Codex because Claude Code
  can drive the Codex CLI in a sandbox. The rules in `SKILL.md` don't depend on which
  models sit where.
- A cheaper model can hold the Integrator seat for reviews. It's worth it as long as it's a
  *different* model: the point is different blind spots, not more intelligence.

## Borrowing pieces without the whole thing

You get most of the value from these, even alone:

- **"Proof command per task."** Ask Claude to name the check before it starts, then run it
  yourself or ask it to run it, not describe it.
- **"Issues list, not end runs."** When you think of something mid-task, write it down for
  next time instead of changing direction.
- **"3-7 rocks, no more."** If the plan has 12 steps, it's two projects.
- **Cross-model review of a plan** before anything expensive starts.

## Ideas for your Claude to try

Ask your Claude to read this repo and then:

- "Run a Same Page Meeting on [my current plan/doc] using the review prompt, with you as
  Visionary. Tell me which findings you'd accept and why."
- "Turn my next project into a VTO.md and a PLAN.md with 3-7 rocks and a proof for each."
- "Which parts of my current workflow would benefit from a second-model review?"
