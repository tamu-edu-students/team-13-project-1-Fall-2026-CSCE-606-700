# Lost & Found Tracker

**Team 13, CSCE 606 (Fall 2026)**

## Team Members

- Jianqiu Wang
- Aditya Vupparige Savitha Mowneshappa
- William Bourland

## Overview

Lost & Found Tracker is a Ruby terminal application for recording and managing lost and found items. It stores records in a local SQLite database at `data/lost_and_found.sqlite3`.

The interactive menu supports adding lost and found items, listing items by status, and marking a lost item as returned. Matching is incomplete: the menu reports that no items were found without prompting when there are no found records; otherwise, it requests name, category, and location filters but does not calculate lost-to-found similarity. Repository search is implemented but is not available from the menu.

## Requirements

- Ruby
- Bundler

Check the installed versions with `ruby --version` and `bundle --version`. Install dependencies with:

```bash
bundle install
```

## Run the Application

Start the interactive menu:

```bash
./bin/lost_and_found
```

The menu options are:

```text
1. Add a lost item
2. Add a found item
3. Find matches for a lost item
4. Mark an item as returned
5. List all lost items
6. List all found items
7. List all returned items
8. Quit
```

The CLI also accepts `--help` and `-h` to display its built-in help text.

Item name and location are required. Dates use `MM/DD/YYYY`; item IDs must be numeric. The application creates the SQLite database and schema automatically when it connects. Local data under `data/` is ignored by Git.

## Tests and Lint

Run the test suite and linter with:

```bash
bundle exec rspec
bundle exec rubocop
```

GitHub Actions runs both commands for pull requests targeting `main`.

## Project Structure

```text
bin/lost_and_found
 data/                         Local SQLite database (created at runtime)
 db/schema.sql                 Database schema
 docs/                         Planning, design, and user stories
 lib/lost_and_found/
   cli.rb                      Interactive CLI
   item_manager.rb             Application operations
   models/                     Item, LostItem, and FoundItem
   repositories/                SQLite-backed item repository
   services/                    Matching service
   storage/                     Database connection and setup
   ui/                          Prompts and output formatting
 spec/                          RSpec tests
 Gemfile
 Gemfile.lock
 README.md
```

## Current Scope

User accounts, automatic match notifications, and item photos are not implemented. See [the user stories](docs/user_stories.md) for story status and [the design document](docs/design.md) for the current architecture and behavior.
