SELECT COUNT(*) AS customer_count, country, AVG(age) as average_age
FROM customer_filtering_practice
WHERE country IS NOT NULL
GROUP BY country; 


SELECT country, COUNT(*) AS customer_count, MIN(age) AS youngest_age, MAX(age) AS oldest_age
FROM customer_filtering_practice
WHERE country IS NOT NULL
GROUP BY country; 


SELECT country, COUNT(*) AS customer_count
FROM customer_filtering_practice
WHERE country IS NOT NULL
GROUP BY country
HAVING COUNT(*) > 1;


SELECT country, COUNT(*) AS customer_count, AVG(age) AS average_age
FROM customer_filtering_practice
WHERE country IS NOT NULL
GROUP BY country
HAVING AVG(age) > 30
ORDER BY average_age DESC;


SELECT country, COUNT(*) AS customer_count, AVG(age) AS average_age
FROM customer_filtering_practice
WHERE country IS NOT NULL
GROUP BY country
HAVING AVG(age) > 30
ORDER BY average_age DESC
LIMIT 1;


SELECT country, COUNT(*) AS customer_count, AVG(age) AS average_age
FROM customer_filtering_practice
WHERE age >= 30
AND country IS NOT NULL
GROUP BY country
HAVING AVG(age) > 35
ORDER BY average_age DESC;
