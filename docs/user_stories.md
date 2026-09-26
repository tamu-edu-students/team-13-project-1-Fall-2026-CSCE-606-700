# User Stories – Lost & Found Tracker

This document records the intended behavior for Lost & Found Tracker. Board
statuses come from the supplied backlog export; implementation notes identify
known differences in the current code. Records are kept in persistent local
storage.

Each story below describes user-visible behavior, has acceptance criteria, and is
small enough to complete within the project. Every story is also tracked as an
issue on the project board
(<https://github.com/orgs/tamu-edu-students/projects/196>); the issue number is
noted in each heading. Implementation is broken down further into task issues
linked from each story.

## Complete Project Backlog

This inventory reproduces every row in the supplied TSV export. Board status is
kept as exported; story acceptance criteria below describe requested behavior.

| Issue | Backlog item | Assignee | Status | Size | Priority |
|---|---|---|---|---|---|
| [#33](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/33) | Create Team 13 GH Project Board and Repo | william-sys655 | Done | S | Urgent |
| [#34](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/34) | Create User Stories and Tasks | william-sys655 | Done | S | High |
| [#41](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/41) | User Story: Launch Interactive Terminal | AdityaVSM | Done | S | High |
| [#1](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/1) | Set up project scaffold and test framework | AdityaVSM | Done | L | High |
| [#50](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/50) | Integrate linting - Rubocop | AdityaVSM | Done | S | Medium |
| [#52](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/52) | Github action to run tests when a PR is raised | AdityaVSM | Done | S | Medium |
| [#24](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/24) | Test: marking a lost item returned updates its status | jianqiuwang | Done | S | Medium |
| [#43](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/43) | Add CLI Test Specifications | AdityaVSM | Done | XS | Medium |
| [#40](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/40) | User Story: Display Available Commands | AdityaVSM | Done | S | Medium |
| [#13](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/13) | Test: adding a found item records it correctly | william-sys655 | Done | S | — |
| [#8](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/8) | User Story: Add a Lost Item | jianqiuwang | Done | XL | — |
| [#5](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/5) | Implement persistent local storage (save/load records) | william-sys655 | Done | M | — |
| [#7](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/7) | Implement terminal UI / main menu loop | william-sys655 | Done | M | — |
| [#21](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/21) | Test: a matching found item is identified | AdityaVSM | Done | S | — |
| [#2](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/2) | Implement Item base class | jianqiuwang | Done | S | — |
| [#3](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/3) | Implement LostItem and FoundItem subclasses | jianqiuwang | Done | S | — |
| [#4](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/4) | Implement ItemManager (add / search / match / update / retrieve) | jianqiuwang | Done | L | — |
| [#9](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/9) | Add a Lost Item: CLI flow + ItemManager.add_lost_item | AdityaVSM | Done | S | — |
| [#11](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/11) | User Story: Add a Found Item | william-sys655 | Done | S | — |
| [#12](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/12) | Add a Found Item: CLI flow + ItemManager.add_found_item | william-sys655 | Done | S | — |
| [#14](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/14) | User Story: List and Search Items | AdityaVSM | Done | M | — |
| [#15](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/15) | List recorded items (all / lost / found) | AdityaVSM | Done | S | — |
| [#17](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/17) | Test: search returns only matching items | jianqiuwang | Done | XS | — |
| [#18](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/18) | User Story: Match Lost and Found Items | jianqiuwang | Done | L | — |
| [#20](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/20) | Display possible matches in the terminal | AdityaVSM | Done | S | — |
| [#22](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/22) | User Story: Mark an Item as Returned | william-sys655 | Done | S | — |
| [#25](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/25) | Write README with setup and usage instructions | william-sys655 | Done | S | — |
| [#23](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/23) | Mark an Item as Returned: ItemManager.mark_returned + CLI | william-sys655 | Done | S | — |
| [#26](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/26) | User Story: User Accounts (stretch) | — | Backlog | L | — |
| [#27](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/27) | User Story: Automatic Match Notifications (stretch) | — | Backlog | M | — |
| [#28](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/28) | User Story: Item Photos (stretch) | — | Backlog | M | — |
| [#16](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/16) | Search items by name, category, or location | jianqiuwang | Done | M | — |
| [#19](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/19) | Implement lost/found matching algorithm | jianqiuwang | Done | L | — |
| [#10](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/10) | Test: adding a lost item records it correctly | jianqiuwang | Done | S | — |
| [#6](https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700/issues/6) | Implement input validation and error messages | jianqiuwang | Done | S | — |

The backlog marks the matching algorithm and its test as Done, but the current
`MatchingService#score` implementation is still a placeholder.

---

## Essential user stories

### User Story: Launch Interactive Terminal (#41)

**As a** community member
**I want to** launch the application in a terminal
**so that** I can use its lost-and-found features interactively.

**Acceptance criteria**

- Running `./bin/lost_and_found` displays the welcome message and numbered menu.
- Selecting the quit option exits cleanly.
- End-of-input exits cleanly instead of leaving the application stuck.

Related completed issues: project scaffold and test framework (#1), terminal UI
and main menu loop (#7), and CLI test specifications (#43).

### User Story: Display Available Commands (#40)

**As a** community member
**I want to** see the available operations
**so that** I know what I can do in the application.

**Acceptance criteria**

- Running `./bin/lost_and_found --help` displays the available operations and
  usage examples.
- The interactive menu lists the numbered options available during a session.

Related completed issue: CLI test specifications (#43).

### US1 – Add a Lost Item (#8)

**As a** community member
**I want to** record a lost item with its details
**so that** there is a searchable record others can check against.

**Acceptance criteria**

- I can enter item name, description, category, location, and date lost.
- Name and location are required; leaving either blank shows an error and
  re-prompts instead of crashing.
- On success the item is saved with a unique ID and status `Lost`.
- The new item then appears in the lost-item list with exactly the information I
  entered.
- The record is still present after I close and reopen the app.

Related completed issues: Item base class (#2), lost/found subclasses (#3),
ItemManager operations (#4), local storage (#5), input validation (#6),
lost-item CLI flow (#9), and lost-item test (#10).

### US2 – Add a Found Item (#11)

**As a** community member
**I want to** record a found item with its details
**so that** the item's owner can be located.

**Acceptance criteria**

- I can enter item name, description, category, location, and date found.
- Name and location are required; missing values show an error and re-prompt.
- On success the item is saved with a unique ID and status `Found`.
- The new item then appears in the found-item list with the information I entered.
- The record persists across app restarts.

Related completed issues: found-item CLI flow (#12) and found-item test (#13).

### US3 – List and Search Items (#14)

**As a** community member
**I want to** view recorded items and search them by name, category, or location
**so that** I can quickly find a specific item without reading every record.

**Acceptance criteria**

- I can list all items, or filter to lost-only or found-only.
- Each entry shows name, category, location, date, and status.
- I can search by name, category, or location.
- Search is case-insensitive and matches partial text.
- Searching "Backpack" returns "Black Backpack" and excludes unrelated items.
- A search with no matches shows a clear "no results" message.

Related completed issues: list recorded items (#15), search by name/category/
location (#16), and search test (#17).

### US4 – Match Lost and Found Items (#18)

**As a** community member
**I want to** see suggested matches between lost and found items
**so that** I can reconnect items with their owners without comparing every
record by hand.

**Acceptance criteria**

- I can request possible matches for one lost item or for all lost items.
- Matching considers name, category, description, and location.
- A found "Black Wallet" recorded at the same or a nearby location as a lost
  "Black Wallet" is listed as a possible match.
- Clearly unrelated items are not listed.
- Each suggested match shows enough detail for me to confirm it.
- If there are no candidates, the app tells me so.

Related completed issues: matching algorithm (#19), displaying matches in the
terminal (#20), and matching test (#21). The current matching service is still
only a placeholder despite these issues being marked Done in the supplied
backlog export.

### US5 – Mark an Item as Returned (#22)

**As a** community member
**I want to** mark a lost item as returned once it has been recovered
**so that** it no longer shows up as outstanding or in match suggestions.

**Acceptance criteria**

- I can select a lost item by its ID and mark it returned.
- Its status changes from `Lost` to `Returned` and the change persists.
- A returned item is excluded from active match suggestions.
- Selecting an ID that does not exist shows an appropriate error message.

Related completed issues: return status and CLI flow (#23) and return test (#24).

---

## Stretched user stories (Backog for future)

### US6 – User Accounts (#26)

**As a** registered user
**I want to** create an account and sign in
**so that** I can manage my own lost and found records separately from other
people's.

**Acceptance criteria**

- I can create an account with a username and password.
- I can sign in and sign out.
- Items I create while signed in are associated with my account.
- I can view a list of only my own items.
- Creating an account with an existing username is rejected with a message.

### US7 – Automatic Match Notifications (#27)

**As a** registered user
**I want to** be notified when a newly added found item matches one of my lost
items
**so that** I can act on it promptly instead of checking manually.

**Acceptance criteria**

- When any found item is added, it is compared against my open (still `Lost`)
  items.
- If it matches, a notification is recorded for me.
- I can view my notifications; each names the lost item and the matching found
  item.
- No notification is created for non-matches or for items already marked
  `Returned`.

Depends on US6 and US4.

### US8 – Item Photos (#28)

**As a** community member
**I want to** attach a photo to a lost or found item
**so that** other people can identify the item visually.

**Acceptance criteria**

- I can attach an image (file path) to an item when creating or editing it.
- The image reference is stored with the record and persists across restarts.
- The item's details show that a photo is attached and where it is.
- An invalid or missing image path is rejected with a message.

---

## Coverage summary

| Story | Type | Board issue |
|-------|------|-------------|
| Launch Interactive Terminal | Essential | #41 |
| Display Available Commands | Essential | #40 |
| US1 Add a Lost Item | Essential | #8 |
| US2 Add a Found Item | Essential | #11 |
| US3 List and Search Items | Essential | #14 |
| US4 Match Lost and Found Items | Essential | #18 |
| US5 Mark an Item as Returned | Essential | #22 |
| US6 User Accounts | Optional (stretch) | #26 |
| US7 Automatic Match Notifications | Optional (stretch) | #27 |
| US8 Item Photos | Optional (stretch) | #28 |
