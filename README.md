# 🛒 E-Commerce Sales & Customer Insights (MySQL)

## 📌 Project Overview
This project focuses on analyzing **customer behavior, sales trends, and product performance**
using **MySQL** on an e-commerce dataset.

The project is designed to demonstrate practical SQL skills used in real-world
data analysis scenarios.

---

## 🎯 Project Objective
- Analyze customer purchasing patterns
- Measure sales and revenue performance
- Identify top-performing products and categories
- Understand order behaviour and customer value
- Apply aggregate and window functions for insights

---

## 🗂 Database Schema

### Customers
- customer_id (Primary Key)
- customer_name
- city
- state
- signup_date

### Orders
- order_id (Primary Key)
- customer_id (Foreign Key)
- order_date
- order_status

### Order_Items
- order_item_id (Primary Key)
- order_id (Foreign Key)
- product_id (Foreign Key)
- quantity
- price

### Products
- product_id (Primary Key)
- product_name
- category

---

## 🛠 SQL Concepts Used
- INNER JOIN, LEFT JOIN
- GROUP BY, HAVING
- Aggregate Functions (SUM, COUNT, AVG, MIN, MAX)
- CASE statements
- Window Functions (RANK, ROW_NUMBER)

---

## 📊 Analysis Covered

### Customer Analysis
- Total number of customers
- Customers grouped by state
- Repeat customers vs one-time customers

### Sales Analysis
- Total revenue from delivered orders
- Monthly revenue trends
- Average order value

### Product Performance
- Top 5 products by revenue
- Revenue contribution by category
- Products that were never sold

### Order Behaviour
- Cancelled order analysis
- Customers with cancelled orders
- Order value classification (High / Medium / Low)

### Advanced SQL & Window Functions
- Total spending per customer
- Ranking customers by revenue
- Highest value order per customer

---

## 🔍 Key Insights
- Electronics category generates the highest revenue
- Repeat customers contribute significantly to total sales
- High-value orders are mostly driven by electronics products
- Certain products exist but have never been purchased

---


## 👤 Author
**Kaviyarasu T**  
SQL | MySQL | 

