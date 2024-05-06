CREATE TABLE "User" (
    id TEXT PRIMARY KEY,
    auth_id TEXT NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    birth_date DATE NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE "Settings" (
    id TEXT PRIMARY KEY,
    user_id TEXT REFERENCES "User"(id) NOT NULL,
    theme TEXT NOT NULL,
    locale TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

