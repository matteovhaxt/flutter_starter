CREATE TABLE "User" (
    id TEXT PRIMARY KEY,
    auth_id TEXT NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    settings JSONB NOT NULL,
    birth_date DATE NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);
