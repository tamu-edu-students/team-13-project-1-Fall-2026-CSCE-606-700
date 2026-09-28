# Automated Tests and Coverage

## Run the Tests

Install dependencies once, then run the complete suite from the repository root:

```bash
bundle install
bundle exec rspec
```

RSpec runs all files under `spec/`. Each example has expectations that determine
pass or failure, so no manual checking is needed. To run one area, pass its spec
path, for example:

```bash
bundle exec rspec spec/services/matching_service_spec.rb
```

## Test Layers and Core Behavior

| Test area | What it verifies | Examples |
|---|---|---|
| Unit tests | Models, prompt validation, and matching behavior in isolation | `spec/models/`, `spec/ui/prompts_spec.rb`, `spec/services/matching_service_spec.rb` |
| Application and persistence tests | Manager operations and SQLite repository behavior, including persistence across connections | `spec/item_manager_spec.rb`, `spec/repositories/item_repository_spec.rb` |
| CLI acceptance-style tests | User-facing menu flows for adding, listing, matching, and returning items | `spec/cli_spec.rb` |

The CLI tests cover successful workflows and error conditions. Happy paths
include recording items, listing by status, finding matches, and marking an
item returned. Sad paths include blank required input, invalid dates and IDs,
missing records, empty match criteria, and unrelated match candidates.

The CLI flow tests use `StringIO` for repeatable input/output and a fresh
in-memory repository. Manager and repository tests use temporary SQLite
databases and remove them after each example. This keeps tests independent of
the checked-in database and avoids relying on test order.

## Coverage Report

SimpleCov starts from `spec/spec_helper.rb` and excludes the spec files from
application coverage. Running the full suite generates `coverage/index.html`.
Open it in a browser to view the summary and line-by-line results:

```bash
open coverage/index.html      # macOS
xdg-open coverage/index.html  # Linux
start coverage/index.html     # Windows
```

Verification snapshot for 2026-09-28:

- `bundle exec rspec`: 59 examples, 0 failures
- SimpleCov line coverage: 96.15% (300 of 312 lines)

SimpleCov reports line coverage; this is useful evidence of executed
application code, but coverage percentage alone does not establish test
quality. The focused unit and user-flow tests above provide evidence for core
behavior and both successful and error cases. The generated `coverage/`
directory is ignored by Git and is regenerated on each test run.