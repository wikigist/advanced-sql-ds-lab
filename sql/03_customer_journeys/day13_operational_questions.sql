-- Exercise 1: Cases with more than 2 contacts

SELECT
    j.case_id,
    COUNT(ct.contact_id) AS contact_count
FROM journey_cases AS j
LEFT JOIN journey_contacts AS ct
    ON j.case_id = ct.case_id
GROUP BY j.case_id
HAVING COUNT(ct.contact_id) > 2
ORDER BY j.case_id;



SELECT c.customer_id, COUNT(j.case_id) AS case_count
FROM sales_customers c
LEFT JOIN journey_cases j
ON c.customer_id = j.customer_id
GROUP BY c.customer_id
HAVING COUNT(j.case_id) > 1
ORDER BY c.customer_id;



SELECT
    c.customer_id,
    c.name,
    COUNT(j.case_id) AS total_cases
FROM sales_customers AS c
INNER JOIN journey_cases AS j
    ON c.customer_id = j.customer_id
WHERE c.country = 'Nigeria'
GROUP BY c.customer_id, c.name
HAVING COUNT(j.case_id) > 1
ORDER BY c.customer_id;



SELECT
    c.customer_id,
    c.name,
    COUNT(j.case_id) AS total_cases
FROM sales_customers AS c
INNER JOIN journey_cases AS j
    ON c.customer_id = j.customer_id
WHERE c.country = 'Nigeria'
GROUP BY c.customer_id, c.name
--HAVING COUNT(j.case_id) > 1
ORDER BY c.customer_id;