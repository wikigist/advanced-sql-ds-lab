-- For each customer, show the total number of support cases 
-- they've opened and the total number of times they've contacted support.
-- The average number of contacts per support case, for each customer.

WITH contacts_per_customer AS (
    SELECT
    jc.customer_id,
    COUNT(ct.contact_id) AS total_contacts
FROM journey_cases AS jc
INNER JOIN journey_contacts AS ct
    ON jc.case_id = ct.case_id
    GROUP BY jc.customer_id
),
cases_per_customer AS (
    SELECT customer_id,
    COUNT(*) AS total_cases
    FROM journey_cases
    GROUP BY customer_id    
)

SELECT c.name, COALESCE(cc.total_cases, 0) AS total_cases, 
COALESCE(co.total_contacts, 0) AS total_contacts, ROUND(
    COALESCE(co.total_contacts, 0)::numeric
    / NULLIF(cc.total_cases, 0),
    2
) AS avg_contacts_per_case
FROM sales_customers c
LEFT JOIN cases_per_customer cc
    ON c.customer_id = cc.customer_id
LEFT JOIN contacts_per_customer co
    ON c.customer_id = co.customer_id
    ORDER BY c.customer_id;


-- Great. Now show me the total support cases and 
-- total customer contacts for each country instead of each individual customer.

WITH contacts_per_customer AS (
    SELECT
    jc.customer_id,
    COUNT(ct.contact_id) AS total_contacts
FROM journey_cases AS jc
INNER JOIN journey_contacts AS ct
    ON jc.case_id = ct.case_id
GROUP BY jc.customer_id
),
cases_per_customer AS (
    SELECT customer_id,
    COUNT(*) AS total_cases
    FROM journey_cases
    GROUP BY customer_id    
)
SELECT
    c.country,
    SUM(COALESCE(cc.total_cases, 0)) AS total_cases,
    SUM(COALESCE(co.total_contacts, 0)) AS total_contacts
FROM sales_customers AS c
LEFT JOIN cases_per_customer AS cc
    ON c.customer_id = cc.customer_id
LEFT JOIN contacts_per_customer AS co
    ON c.customer_id = co.customer_id
GROUP BY c.country
ORDER BY c.country;
