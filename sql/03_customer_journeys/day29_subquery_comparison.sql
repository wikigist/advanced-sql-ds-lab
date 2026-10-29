-- Which customers have at least one unresolved support case?

SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
WHERE c.customer_id IN (
    SELECT customer_id
    FROM journey_cases
    WHERE resolved_at IS NULL
);


-- Customers with at least one unresolved case using IN
SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
WHERE c.customer_id IN (
    SELECT j.customer_id
    FROM journey_cases AS j
    WHERE j.resolved_at IS NULL
)
ORDER BY c.customer_id;


-- Match customers to their support cases, then keep the unresolved cases.

-- Customers with unresolved cases using JOIN
SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
INNER JOIN journey_cases AS j
    ON c.customer_id = j.customer_id
WHERE j.resolved_at IS NULL
ORDER BY c.customer_id;


-- I want a list of customers with at least one unresolved case. 
--I don't care how many unresolved cases each customer has.

SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
WHERE c.customer_id IN (
    SELECT j.customer_id
    FROM journey_cases AS j
    WHERE j.resolved_at IS NULL
);


-- Show David's name and the ID of each unresolved case.

SELECT
    c.name,
    j.case_id
FROM sales_customers AS c
INNER JOIN journey_cases AS j
    ON c.customer_id = j.customer_id
WHERE j.resolved_at IS NULL
  AND c.name = 'David';


-- Show whether David has at least one unresolved case. I don't need the case IDs.

SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
WHERE c.name = 'David'
  AND EXISTS (
      SELECT 1
      FROM journey_cases AS j
      WHERE j.customer_id = c.customer_id
        AND j.resolved_at IS NULL
  );

  -- using a join

  SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
INNER JOIN journey_cases AS j
    ON c.customer_id = j.customer_id
WHERE c.name = 'David'
  AND j.resolved_at IS NULL;


-- Show each customer who has at least one unresolved support case, but only show each customer once.

SELECT DISTINCT
    c.customer_id,
    c.name
FROM sales_customers AS c
INNER JOIN journey_cases AS j
    ON c.customer_id = j.customer_id
WHERE j.resolved_at IS NULL
ORDER BY c.customer_id;


-- Show every unresolved support case, including its case ID and the customer's name.

SELECT
    j.case_id,
    c.name
FROM journey_cases AS j
INNER JOIN sales_customers AS c
    ON j.customer_id = c.customer_id
WHERE j.resolved_at IS NULL
ORDER BY j.case_id;