-- How many customers have opened more than one support case?

WITH cases_per_customer AS (
    SELECT
        customer_id,
        COUNT(*) AS total_cases
    FROM journey_cases
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS customers_with_multiple_cases
FROM cases_per_customer
WHERE total_cases > 1;




-- What is the average number of customer contacts per support case, including cases that received no contacts?

WITH contacts_per_case AS (
    SELECT 
    c.case_id, COUNT(jc.contact_id) AS total_contacts
    FROM journey_cases c
    LEFT JOIN journey_contacts jc
    ON c.case_id = jc.case_id
    GROUP BY c.case_id
)

SELECT ROUND(AVG(total_contacts), 2) AS avg_contacts_per_case
FROM contacts_per_case;



WITH contacts_per_case AS (
    SELECT 
    c.case_id, COUNT(jc.contact_id) AS total_contacts
    FROM journey_cases c
    LEFT JOIN journey_contacts jc
    ON c.case_id = jc.case_id
    GROUP BY c.case_id
)

SELECT *
FROM contacts_per_case
ORDER BY case_id;

--SELECT name, customer_id, case_id
--FROM sales_customers sc 
--LEFT JOIN unresolved_cases uc 
--ON 



-- Show the customer names and case IDs for every unresolved support case.

WITH unresolved_cases AS (
    SELECT 
    customer_id, case_id
    FROM journey_cases
    WHERE resolved_at IS NULL
)

--SELECT *
--FROM unresolved_cases;

SELECT s.customer_id, s.name, u.case_id
FROM sales_customers s 
INNER JOIN unresolved_cases u
ON s.customer_id = u.customer_id
ORDER BY u.case_id;
