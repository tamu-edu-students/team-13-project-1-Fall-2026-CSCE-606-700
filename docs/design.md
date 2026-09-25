# Lost & Found Tracker — Design Document

## 1. Overview

Lost & Found Tracker is a Ruby-based terminal application for recording, searching, and managing lost and found items. The application provides a command-line interface (CLI) through which users can create item records, search existing records, identify possible matches, and mark lost items as returned.

The application uses persistent local storage so that item records remain available between program executions.

The design focuses on:

- Simple command-line interaction
- Separation of application responsibilities
- Reusable domain models
- Persistent local storage
- Input validation
- Search and matching functionality
- Testability using RSpec

---

## 2. Design Goals

The primary design goals are:

1. **Simplicity** — The application should be easy to understand and use from a terminal.
2. **Separation of concerns** — CLI interaction, business logic, domain models, and persistence should be separated.
3. **Persistence** — Lost and found records should remain available after the application exits.
4. **Extensibility** — The design should allow future features such as user accounts, notifications, and item photos.
5. **Testability** — Core application behavior should be testable independently from the terminal interface.

---

## 3. System Architecture

The application follows a layered structure:

```text
+-------------------------+
|       CLI Interface     |
|   bin/lost_and_found    |
+------------+------------+
             |
             v
+-------------------------+
|    Command / Input      |
|       Handling          |
+------------+------------+
             |
             v
+-------------------------+
|      ItemManager        |
|   Application Logic     |
+------------+------------+
             |
       +-----+-----+
       |           |
       v           v
+-------------+ +-------------+
| LostItem    | | FoundItem   |
| Domain      | | Domain      |
| Model       | | Model       |
+------+------+ +------+------+
       |               |
       +-------+-------+
               |
               v
+-------------------------+
|   Persistence Layer     |
|     SQLite Database     |
+-------------------------+
```

### 3.1 CLI Layer

The CLI is the primary interface between the user and the application.

The executable is:

```text
bin/lost_and_found
```

Example commands include:

```bash
./bin/lost_and_found add-lost
./bin/lost_and_found add-found
./bin/lost_and_found list
./bin/lost_and_found search
./bin/lost_and_found match ID
./bin/lost_and_found return ID
./bin/lost_and_found --help
```

The CLI is responsible for:

- Parsing user commands
- Collecting user input
- Displaying results
- Displaying validation and error messages
- Calling the appropriate application logic

The CLI should not contain the main business rules for searching, matching, or updating records.

---

## 4. Domain Model

The application uses three primary domain concepts:

- `Item`
- `LostItem`
- `FoundItem`

### 4.1 Item

`Item` represents the common information shared by lost and found records.

An item contains information such as:

| Attribute | Description |
|---|---|
| `id` | Unique identifier for the record |
| `name` | Name of the item |
| `description` | Additional description |
| `category` | Item category |
| `location` | Location where the item was lost or found |
| `date` | Date associated with the record |
| `status` | Current status of the item |

---

### 4.2 LostItem

`LostItem` represents an item reported as lost.

Example:

```text
LostItem
--------------------------------
ID: 12
Name: Black Wallet
Description: Leather wallet
Category: Personal
Location: MSC
Date: 2026-09-15
Status: Lost
```

A lost item can later have its status changed to `Returned`.

---

### 4.3 FoundItem

`FoundItem` represents an item reported as found.

Example:

```text
FoundItem
--------------------------------
ID: 18
Name: Black Wallet
Description: Black leather wallet
Category: Personal
Location: MSC
Date: 2026-09-16
Status: Found
```

Found items can be compared with lost items to identify potential matches.

---

## 5. ItemManager

`ItemManager` is the primary application/service component responsible for coordinating item-related operations.

It acts as the main interface between the CLI and the underlying domain and persistence layers.

### Responsibilities

`ItemManager` handles:

- Creating lost items
- Creating found items
- Retrieving items
- Listing items
- Searching items
- Matching lost and found items
- Updating item status
- Coordinating persistence
- Validating operations that require an existing item

Conceptually, the manager provides operations such as:

```text
add_lost_item(...)
add_found_item(...)
list_items(...)
search_items(...)
match_item(...)
mark_returned(...)
find_item(...)
```

The CLI calls these operations rather than directly manipulating the database.

---

## 6. Persistence Design

The application uses a local SQLite database to provide persistent storage.

The database allows records to survive after the CLI application exits.

### Persistence Flow

```text
User
 |
 v
CLI
 |
 v
ItemManager
 |
 v
Repository / Persistence Layer
 |
 v
SQLite Database
```

When an item is added:

