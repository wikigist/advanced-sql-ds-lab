SELECT COUNT(*) AS customer_count, SUM(age) AS total_age, AVG(age) AS average_age, MIN(age) AS youngest_age,
MAX(age) AS oldest_age

FROM customer_filtering_practice;


SELECT COUNT(*) AS customer_count, AVG(age) AS average_age
FROM customer_filtering_practice
WHERE country = 'Nigeria';


SELECT COUNT(country) AS customers_with_known_country, COUNT(DISTINCT country) AS unique_countries
FROM customer_filtering_practice;

SELECT COUNT(country) AS customers_with_known_country, AVG(age) AS average_age, MIN(age) AS youngest_age, 
MAX(age) AS oldest_age
FROM customer_filtering_practice
WHERE country IS NOT NULL;



SELECT COUNT(*) AS customer_count, AVG(age) AS average_age, MAX(age) AS oldest_age
FROM customer_filtering_practice
WHERE age >= 30
AND country IS NOT NULL;