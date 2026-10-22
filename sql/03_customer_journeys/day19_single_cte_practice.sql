-- Show each customer's name, total number of support cases, and number of unresolved cases 
-- but only show customers who currently have at least one unresolved case.


WITH customer_case_summary AS (
    SELECT
        c.customer_id,
        c.name,
        COUNT(j.case_id) AS total_cases,
        COUNT(j.case_id) FILTER (
            WHERE j.resolved_at IS NULL
        ) AS unresolved_cases
    FROM sales_customers AS c
    LEFT JOIN journey_cases AS j
        ON c.customer_id = j.customer_id
    GROUP BY c.customer_id, c.name
)
SELECT
    name,
    total_cases,
    unresolved_cases
FROM customer_case_summary
WHERE unresolved_cases > 0
ORDER BY name;
