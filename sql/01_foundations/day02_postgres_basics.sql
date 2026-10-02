-- Day 2: PostgreSQL basics
-- Date: 2026-10-02

-- Return every column and every row
SELECT *
FROM customers;

-- Return specific columns
SELECT name, country
FROM customers;

-- Filter rows using WHERE
SELECT name, country
FROM customers
WHERE country = 'Nigeria';