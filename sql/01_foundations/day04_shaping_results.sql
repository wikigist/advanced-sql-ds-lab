select name as customer_name, age, age + 5 as age_in_five_years
from customer_filtering_practice
order by age desc
limit 3;