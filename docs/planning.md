# Lost & Found Tracker — Project Planning

## 1. Planning Discussion

The team held an initial planning discussion to define the scope of the Lost & Found Tracker project, identify the features required for the first version, establish how the team would collaborate, and agree on what would count as complete work.

The goal was to build a simple terminal-based application that would be useful for students or community members who have lost or found personal belongings.

### Team Members

- Jianqiu Wang
- Aditya Vupparige Savitha Mowneshappa
- William Bourland

---

## 2. Application to Build

The team decided to build **Lost & Found Tracker**, a Ruby terminal application for managing lost and found item records.

The application allows a user to:

- Record an item that they have lost.
- Record an item that they have found.
- List existing lost and found records.
- Search records by relevant item information.
- Find possible matches between lost and found items.
- Mark a lost item as returned after it has been recovered.

The application will use persistent local storage so that records are not lost when the program exits.

The initial implementation is intentionally terminal-based to keep the project focused on the core functionality required for the course.

---

## 3. Feature Prioritization

The team divided the planned functionality into **essential features** and **optional/stretch features**.

### 3.1 Essential Features

The following features are required for the initial version of the application.

#### Add Lost Item

Users should be able to create a lost-item record containing information such as:

- Item name
- Description
- Category
- Location
- Date lost
- Status

A successfully created record must be persisted and available when the application is run again.

#### Add Found Item

Users should be able to create a found-item record containing information such as:

- Item name
- Description
- Category
- Location
- Date found
- Status

The record must be persisted so it can later be searched or compared with lost items.

#### List and Search Items

Users should be able to view stored records and search for items using information such as:

- Item name
- Category
- Location

Search results should contain relevant records and should not return unrelated records.

#### Match Lost and Found Items

The application should compare lost and found records and identify possible matches using information such as:

- Name
- Category
- Description
- Location

The application should identify these as **possible matches** rather than automatically assuming that two records represent the same physical item.

#### Mark an Item as Returned

A lost item should be able to be marked as `Returned` after the item has been recovered.

The updated status must be persisted.

#### Input Validation

Required fields such as item name and location must be validated.

The application should also handle attempts to access items that do not exist and display an appropriate error message.

#### Persistent Storage

The application must store records persistently using local storage so that data remains available between executions.

---

## 4. Optional / Stretch Features

The following features were identified as useful extensions but are not required for the core project.

### User Accounts

Users could create accounts and manage their own lost and found records.

This would allow records to be associated with the person who created them.

### Automatic Match Notifications

The application could automatically notify a user when a newly added found item appears to match one of their lost-item records.

### Item Photos

Users could attach photos to lost or found item records.

These features will only be considered after the essential functionality is implemented and tested.

The team agreed that stretch features should not interfere with completing the required core functionality.

---

## 5. Technical Plan

The team selected the following technologies for the initial implementation:

| Area | Technology |
|---|---|
| Language | Ruby |
| Interface | Terminal / CLI |
| Persistence | SQLite |
| Testing | RSpec |
| Dependency Management | Bundler |
| Version Control | Git / GitHub |

The application will be structured around domain classes such as:

- `Item`
- `LostItem`
- `FoundItem`
- `ItemManager`

The team will keep CLI handling, application logic, domain models, and persistence responsibilities separated where practical.

---

## 6. Collaboration Plan

The team will use GitHub for source control and collaboration.

### Branching and Pull Requests

Team members will work on separate branches for individual pieces of functionality or tasks.

A typical workflow is:

```text
main
 |
 +---- feature branch
 |          |
 |          +-- implementation
 |          +-- tests
 |          |
 |          v
 |        Pull Request
 |          |
 +----------+
            |
            v
          main
```

Changes should be reviewed before being merged into the main development branch.

### Individual vs. Pair Programming

The team will primarily use **individual development** for well-defined tasks so that team members can work on different parts of the application in parallel.

Examples of tasks that can be developed independently include:

- Domain model implementation
- Database/persistence implementation
- CLI commands
- Search functionality
- Matching functionality
- Automated tests
- Documentation

The team will use **pair programming or collaborative sessions** when a task involves multiple components, when an implementation decision needs discussion, or when a team member needs help understanding or debugging another part of the codebase.

Examples include:

