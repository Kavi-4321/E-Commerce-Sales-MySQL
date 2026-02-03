-- ============================================
-- E-Commerce Sales & Customer Insights Project
-- ============================================

-- 1. Database Creation
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- ============================================
-- 2. Table Creation
-- ============================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================
-- 3. Data Insertion
-- ============================================

-- Customers
INSERT INTO customers VALUES
(1,'Arun','Chennai','TN','2023-01-10'),
(2,'Priya','Bangalore','KA','2023-02-15'),
(3,'Rahul','Hyderabad','TS','2023-03-20'),
(4,'Sneha','Mumbai','MH','2023-04-05'),
(5,'Karthik','Coimbatore','TN','2023-05-12'),
(6,'Divya','Madurai','TN','2023-06-18'),
(7,'Suresh','Trichy','TN','2023-07-01'),
(8,'Anitha','Salem','TN','2023-07-20'),
(9,'Vikram','Delhi','DL','2023-08-10'),
(10,'Neha','Pune','MH','2023-09-05'),
(11,'Ravi','Chennai','TN','2023-10-11'),
(12,'Pooja','Bangalore','KA','2023-11-02'),
(13,'Manoj','Hyderabad','TS','2023-12-15'),
(14,'Kavya','Mumbai','MH','2024-01-08'),
(15,'Ajay','Noida','UP','2024-02-14');

-- Products
INSERT INTO products VALUES
(101,'Laptop','Electronics'),
(102,'Mobile','Electronics'),
(103,'Office Chair','Furniture'),
(104,'Desk','Furniture'),
(105,'Headphones','Electronics'),
(106,'Keyboard','Electronics'),
(107,'Mouse','Electronics'),
(108,'Bookshelf','Furniture'),
(109,'Table Lamp','Furniture'),
(110,'Backpack','Accessories'),
(111,'Water Bottle','Accessories'),
(112,'Smart Watch','Electronics'),
(113,'Monitor','Electronics'),
(114,'Office Table','Furniture'),
(115,'Pen Drive','Electronics');

-- Orders
INSERT INTO orders VALUES
(1001,1,'2024-01-10','Delivered'),
(1002,2,'2024-01-15','Delivered'),
(1003,1,'2024-02-05','Delivered'),
(1004,3,'2024-02-20','Cancelled'),
(1005,4,'2024-03-01','Delivered'),
(1006,1,'2024-03-05','Delivered'),
(1007,2,'2024-03-10','Delivered'),
(1008,5,'2024-03-15','Delivered'),
(1009,6,'2024-03-20','Delivered'),
(1010,7,'2024-03-25','Cancelled'),
(1011,1,'2024-04-02','Delivered'),
(1012,3,'2024-04-06','Delivered'),
(1013,4,'2024-04-10','Delivered'),
(1014,8,'2024-04-15','Delivered'),
(1015,9,'2024-04-20','Delivered'),
(1016,10,'2024-05-01','Delivered'),
(1017,11,'2024-05-05','Delivered'),
(1018,12,'2024-05-10','Delivered'),
(1019,13,'2024-05-15','Delivered'),
(1020,1,'2024-05-20','Delivered'),
(1021,14,'2024-06-01','Delivered'),
(1022,15,'2024-06-05','Delivered'),
(1023,2,'2024-06-10','Delivered'),
(1024,5,'2024-06-15','Delivered'),
(1025,6,'2024-06-20','Delivered');

-- Order Items
INSERT INTO order_items VALUES
(1,1001,101,1,55000),
(2,1001,103,2,8000),
(3,1002,102,1,30000),
(4,1003,104,1,12000),
(5,1005,101,1,56000),
(6,1006,102,1,32000),
(7,1006,105,1,2500),
(8,1007,101,1,56000),
(9,1007,107,2,1200),
(10,1008,110,1,1800),
(11,1009,103,1,9000),
(12,1011,112,1,15000),
(13,1012,113,1,22000),
(14,1013,108,1,14000),
(15,1014,109,2,3000),
(16,1015,101,1,57000),
(17,1016,106,1,3500),
(18,1017,104,1,13000),
(19,1018,115,2,800),
(20,1019,102,1,31000),
(21,1020,112,1,15500),
(22,1021,114,1,25000),
(23,1022,105,1,2600),
(24,1023,107,1,600),
(25,1024,110,2,1700),
(26,1025,111,1,900);

-- ============================================
-- 4. Analysis Queries
-- ============================================

--1). CUSTOMER ANALYSIS

--I). Total customers
select count(*) as total_customers from customers;

