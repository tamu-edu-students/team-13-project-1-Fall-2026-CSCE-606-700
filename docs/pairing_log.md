# Pairing Log

## Session 1 — 2026-09-10

Driver: Aditya Vupparige Savitha Mowneshappa  
Navigator: William Bourland  

Work completed:
- Set up the Ruby project scaffold and RSpec test framework.
- Defined the initial user stories, essential features, and application structure.
- Established the terminal-based workflow and separation between CLI, domain, and storage code.

Notes:
- Kept user input and output behind CLI/UI components so application logic could be tested independently.

## Session 2 — 2026-09-14

Driver: Jianqiu Wang  
Navigator: Aditya Vupparige Savitha Mowneshappa  

Work completed:
- Implemented the shared `Item` model and the `LostItem` and `FoundItem` types.
- Added `ItemManager` operations for adding, retrieving, searching, and updating items.
- Added validation and tests for core model and manager behavior.

Notes:
- Used status to distinguish lost, found, and returned records while sharing common item fields.

## Session 3 — 2026-09-18

Driver: William Bourland  
Navigator: Jianqiu Wang  

Work completed:
- Implemented SQLite-backed storage and the item repository.
- Added database schema and persistence so records remain available between application runs.
- Added repository tests for create, retrieve, search, and update behavior.

Notes:
- Kept persistence behind the repository interface so the manager can use a test double in specs.

## Session 4 — 2026-09-22

Driver: Aditya Vupparige Savitha Mowneshappa  
Navigator: Jianqiu Wang  

Work completed:
- Built the interactive menu and CLI flows for recording lost and found items.
- Added item listing, returned-item handling, formatted output, and prompt validation.
- Added CLI specs for menu navigation and the main item-management workflows.

Notes:
- Ensured end-of-input exits cleanly and invalid required input is handled with a clear prompt.

## Session 5 — 2026-09-25

Driver: Jianqiu Wang  
Navigator: William Bourland  

Work completed:
- Implemented weighted matching across item name, category, location, and description.
- Added similarity handling for partially overlapping text and tests for positive and unrelated candidates.
- Connected match results to the terminal output.

Notes:
- Displayed suggestions as possible matches rather than automatically changing item status.

## Session 6 — 2026-09-28

Driver: William Bourland  
Navigator: Aditya Vupparige Savitha Mowneshappa  

Work completed:
- Updated match finding to accept optional name, category, location, and description criteria instead of requiring an item ID.
- Normalized match scores over only the criteria supplied and added coverage for single-field and blank searches.
- Ran the project specs and RuboCop, then addressed the reported code style issues.

Notes:
- A match query is not saved as a new item; it is passed directly to the matching service.