- Designing the initial application structure
- Integrating persistence with the application logic
- Resolving merge/integration issues
- Debugging complex behavior
- Reviewing the matching logic

This approach allows the team to maintain individual ownership of tasks while still collaborating on decisions that affect the overall architecture.

---

## 7. Work Organization

The team will divide work according to the major parts of the application.

Potential work areas include:

### Domain and Models

Implement:

- `Item`
- `LostItem`
- `FoundItem`

and their associated validation and behavior.

### Persistence

Implement the SQLite database and the functionality required to:

- Store records
- Retrieve records
- Search records
- Update records

### Application Logic

Implement `ItemManager` and operations such as:

- Adding lost items
- Adding found items
- Listing items
- Searching items
- Matching items
- Returning items

### CLI

Implement terminal commands and user interaction.

### Testing

Create RSpec tests for:

- Domain behavior
- Application logic
- Persistence
- CLI behavior where appropriate

### Documentation

Maintain:

- `README.md`
- `docs/planning.md`
- `docs/design.md`
- User stories and related project documentation

---

## 8. Definition of Done

The team agreed that a feature is not considered complete simply because the implementation works locally.

A feature/story is considered **Done** when:

1. The required functionality has been implemented.
2. The feature works through the intended application interface.
3. Relevant input validation has been implemented.
4. Appropriate automated tests have been added or updated.
5. Existing tests continue to pass.
6. Persistent data is correctly stored when persistence is required.
7. Error cases are handled appropriately.
8. The code has been reviewed by the team or through the project's pull-request process.
9. The feature does not break existing functionality.
10. Any necessary documentation has been updated.

---

## 9. Definition of Done for Individual Stories

For an individual user story, the team will use the following checklist:

```text
[ ] User story requirements are understood
[ ] Implementation is complete
[ ] Acceptance criteria are satisfied
[ ] Input validation is handled
[ ] Error cases are handled
[ ] Automated tests are added/updated
[ ] Tests pass
[ ] Persistence works when applicable
[ ] Code is reviewed
[ ] Changes are integrated into the main project
[ ] Documentation is updated when necessary
```

For example, the **Add Lost Item** story is complete when a user can enter valid lost-item information, the application validates the input, creates the record, persists it, retrieves it later, and the corresponding behavior is covered by tests.

---

## 10. Definition of Done for the Project

The entire project will be considered complete when all essential functionality is implemented and integrated.

The minimum completed application should allow a user to:

```text
Add Lost Item
      |
      v
Add Found Item
      |
      v
List / Search Items
      |
      v
Match Lost and Found Items
      |
      v
Mark Lost Item as Returned
```

In addition:

- Data must persist between application executions.
- Required inputs must be validated.
- Invalid operations must produce appropriate error messages.
- Core functionality must have automated test coverage.
- The application must be executable from the terminal using the documented setup instructions.
- The README and project documentation must describe how to install, run, and use the application.

---

## 11. Scope Management

The team agreed to prioritize the essential features before implementing stretch functionality.

The development order is:

1. Establish the project structure and CLI.
2. Implement the item/domain models.
3. Implement persistent storage.
4. Implement adding lost and found items.
5. Implement listing and searching.
6. Implement matching.
7. Implement returning items.
8. Add validation and error handling.
9. Add and refine automated tests.
10. Consider stretch features if sufficient time remains.

This order ensures that the team has a working core application before spending time on optional functionality.

---

## 12. Expected Development Process

The team will develop incrementally rather than implementing the entire application at once.

For each feature, the general process will be:

```text
User Story
    |
    v
Discuss Requirements
    |
    v
Implement
    |
    v
Write / Update Tests
    |
    v
Run Tests
    |
    v
Code Review
    |
    v
Merge
    |
    v
Update Documentation
```

This process allows the team to identify integration problems early and keeps the project in a working state throughout development.

---

## 13. Planning Outcome

The planning discussion established a clear minimum scope for the Lost & Found Tracker and prevented optional features from taking priority over the required functionality.

The team's primary goal is to deliver a reliable terminal application with persistent storage, clear separation of responsibilities, input validation, automated tests, and the five core user-facing capabilities:

1. Add lost items.
2. Add found items.
3. List and search items.
4. Match lost and found items.
5. Mark lost items as returned.

Stretch features such as user accounts, automatic notifications, and item photos will remain secondary and will only be pursued after the core application is complete.
