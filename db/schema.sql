CREATE TABLE IF NOT EXISTS items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    category TEXT,
    location TEXT NOT NULL,
    date TEXT,
    status TEXT
);
