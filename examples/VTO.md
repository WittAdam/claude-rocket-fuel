# VTO: Quote Tracker

## Core Focus
Show at a glance which client quotes are still waiting on a reply, so none go cold.

## Done looks like
- Add a quote (client, project, amount, date sent) in under 30 seconds.
- The home page lists open quotes, oldest first, with days waiting.
- Marking a quote won or lost removes it from the open list.

## Non-goals
- No invoicing, no payments, no client logins.
- No email integration this cycle.
- One user; no accounts.

## Constraints and stack
- Runs locally: a small Node app with a SQLite file.
- No paid services.

## Goals
1. Capture quotes fast.
2. Open-quote list sorted by age.
3. Won/lost status.
4. Data survives restarts.
