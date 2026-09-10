# User Stories – Lost & Found Tracker

Lost & Found Tracker is a terminal application for recording lost or found items,
searching existing records, and identifying possible matches between lost and
found items. Records are kept in persistent local storage so they remain
available after the program is closed.

Each story below describes user-visible behavior, has acceptance criteria, and is
small enough to complete within the project. Every story is also tracked as an
issue on the project board
(<https://github.com/orgs/tamu-edu-students/projects/196>); the issue number is
noted in each heading. Implementation is broken down further into task issues
linked from each story.

**Roles**

- **Community member** – a student or community member using the app to record
  and recover belongings. No sign-in required for the essential features.
- **Registered user** – a community member who has created an account (stretch
  features only).

---

## Essential user stories

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

### US5 – Mark an Item as Returned (#22)

**As a** community member
**I want to** mark a lost item as returned once it has been recovered
**so that** it no longer shows up as outstanding or in match suggestions.

**Acceptance criteria**

- I can select a lost item by its ID and mark it returned.
- Its status changes from `Lost` to `Returned` and the change persists.
- A returned item is excluded from active match suggestions.
- Selecting an ID that does not exist shows an appropriate error message.

---

## Optional user stories (stretch)

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
| US1 Add a Lost Item | Essential | #8 |
| US2 Add a Found Item | Essential | #11 |
| US3 List and Search Items | Essential | #14 |
| US4 Match Lost and Found Items | Essential | #18 |
| US5 Mark an Item as Returned | Essential | #22 |
| US6 User Accounts | Optional (stretch) | #26 |
| US7 Automatic Match Notifications | Optional (stretch) | #27 |
| US8 Item Photos | Optional (stretch) | #28 |
