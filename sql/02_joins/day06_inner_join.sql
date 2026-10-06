DROP TABLE IF EXISTS sales_orders;
DROP TABLE IF EXISTS sales_customers;

CREATE TABLE sales_customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    country TEXT
);

CREATE TABLE sales_orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    amount NUMERIC,
    FOREIGN KEY (customer_id)
        REFERENCES sales_customers(customer_id)
);

INSERT INTO sales_customers (customer_id, name, country)
VALUES
    (1, 'Ada', 'UK'),
    (2, 'David', 'Nigeria'),
    (3, 'Sofia', 'Spain'),
    (4, 'Tunde', 'Nigeria');

INSERT INTO sales_orders (order_id, customer_id, amount)
VALUES
    (101, 1, 50),
    (102, 2, 120),
    (103, 2, 80),
    (104, 4, 200);



SELECT
    sales_orders.order_id,
    sales_customers.name,
    sales_orders.amount
FROM sales_orders
INNER JOIN sales_customers
    ON sales_orders.customer_id = sales_customers.customer_id;



SELECT
    sales_customers.name,
    sales_customers.country,
    sales_orders.amount
FROM sales_customers
INNER JOIN sales_orders
    ON sales_customers.customer_id = sales_orders.customer_id;


SELECT
    sales_orders.order_id,
    sales_customers.name,
    sales_customers.country,
    sales_orders.amount
FROM sales_customers
INNER JOIN sales_orders
    ON sales_customers.customer_id = sales_orders.customer_id;



SELECT
    o.order_id,
    c.name,
    c.country,
    o.amount
FROM sales_customers AS c
INNER JOIN sales_orders AS o
    ON c.customer_id = o.customer_id;



SELECT
    o.order_id,
    c.name,
    c.country,
    o.amount
FROM sales_customers AS c
INNER JOIN sales_orders AS o
    ON c.customer_id = o.customer_id

WHERE c.country = 'Nigeria';




SELECT
    o.order_id,
    c.name,
    c.country,
    o.amount
FROM sales_customers AS c
INNER JOIN sales_orders AS o
    ON c.customer_id = o.customer_id

WHERE o.amount > 100;