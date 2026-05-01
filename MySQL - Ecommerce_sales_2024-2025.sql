create database ecommerce;
use ecommerce;


create table sales (
	order_id int,
    order_date date,
    customer_name varchar(50),
    region varchar(10),
    city varchar(30),
    category varchar(50),
    sub_category varchar(50),
    product_name varchar(50),
    quantity int,
    unit_price float,
    discount int,
    sales float,
    profit float,
    payment_mode varchar(25)
);

select * from sales;

-- Total Sales
select ROUND(SUM(sales)) as total_sales
from sales;

-- Sales by Category
select category, ROUND(SUM(sales)) as total_sales
from sales
group by category;

-- Top 5 Customers
select * 
from (
	select *,
      dense_rank() over(partition by customer_name order by SUM(sales) DESC) as rnk
      from sales
      group by customer_name
) t 
where rnk <= 5;


select customer_name, ROUND(SUM(sales)) as Total
from sales
group by customer_name
order by SUM(sales) DESC
limit 5;


-- Monthly Sales
select MONTH(order_date) as month, ROUND(SUM(sales)) as Total_sales
from sales
group by MONTH(order_date);


-- Orders by city
select city, COUNT(*) as Order_counts
from sales
group by city;

-- Higest Sales Product
select product_name as Product_name, ROUND(SUM(sales)) as total_sales
from sales
group by product_name
order by total_sales DESC
limit 1;

-- Payment Method Usage
select payment_mode, COUNT(*) as Total_counts
from sales
group by payment_mode;



-- Disable Safe Mode
SET SQL_SAFE_UPDATES = 0;

-- change one value was in Depit Card instend of Debit Card
update sales
set payment_mode = "Debit Card"
where LOWER(payment_mode) = "Depit Card"
AND order_id IS NOT NULL;




