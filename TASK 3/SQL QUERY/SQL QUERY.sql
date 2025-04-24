create database ecommerce;

USE ecommerce;

--  CUSTOMER TABLE
create table customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50)
);

-- ORDER TABLE
create table orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- PRODUCT TABLE
create table products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- ALL DATA INSERT

-- DATA INSERT IN CUSTOMERS TABLE
insert into customers values
(1, 'het', 'india'),
(2, 'naruto', 'japan'),
(3, 'gojo', 'japan'),
(4, 'nishimiya', 'japan'),
(5, 'ips', 'india');

-- DATA INSERT IN ORDERS TABLE
insert into orders values
(101, 1, 1200.50),
(102, 2, 450.00),
(103, 1, 750.25),
(104, 1, 750.25),
(105, 3, 300.00);

-- DATA INSERT IN PRODUCTS TABLE
insert into  products values
(1, 'Laptop', 800.00),
(2, 'Smartphone', 500.00),
(3, 'Smartwatch', 5000.00),
(4, 'Headphones', 100.00);

-- ALL QUERIES

-- a . Use SELECT, WHERE, ORDER BY, GROUP BY
SELECT * FROM customers WHERE country = 'india';

SELECT * FROM orders ORDER BY total_amount DESC;

select customer_id, sum(total_amount) as total_spent
from orders
group by customer_id;

-- b . Use JOINS (INNER, LEFT, RIGHT)

-- INNER JOIN
select o.order_id, c.name, o.total_amount
from orders o
inner join customers c on o.customer_id = c.customer_id;

-- LEFT JOIN
select c.name, o.order_id
from customers c
left join orders o on c.customer_id = o.customer_id;

-- c . Write subqueries

select name from customers
where customer_id in (
  select customer_id from orders
  where total_amount > (select  avg(total_amount) from orders)
);

-- d . Use aggregate functions (SUM, AVG)

select customer_id, sum(total_amount) as total_spent
from orders
group by customer_id;

select customer_id, avg(total_amount) as average_order
from orders
group by customer_id;

-- e .  Create views for analysis

create view big_orders as
select * from orders where total_amount > 1000;

-- Use the view
select * from big_orders;

-- f . Optimize queries with indexes

-- Create an index on customer_id for faster search
create index idx_customer on customers(customer_id);










