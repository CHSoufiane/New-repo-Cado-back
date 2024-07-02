-- Deploy cado:create-table to pg

BEGIN;

DROP TABLE IF EXISTS "user", "event", "draw", "event_user";

CREATE TABLE "user" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT,
    "is_registered" BOOLEAN NOT NULL DEFAULT FALSE,
    "token" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "event" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL,
    "date" DATE NOT NULL,
    "organizer_id" INTEGER NOT NULL REFERENCES "user"("id"),
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);


CREATE TABLE "draw" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "event_id" INTEGER NOT NULL REFERENCES "event"("id"),
    "giver_id" INTEGER NOT NULL REFERENCES "user"("id"),
    "receiver_id" INTEGER NOT NULL REFERENCES "user"("id"),
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "event_user" (
    "event_id" INTEGER NOT NULL REFERENCES "event"("id") ON DELETE CASCADE,
    "user_id" INTEGER NOT NULL REFERENCES "user"("id") ON DELETE CASCADE,
    PRIMARY KEY ("event_id", "user_id")
);

COMMIT;
<<<<<<< HEAD:migrations/deploy/create-table.sql

=======
>>>>>>> db68a498ee46e19fe08f659a8036e57e8710da14:data/create_tables.sql
