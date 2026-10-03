-- Exercise 1: simple comparison
...

-- Exercise 2: AND
...

-- Exercise 3: IN
...

-- Exercise 4: IS NULL
...

-- Exercise 5: IS NOT NULL
...

-- Exercise 6: BETWEEN
...

-- Exercise 7: OR
...

-- Exercise 8: parentheses with AND/OR
...

-- Exercise 9: operator precedence bug
...

-- Exercise 10: corrected logic
...

-- Final challenge: combine IN and BETWEEN
...



select name, age, country
from customer_filtering_practice
where age > 35;


select name, age, country
from customer_filtering_practice
where country = 'Nigeria'
and age > 39;

select name, country
from customer_filtering_practice
where country in ('UK', 'Spain');

select name, country 
from customer_filtering_practice
where country is null;

select name, country 
from customer_filtering_practice
where country is not null;


select name, age 
from customer_filtering_practice
where age between 30 and 38;

select name, age, country
from customer_filtering_practice
where country = 'Nigeria'
or age <= 30;


select name, age, country
from customer_filtering_practice
where (country = 'Nigeria' or country = 'UK')
and age < 40;


select name, age, country
from customer_filtering_practice
where country in ('Nigeria', 'UK')
and age < 40;


SELECT name, age, country
FROM customer_filtering_practice
WHERE country = 'Nigeria'
   OR country = 'UK'
  AND age < 35;



select name, age, country
from customer_filtering_practice
where country in ('Nigeria', 'UK')
and age < 35;


SELECT name, age, country
FROM customer_filtering_practice
WHERE (country = 'Nigeria' OR country = 'UK')
  AND age < 35;


select name, age, country 
from customer_filtering_practice
where country in ('Nigeria', 'UK')
and age between 29 and 38;