create database online_sales;
use online_sales;

create table orders (
    order_id INT,
    order_date DATE,
    amount DECIMAL,
    product_id INT
);

-- load CSV 
COPY orders FROM 'C:\Users\Lenovo\Desktop\data analyst internship\TASK 6\orders_DataSet.csv' DELIMITER ',' CSV HEADER;

-- all queries

SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM
    orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    order_year,
    order_month;

WHERE EXTRACT(YEAR FROM order_date) = 2024
