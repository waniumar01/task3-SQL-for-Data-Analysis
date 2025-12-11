# 📊 E-commerce SQL Data Analysis Project

This repository contains an SQL script (`Customer data.sql`) used to set up a simple E-commerce database, populate it with sample data, and perform various data analysis queries. This project demonstrates fundamental SQL concepts, including schema design, data insertion, joins, aggregation, subqueries, view creation, and query optimization.

## 🚀 Project Objective

The primary goal was to practice and demonstrate proficiency in using standard SQL (MySQL/PostgreSQL/SQLite syntax) for data extraction and analysis from a structured dataset.

## 📁 Files in This Repository

* `Customer data.sql`: The primary SQL script containing all schema definitions, data inserts, and analysis queries.
* `README.md` (this file): Project overview and presentation of the query outputs.

## ⚙️ Database Schema

The database consists of four interconnected tables:

| Table | Column | Description | Key |
| :--- | :--- | :--- | :--- |
| **customers** | `customer_id` | Unique ID for each customer | Primary |
| | `name` | Customer's name | |
| | `city` | Customer's city | |
| **products** | `product_id` | Unique ID for each product | Primary |
| | `product_name` | Name of the product | |
| | `category` | Product category (e.g., Electronics, Fashion) | |
| | `price` | Price per unit | |
| **orders** | `order_id` | Unique ID for each order | Primary |
| | `customer_id` | ID of the customer who placed the order | Foreign (-> customers) |
| | `order_date` | Date the order was placed | |
| **order_items** | `item_id` | Unique ID for each line item | Primary |
| | `order_id` | ID of the order the item belongs to | Foreign (-> orders) |
| | `product_id` | ID of the product ordered | Foreign (-> products) |
| | `quantity` | Quantity of the product ordered | |