```text
User input
    |
    v
Validate input
    |
    v
Create Item object
    |
    v
Save record
    |
    v
SQLite database
```

When the application starts again, existing records can be loaded from the database.

### Persistence Requirements

The persistence layer should support:

- Creating records
- Retrieving records by ID
- Retrieving all records
- Searching records
- Updating records
- Preserving records between program executions

The persistence implementation should be isolated from the CLI so that storage details do not need to be handled by command-line code.

---

## 7. Data Model

The logical item structure can be represented as:

```text
Item
--------------------------------
id
name
description
category
location
date
status
type
```

Where `type` identifies whether the record represents a lost or found item.

A logical database representation can be:

```text
+------------------------------------------------+
|                    items                       |
+------------------------------------------------+
| id           | unique identifier              |
| name         | item name                      |
| description  | item description               |
| category     | item category                  |
| location     | lost/found location            |
| date         | date lost/found                |
| status       | Lost / Found / Returned       |
| type         | Lost / Found                  |
+------------------------------------------------+
```

The exact database implementation may separate lost and found records into different tables if required by the implementation. The domain model should remain independent of that storage decision.

---

## 8. Search Design

The search feature allows users to find records using information such as:

- Item name
- Category
- Location

For example:

```bash
./bin/lost_and_found search Backpack
```

The search operation should compare the provided search term against supported item fields.

A search for:

```text
Backpack
```

should return relevant records such as:

```text
Black Backpack
Blue Backpack
Backpack with laptop
```

while excluding unrelated records.

Search matching can be case-insensitive so that:

```text
backpack
Backpack
BACKPACK
```

are treated as the same search term.

---

## 9. Matching Design

The matching feature identifies possible relationships between lost and found records.

A lost item is compared with available found items using attributes such as:

- Item name
- Category
- Description
- Location

For example:

```text
Lost Item
--------------------------------
Name: Black Wallet
Category: Personal
Location: MSC
Description: Black leather wallet
```

and:

```text
Found Item
--------------------------------
Name: Black Wallet
Category: Personal
Location: MSC
Description: Leather wallet
```

would be identified as a possible match because several attributes are similar.

### Matching Approach

The initial implementation uses attribute similarity rather than requiring an exact match for every field.

Conceptually:

```text
Lost Item
    |
    +-- Compare name --------+
    |                        |
    +-- Compare category ----+
    |                        |
    +-- Compare description -+--> Calculate similarity
    |                        |
    +-- Compare location ----+
                             |
                             v
                     Possible Match
```

The matching implementation can assign greater importance to fields that provide stronger evidence of a match.

For example:

```text
Name        -> strong matching signal
Category    -> supporting signal
Location    -> supporting signal
Description -> supporting signal
```

The application should present matches as **possible matches**, rather than automatically declaring that two records represent the same physical item.

---

## 10. Marking Items as Returned

A lost item can be updated after the owner recovers it.

Example:

```bash
./bin/lost_and_found return 12
```

The application:

1. Finds the item with ID `12`.
2. Verifies that the item exists.
3. Verifies that the operation is valid for the item.
4. Updates its status to `Returned`.
5. Persists the updated record.
6. Displays confirmation to the user.

Example state transition:

```text
Lost
 |
 | return command
 v
Returned
```

The updated status must remain persistent after the application exits.

---

## 11. Input Validation

Input validation is performed before creating or modifying records.

Required fields include:

- Item name
- Location

Invalid input should not result in a database record being created.

Examples of invalid operations include:

```text
Empty item name
Empty location
Invalid item ID
Attempt to update a non-existent item
```

The application should provide a clear error message and allow the user to correct the input.

Example:

```text
Error: Item name cannot be empty.
```

For an invalid ID:

```text
Error: No item found with ID 25.
```

Validation should be performed in the application/domain layer where possible rather than relying only on CLI checks.

---

## 12. Error Handling

The application should handle expected user errors gracefully without terminating unexpectedly.

Expected errors include:

- Invalid command
- Missing required argument
- Missing required field
- Invalid item ID
- Item does not exist
- Invalid status transition
- Database/storage errors

The CLI should convert these errors into readable messages.

Example:

```text
$ ./bin/lost_and_found return 999

Error: Item with ID 999 does not exist.
```

The application should avoid exposing internal implementation details or stack traces to normal users.

---

## 13. Command Flow

### Add Lost Item

```text
User
 |
 | add-lost
 v
CLI
 |
 | collect item information
 v
Validation
 |
 | valid
 v
ItemManager
 |
 v
Persistence
 |
 v
SQLite
 |
 v
Success message
```

### Add Found Item

