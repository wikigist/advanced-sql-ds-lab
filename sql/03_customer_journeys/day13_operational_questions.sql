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