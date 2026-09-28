# PLAN: Quote Tracker (revised after Same Page Meeting, round 2)

## Rock 1: Storage
SQLite table `quotes` (id, client, project, amount_cents, sent_on, status). Status is one of
`open`, `won`, `lost`.
- Done looks like: a quote written then read back matches exactly, including amount.
- Proof: `npm test -- storage`

## Rock 2: Add-quote form
One form, four fields, server-side validation (amount must be a positive number, date not
in the future).
- Done looks like: valid input saves; invalid input shows the error and saves nothing.
- Proof: `npm test -- add-quote` (includes a rejected-input case)

## Rock 3: Open list + won/lost
Home page lists `open` quotes, oldest first, with days waiting. Won / Lost buttons change
status.
- Done looks like: marking a quote won removes it from the list after reload.
- Proof: `npm test -- open-list` (seeds 3 quotes with fixed dates, asserts order and that a
  won quote disappears)

<!-- Rock "CSV export" removed: KILL in round 1, see SAME-PAGE-LOG.md -->
