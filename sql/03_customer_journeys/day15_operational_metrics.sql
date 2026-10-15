SELECT
    c.country,
    COUNT(jc.case_id) AS resolved_cases
FROM sales_customers AS c
INNER JOIN journey_cases AS jc
    ON c.customer_id = jc.customer_id
WHERE jc.resolved_at IS NOT NULL
GROUP BY c.country
HAVING COUNT(jc.case_id) > 1
ORDER BY c.country;



SELECT
    c.customer_id, c.name, 
    COUNT(jc.case_id) AS resolved_cases
FROM sales_customers AS c
INNER JOIN journey_cases AS jc
    ON c.customer_id = jc.customer_id
WHERE jc.resolved_at IS NOT NULL
AND c.country = 'Nigeria'
GROUP BY c.customer_id, c.name
--HAVING COUNT(jc.case_id) > 1
ORDER BY c.customer_id;
