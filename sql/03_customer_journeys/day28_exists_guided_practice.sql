-- Which customers have placed at least one order worth more than £100?

SELECT
    c.customer_id,
    c.name
FROM sales_customers AS c
WHERE EXISTS (
    SELECT 1
    FROM sales_orders AS o
    WHERE o.customer_id = c.customer_id
      AND o.amount > 100
);


-- Which support cases have at least one customer contact recorded?

SELECT
    j.case_id,
    j.customer_id
FROM journey_cases AS j
WHERE EXISTS (
    SELECT 1
    FROM journey_contacts AS ct
    WHERE ct.case_id = j.case_id
)
ORDER BY j.case_id;


-- Which support cases have never received any customer contacts?

SELECT
    j.case_id,
    j.customer_id
FROM journey_cases AS j
WHERE NOT EXISTS (
    SELECT 1
    FROM journey_contacts AS ct
    WHERE ct.case_id = j.case_id
)
ORDER BY j.case_id;