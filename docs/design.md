# Lost & Found Tracker — Design and Implementation

## 1. Overview

Lost & Found Tracker is a Ruby terminal application backed by SQLite. The CLI supports adding lost and found records, listing records by status, matching lost items against found items, and marking a lost item as returned. Repository search exists but is not exposed through the menu.

## 2. Architecture

Responsibilities are split across the CLI, input/output helpers, application manager, models, repository, and database connection:

```text
bin/lost_and_found
        |
        v
CLI -- Prompts / Formatter
        |
        v
ItemManager
   |             |
   v             v
Item models   ItemRepository
                  |
                  v
             Database (SQLite)
```

- `LostAndFound::CLI` displays the numbered menu and dispatches operations.
- `Prompts` reads input and validates required fields, dates, and numeric IDs.
- `Formatter` prints item lists, messages, and errors, including empty-list messages.
- `ItemManager` coordinates item creation, retrieval, status filtering, and updates.
- `ItemRepository` maps model instances to SQLite rows and supports filtered searches.
- `Database` opens the SQLite connection and applies `db/schema.sql`.

## 3. Domain and Persistence

`Item` contains the shared `id`, `name`, `description`, `category`, `location`, `date`, and `status` attributes. `LostItem` and `FoundItem` specialize the date accessor and default status.

Both model types are stored in the `items` table. The `type` column identifies the model class; the status is `Lost`, `Found`, or `Returned`. The schema is in `db/schema.sql`, and the default database file is `data/lost_and_found.sqlite3`. The local `data/` directory is ignored by Git.

The repository supports creating, retrieving, listing, searching, updating, and deleting records. Search filters are case-insensitive partial matches across `name`, `description`, `category`, `location`, `date`, and `status`; multiple supplied filters are combined.

## 4. CLI Behavior

Run `./bin/lost_and_found` to open the menu. Options allow users to add lost/found items, request matches, mark an item returned by numeric ID, list lost/found/returned items, or quit. `--help` and `-h` print the built-in help text.

When adding an item, name and location are required; dates use `MM/DD/YYYY`, and IDs must be numeric. Selecting a missing item ID produces an error. Empty status-specific lists are reported with a list-specific message. The menu lists Lost, Found, and Returned items separately. Search is implemented by `ItemManager#search_items` and the repository, but is not exposed as a menu option.

The return flow prompts for a "Lost item ID" and sets an existing record's status to `Returned`. The current implementation does not check the record's prior status, so any existing item's ID is accepted.

## 5. Matching

`MatchingService#find_matches` compares a query against items with `Found` status using name (weight 0.4), category (0.2), location (0.2), and description (0.2). Only nonblank query fields participate, and their weights are normalized by the sum of the supplied weights. Each field scores 1.0 for an exact case-insensitive match, 0.7 when one value contains the other, or a shared-word overlap ratio otherwise. A candidate is returned when its normalized score is at least 0.6. A query with no supplied fields produces no matches.

From the CLI, "Find matches for a lost item" asks for optional name, category, location, and description values. At least one value must be provided. The CLI creates a temporary `LostItem` query, does not save it, and displays matching found records or a no-match message. If there are no found items, it reports `No items found.` without prompting. The CLI does not prompt for a saved lost-item ID or offer a match-all-saved-items option. `ItemManager#match_item` and `#match_all_lost_items` remain available for saved lost records at the application layer, but are not wired to this menu flow.

## 6. Testing and CI

RSpec tests cover models, repository behavior, application operations, and CLI flows. Run the suite and lint checks with:

```bash
bundle exec rspec
bundle exec rubocop
```

GitHub Actions runs both checks for pull requests targeting `main`.
