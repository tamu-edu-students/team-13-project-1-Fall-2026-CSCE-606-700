# Lost & Found Tracker

_Project Proposal — Team 13, CSCE 606 (Fall 2026)_

## Team members

- Jianqiu Wang
- Aditya Vupparige Savitha Mowneshappa
- William Bourland

## App name

Lost & Found Tracker

## App description

Lost & Found Tracker is a terminal application that allows users to record lost
or found items, search existing records, and identify possible matches between
lost and found items. The application will use persistent local storage so
records remain available after the program is closed.

## Intended user

Students or members of a community who want an easy way to record, search for,
and recover lost belongings.

## Core features

- **Add a Lost Item** — Create a record with an item name, description, category,
  location, and date lost.
- **Add a Found Item** — Create a record with an item name, description, category,
  location, and date found.
- **List and Search Items** — View recorded items and search by item name,
  category, or location.
- **Match Lost and Found Items** — Compare lost and found records using details
  such as name, category, description, and location to identify possible matches.
- **Mark an Item as Returned** — Update a lost item's status to Returned once it
  has been recovered.

## Stretch features

- **User Accounts** — Allow users to create accounts and manage their own lost
  and found records.
- **Automatic Match Notifications** — Notify a user when a newly added found item
  appears to match one of their lost-item records.
- **Item Photos** — Allow users to attach an image to a lost or found item
  record.

## Main classes / modules

- **Item** — Stores common item information such as a unique ID, name,
  description, category, location, date, and status.
- **LostItem** — Represents a lost-item record and extends `Item` with
  information specific to a lost item.
- **FoundItem** — Represents a found-item record and extends `Item` with
  information specific to a found item.
- **ItemManager** — Handles adding, searching, matching, updating, and retrieving
  item records, as well as coordinating persistent storage.

## Test cases

- **Add a Lost Item** — Start with no items, add a lost item named "Black Wallet"
  with a valid description and location, and expect the item to appear in the
  lost-item list with the correct information.
- **Add a Found Item** — Start with no items, add a found item named "Car Keys,"
  and expect the item to appear in the found-item list with the correct
  information.
- **List and Search Items** — Start with several recorded items including a
  "Black Backpack," search for "Backpack," and expect the Black Backpack to
  appear while unrelated items do not.
- **Match Lost and Found Items** — Start with a lost "Black Wallet" and a found
  "Black Wallet" recorded at the same or nearby location, and expect the
  application to identify the found wallet as a possible match.
- **Mark an Item as Returned** — Start with a lost item whose status is "Lost,"
  mark it as returned, and expect its status to be "Returned" when the item is
  viewed again.

## Input validation

Required fields such as the item name and location must be provided. Invalid
input or an attempt to access an item that does not exist should produce an
appropriate error message.

## Project tracking

- Project board: <https://github.com/orgs/tamu-edu-students/projects/196>
- User stories: [`docs/user_stories.md`](docs/user_stories.md)

# Project Setup

## Prerequisites

Make sure you have Ruby and Bundler installed.

Check your Ruby version:

```bash
ruby --version
```

Check your Bundler version:
```bash 
bundle --version
```

If bundler is not installed:
```bash
gem install bundler
```

## Code Setup and execution

Fork this repository into your account and clone the forked repository

Install the required dependencies:
```bash
bundle install
```

make CLI executable
```bash
chmod +x bin/lost_and_found
```

Run the application
```bash
./bin/lost_and_found
```

To view available commands and options 
```bash
./bin/lost_and_found --help
```

Alternatively, you can run the application directly with Ruby:
```bash
bundle exec ruby bin/lost_and_found
```