--II). Customers by state
select state,count(*) as total_customers from customers group by state order by total_customers desc;

--III). Customers who placed more than 1 order (repeat customers)
select c.customer_id,c.customer_name,count(o.order_id) as total_orders from customers c join orders o on c.customer_id=o.customer_id group by c.customer_id,c.customer_name having count(o.order_id)>1;

--IV). Customers who ordered only 1 order 
select c.customer_id,c.customer_name from customers c join orders o on c.customer_id=o.customer_id group by c.customer_id,c.customer_name having count(o.order_id)=1;

--2).SALES ANALYSIS

--I).Total revenue (Delivered orders only)
select round(sum(oi.quantity* oi.price),0) as total_revenue from order_items oi join orders o on o.order_id=oi.order_id where o.order_status='Delivered';

--II). Monthly sales trend
select date_format(o.order_date,'%y-%m-%d') as month,round(sum(oi.quantity*oi.price),0) as monthly_revenue from order_items oi join orders o on o.order_id=oi.order_id  where o.order_status='Delivered' group by month order by month; 

--III). Average order value
select round(avg(order_total),0) as avg_value from(select o.order_id,sum(oi.quantity*oi.price) as order_total from orders o join order_items oi on o.order_id=oi.order_id where o.order_status='Delivered' group by o.order_id)t;

--3).PRODUCT PERFORMANCE

--I). Top 5 selling products (by revenue)
select p.product_name,round(sum(oi.quantity*oi.price),0) as total_sales from products p join order_items oi on p.product_id=oi.product_id join orders o on o.order_id=oi.order_id where o.order_status='Delivered' group by p.product_name order by total_sales desc limit 5;

--II). Sales by category
select p.category,sum(oi.quantity*oi.price) as category_sales from products p join order_items oi on p.product_id=oi.product_id join orders o on o.order_id=oi.order_id where o.order_status='Delivered' group by p.category order by category_sales desc;

--III). Products never sold
select p.product_name,p.product_id from products p left join order_items oi on p.product_id=oi.product_id where oi.order_id is null; 

--4).ORDER BEHAVIOUR

--I). Cancelled orders count
select count(*) as cancelled_orders from orders where order_status='Cancelled'; 

--II). Customers with cancelled orders
select distinct c.customer_name from customers c left join orders o on o.customer_id=c.customer_id where o.order_status='Cancelled'; 

--III). Order value classification
select o.order_id,sum(oi.quantity*oi.price) as order_value ,
case when sum(oi.quantity*oi.price) > 50000 then 'High value'
when sum(oi.quantity*oi.price) between 20000 and 50000 then 'Medium value'
else 'Low value' end as order_category from order_items oi join orders o on o.order_id=oi.order_id group by order_id; 

--5).AGGREGATE FUNCTIONS

--I). Total revenue per customer
select c.customer_id,c.customer_name,round(sum(oi.quantity*oi.price),0) as total_spent from customers c join orders o on c.customer_id=o.customer_id join order_items oi  on o.order_id=oi.order_id where o.order_status='Delivered' group by c.customer_id,c.customer_name order by total_spent desc;

--II). Total orders per customer
select c.customer_name,count(o.order_id) as total_orders from customers c join orders o on c.customer_id=o.customer_id group by c.customer_name;

--III). Min / Max order value
select round(min(order_total),0) as min_value,round(max(order_total),0) as max_value from(select o.order_id,sum(oi.quantity*oi.price) as order_total from orders o join order_items oi on o.order_id=oi.order_id where order_status ='Delivered' group by o.order_id)t;

--WINDOW FUNCTIONS

--I). Rank customers by total spending
select customer_id,customer_name,round(total_spent,0),rank()over(order by total_spent desc) as customer_rank from ( select c.customer_id,c.customer_name,sum(oi.quantity*oi.price) as total_spent from customers c join orders o on c.customer_id=o.customer_id join order_items oi on oi.order_id=o.order_id where order_status='Delivered' group by c.customer_id,c.customer_name)t;

--II). Running total of sales (time trend)
select *
from (
    select 
        c.customer_name,
        o.order_id,
        round(sum(oi.quantity * oi.price),0) as order_value,
        row_number() over (
            partition by c.customer_id 
            order by SUM(oi.quantity * oi.price) desc
        ) as rn
    from customers c
    join orders o on c.customer_id = o.customer_id
    join order_items oi on o.order_id = oi.order_id
    where o.order_status = 'Delivered'
    group by c.customer_name, c.customer_id, o.order_id
) t
where rn = 1;

