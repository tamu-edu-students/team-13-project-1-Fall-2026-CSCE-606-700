# Lost & Found Tracker — Design and Implementation

## 1. Overview

Lost & Found Tracker is a Ruby terminal application backed by SQLite. The CLI supports adding lost and found records, listing records by status, and marking a lost item as returned. Repository search exists but is not exposed through the menu. The match menu does not implement lost-to-found similarity scoring.

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

Names and locations are required. Dates are accepted in `MM/DD/YYYY` format, and IDs must be numeric. Selecting a missing item ID produces an error. Empty status-specific lists are reported with a list-specific message.

## 5. Matching Status

The CLI's match option is not yet a matching algorithm. If no found items exist, it displays `No items found.` and skips filter prompts. If found items exist, it prompts for name, category, and location and displays matching inventory records. It does not yet compare lost items against found items or calculate a similarity score. A true comparison algorithm remains future work.

## 6. Testing and CI

RSpec tests cover models, repository behavior, application operations, and CLI flows. Run the suite and lint checks with:

```bash
bundle exec rspec
bundle exec rubocop
```

GitHub Actions runs both checks for pull requests targeting `main`.
