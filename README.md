# Lost & Found Tracker

**Project Proposal — Team 13, CSCE 606 (Fall 2026)**

## Team Members

- Jianqiu Wang
- Aditya Vupparige Savitha Mowneshappa
- William Bourland

---

## Project Description

Lost & Found Tracker is a Ruby-based terminal application that allows users to record, search, and manage lost and found items.

Users can add lost or found item records, search existing records, identify possible matches between lost and found items, and mark lost items as returned.

The application uses persistent local storage so that records remain available after the program is closed.

The intended users are students or members of a community who want a simple way to report, search for, and recover lost belongings.

---

## Main Features

### 1. Add a Lost Item

Users can create a lost-item record containing:

- Item name
- Description
- Category
- Location
- Date lost
- Status

### 2. Add a Found Item

Users can create a found-item record containing:

- Item name
- Description
- Category
- Location
- Date found
- Status

### 3. List and Search Items

Users can view existing records and search for items using information such as:

- Item name
- Category
- Location

### 4. Match Lost and Found Items

The application compares lost and found records using attributes such as:

- Name
- Category
- Description
- Location

The application identifies possible matches rather than automatically declaring that two records belong to the same physical item.

### 5. Mark an Item as Returned

Users can update a lost item's status to `Returned` after the item has been recovered.

### 6. Input Validation

Required fields such as item name and location are validated. Invalid input and attempts to access non-existent records result in appropriate error messages.

### 7. Persistent Storage

Lost and found records are stored locally so that they remain available between application executions.

---

## Prerequisites

Make sure Ruby and Bundler are installed.

Check your Ruby version:

```bash
ruby --version
```

Check your Bundler version:

```bash
bundle --version
```

If Bundler is not installed:

```bash
gem install bundler
```

---

## Installation and Setup

### 1. Clone the Repository

Fork the repository into your GitHub account and clone your fork:

```bash
git clone <your-repository-url>
cd lost-and-found-tracker
```

### 2. Install Dependencies

Install the required Ruby gems using Bundler:

```bash
bundle install
```

### 3. Make the CLI Executable

Run:

```bash
chmod +x bin/lost_and_found
```

---

## Running the Application

Run the application using:

```bash
./bin/lost_and_found
```

To view the available commands and options:

```bash
./bin/lost_and_found --help
```

Alternatively, the application can be run directly with Ruby:

```bash
bundle exec ruby bin/lost_and_found
```

---

## Running Tests

The project uses **RSpec** for automated testing.

Run the complete test suite with:

```bash
bundle exec rspec
```

You can also run RSpec directly if Bundler is configured appropriately:

```bash
rspec
```

A successful test run should report the number of examples that passed and any failures.

### Running a Specific Test File

To run a specific test file:

```bash
bundle exec rspec spec/item_spec.rb
```

Replace the file name with the test file you want to run.

---

## Test Coverage

The project uses **SimpleCov** to generate a test coverage report.

Run the test suite:

```bash
bundle exec rspec
```

After the tests finish, SimpleCov generates a coverage report in:

```text
coverage/
```

The main HTML coverage report can be opened at:

```text
coverage/index.html
```

The coverage report shows which parts of the application are exercised by the automated tests.

If the project requires SimpleCov to be explicitly enabled, the test setup should include:

```ruby
require 'simplecov'

SimpleCov.start
```

before the application code is loaded.

---

## Example Usage

Display available commands:

```bash
./bin/lost_and_found --help
```

The application provides commands for operations such as:

```text
add-lost
add-found
list
search
match ID
return ID
help
```

The exact arguments and prompts for each command are displayed through the application's help command.

---

## Project Structure

The project is organized approximately as follows:

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
├── docs/
│   ├── planning.md
│   ├── design.md
│   └── user_stories.md
│
├── Gemfile
├── Gemfile.lock
├── README.md
└── ...
```

The exact structure may change as development progresses.

---

## Known Limitations

The initial version of Lost & Found Tracker has the following limitations:

- The application is terminal-based and does not provide a graphical or web interface.
- Records are stored locally rather than on a shared server.
- The application does not currently provide user authentication or individual user accounts.
- Matching identifies possible matches based on available item information; it does not guarantee that two records refer to the same physical item.
- Automatic notifications for possible matches are not currently implemented.
- Item photos are not currently supported.
- The application is intended for local use and does not currently provide real-time synchronization between multiple users or devices.
- The initial version does not include a dedicated administrative system for managing or moderating records.

These limitations may be addressed in future versions if the corresponding stretch features are implemented.

---

## Testing Scope

The core functionality is tested using RSpec.

The test suite covers functionality such as:

- Adding lost items
- Adding found items
- Listing and searching items
- Matching lost and found items
- Marking items as returned
- Input validation
- Handling invalid item IDs
- CLI behavior where applicable
- Persistence-related behavior where applicable

The coverage report can be used to identify areas of the code that are not sufficiently exercised by the test suite.

---

## Documentation

Additional project documentation is available in the `docs/` directory:

- [`docs/planning.md`](docs/planning.md) — Project planning, feature prioritization, collaboration approach, and definition of done.
- [`docs/design.md`](docs/design.md) — Application architecture, domain model, persistence design, matching approach, and testing strategy.
- [`docs/user_stories.md`](docs/user_stories.md) — User stories and acceptance criteria.

---

## Project Tracking

Project board:

https://github.com/orgs/tamu-edu-students/projects/196

---

## License

This project was developed as part of **CSCE 606 — Software Engineering** at Texas A&M University during Fall 2026.
