-- Day 3: Filtering, Boolean Logic and NULL
-- Date: 2026-10-03

CREATE TABLE customer_filtering_practice (
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER,
    country TEXT
);

INSERT INTO customer_filtering_practice (customer_id, name, age, country)
VALUES
    (1, 'Ada', 29, 'UK'),
    (2, 'David', 41, 'Nigeria'),
    (3, 'Sofia', 35, 'Spain'),
    (4, 'Tunde', 38, 'Nigeria'),
    (5, 'Maya', 30, NULL);