```text
User
 |
 | add-found
 v
CLI
 |
 | collect item information
 v
Validation
 |
 v
ItemManager
 |
 v
Persistence
 |
 v
SQLite
 |
 v
Success message
```

### Search

```text
User
 |
 | search term
 v
CLI
 |
 v
ItemManager
 |
 v
Persistence
 |
 v
Search records
 |
 v
Display results
```

### Match

```text
User
 |
 | match ID
 v
CLI
 |
 v
ItemManager
 |
 v
Retrieve lost item
 |
 v
Retrieve found items
 |
 v
Compare attributes
 |
 v
Display possible matches
```

### Return Item

```text
User
 |
 | return ID
 v
CLI
 |
 v
ItemManager
 |
 v
Find item
 |
 v
Update status
 |
 v
Persist change
 |
 v
Display confirmation
```

---

## 14. Project Structure

A proposed project structure is:

```text
lost-and-found-tracker/
│
├── bin/
│   └── lost_and_found
│
├── lib/
│   ├── item.rb
│   ├── lost_item.rb
│   ├── found_item.rb
│   ├── item_manager.rb
│   └── ...
│
├── spec/
│   ├── item_spec.rb
│   ├── lost_item_spec.rb
│   ├── found_item_spec.rb
│   ├── item_manager_spec.rb
│   └── ...
│
├── db/
│   └── ...
│
├── docs/
│   └── user_stories.md
│
├── Gemfile
├── Gemfile.lock
├── README.md
└── design.md
```

The exact file structure may change as implementation progresses.

---

## 15. Testing Strategy

The project uses RSpec for automated testing.

Testing is divided into multiple levels.

### 15.1 Unit Tests

Unit tests verify individual components independently.

Examples include:

- Creating an `Item`
- Creating a `LostItem`
- Creating a `FoundItem`
- Validating required fields
- Searching items
- Matching items
- Updating item status

### 15.2 Integration Tests

Integration tests verify interactions between components.

Examples:

- Adding an item and retrieving it from persistent storage
- Searching records stored in SQLite
- Updating an item's status and verifying the persisted result

### 15.3 CLI Tests

The CLI should also be tested to verify that commands can be launched and expected output is displayed.

Example:

```bash
./bin/lost_and_found --help
```

The test should verify that the application starts successfully and displays the available commands.

### 15.4 Core Acceptance Scenarios

| Scenario | Expected Result |
|---|---|
| Add Lost Item | Lost item is stored and can be retrieved |
| Add Found Item | Found item is stored and can be retrieved |
| Search Items | Relevant records are returned |
| Match Items | Possible matching records are identified |
| Return Item | Lost item status changes to Returned |
| Invalid Input | Appropriate error is displayed |
| Invalid ID | Appropriate error is displayed |

---

## 16. Design for Future Extensions

The initial implementation is intentionally kept simple, but the architecture allows additional functionality.

### User Accounts

A future `User` model could be introduced:

```text
User
 |
 +-- LostItem records
 |
 +-- FoundItem records
```

Each item could contain a reference to the user who created the record.

### Automatic Match Notifications

The matching service could be extended to run whenever a new found item is added:

```text
New Found Item
      |
      v
Matching Service
      |
      v
Existing Lost Items
      |
      v
Possible Matches
      |
      v
Notification
```

### Item Photos

An item could optionally reference an image:

```text
Item
 |
 +-- name
 +-- description
 +-- location
 +-- date
 +-- photo
```

The core item management functionality would remain unchanged.

---

## 17. Design Principles

### Single Responsibility

Each component should have a focused responsibility.

For example:

- CLI handles user interaction.
- `ItemManager` handles application operations.
- Domain classes represent application entities.
- Persistence components handle database operations.

### Separation of Concerns

User-interface logic should not be tightly coupled to database operations.

### Reusability

Common item behavior should be implemented in `Item` and reused by `LostItem` and `FoundItem`.

### Testability

Business logic should be accessible independently of the CLI so it can be tested using RSpec.

### Extensibility

New functionality should be possible without rewriting the existing CLI and core item-management logic.

---

## 18. Summary

Lost & Found Tracker uses a simple layered architecture consisting of a terminal interface, application logic, domain models, and persistent storage.

The `Item`, `LostItem`, and `FoundItem` models represent the core domain entities, while `ItemManager` coordinates operations such as creating, searching, matching, and updating records.

SQLite provides persistent local storage, allowing users to retain records between application executions.

The design keeps the initial implementation small enough for a terminal-based course project while providing clear separation of responsibilities and a foundation for future features such as user accounts, automatic match notifications, and item photos.
