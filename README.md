# Lost & Found Tracker

**Team 13, CSCE 606 (Fall 2026)**

## Team Members

- Jianqiu Wang
- Aditya Vupparige Savitha Mowneshappa
- William Bourland

## Overview

Lost & Found Tracker is a Ruby terminal application for recording and managing lost and found items. It stores records in a local SQLite database at `data/lost_and_found.sqlite3`.

## Features

- Record a lost item or a found item with name, description, category, location, and date
- List items by status (all, lost, found, or returned)
- Find possible matches between a lost item and found items, using a weighted comparison of name, category, location, and description
- Mark a lost item as returned once it has been recovered
- Persistent local storage: records survive across application restarts
- Input validation with clear error messages for required fields, invalid dates, and unknown IDs

## Known Limitations

- Repository search (`ItemManager#search_items`) is implemented and tested but is not exposed as its own menu option
- User accounts, automatic match notifications, and item photos are stretch features and are not implemented — see [docs/user_stories.md](docs/user_stories.md) and [docs/backlog.md](docs/backlog.md)

## Installation / Setup

### Requirements

- Ruby
- Bundler

Check the installed versions with:

```bash
ruby --version
bundle --version
```

### Install dependencies

Clone the repository, then install the gems with Bundler:

```bash
git clone https://github.com/tamu-edu-students/team-13-project-1-Fall-2026-CSCE-606-700.git
cd team-13-project-1-Fall-2026-CSCE-606-700
bundle install
```

This installs `rspec`, `rubocop`, `simplecov`, and `sqlite3` as declared in the [Gemfile](Gemfile).

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

See [the test coverage guide](docs/test_coverage.md) for how the specs map to
core behavior and how to interpret the SimpleCov report.

### Generating a Coverage Report

Test runs are instrumented with [SimpleCov](https://github.com/simplecov-ruby/simplecov) (configured in `spec/spec_helper.rb`, loaded automatically via `.rspec`). Running the test suite generates the report:

```bash
bundle exec rspec
```

Open the generated report in a browser to view line-by-line coverage:

```bash
open coverage/index.html      # macOS
xdg-open coverage/index.html  # Linux
start coverage/index.html     # Windows
```

The `coverage/` directory is regenerated on every run and is ignored by Git.

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

## Further Reading

See [the user stories](docs/user_stories.md) for story status and [the design document](docs/design.md) for the current architecture and behavior.
