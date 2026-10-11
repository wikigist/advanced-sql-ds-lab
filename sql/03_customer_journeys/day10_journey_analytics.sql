-- DAY 10: CUSTOMER JOURNEY ANALYTICS
-- Dataset: Synthetic customer service cases

DROP TABLE IF EXISTS journey_cases;
DROP TABLE IF EXISTS journey_contacts;

CREATE TABLE journey_cases (
    case_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    opened_at TIMESTAMP NOT NULL,
    resolved_at TIMESTAMP,
    sla_hours INTEGER NOT NULL
);

INSERT INTO journey_cases (
    case_id,
    customer_id,
    opened_at,
    resolved_at,
    sla_hours
)
VALUES
    (201, 1, '2026-10-01 09:00', '2026-10-01 13:00', 8),
    (202, 2, '2026-10-01 10:00', '2026-10-02 15:00', 24),
    (203, 2, '2026-10-03 11:00', NULL, 24),
    (204, 3, '2026-10-02 08:00', '2026-10-02 12:00', 8),
    (205, 4, '2026-10-04 14:00', '2026-10-06 16:00', 24),
    (206, 1, '2026-10-05 09:00', NULL, 8);

-- Check our data
SELECT *
FROM journey_cases
ORDER BY case_id;




SELECT COUNT(*) AS total_cases,
COUNT(*) FILTER (
    WHERE resolved_at IS NOT NULL
) AS resolved_cases,
COUNT(*) FILTER (
    WHERE resolved_at IS NULL
) AS unresolved_cases

FROM journey_cases;

SELECT
    case_id,
    sla_hours,
    resolved_at - opened_at AS resolution_time,
    CASE
        WHEN resolved_at - opened_at
             > sla_hours * INTERVAL '1 hour'
        THEN 'Breached SLA'
        ELSE 'Met SLA'
    END AS sla_status
FROM journey_cases
WHERE resolved_at IS NOT NULL
ORDER BY case_id;



-- DAY 11: Customer-level case metrics

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
ORDER BY c.customer_id;


-- DAY 11: Customer contacts dataset

CREATE TABLE journey_contacts (
    contact_id INTEGER PRIMARY KEY,
    case_id INTEGER NOT NULL
        REFERENCES journey_cases(case_id)
);

INSERT INTO journey_contacts (contact_id, case_id)
VALUES
    (301, 202),
    (302, 202),
    (303, 202),
    (304, 203),
    (305, 203),
    (306, 202);



-- Show David's cases and their contacts

SELECT
    j.case_id,
    ct.contact_id
FROM journey_cases AS j
INNER JOIN journey_contacts AS ct
    ON j.case_id = ct.case_id
WHERE j.customer_id = 2
ORDER BY j.case_id, ct.contact_id;



-- Day 11: Count David's cases with contacts and total contacts

SELECT
    j.customer_id,
    COUNT(DISTINCT j.case_id) AS cases_with_contacts,
    COUNT(ct.contact_id) AS total_contacts
FROM journey_cases AS j
INNER JOIN journey_contacts AS ct
    ON j.case_id = ct.case_id
WHERE j.customer_id = 2
GROUP BY j.customer_id;