------------------------------------------
-- 1. SCHEMA SETUP
------------------------------------------

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY(order_id) REFERENCES orders(order_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id)
);

------------------------------------------
-- 2. SAMPLE DATA INSERTS
------------------------------------------

INSERT INTO customers VALUES
(1, 'Amit', 'Delhi'),
(2, 'Riya', 'Mumbai'),
(3, 'John', 'Bangalore');

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 55000),
(2, 'Mouse', 'Electronics', 500),
(3, 'Shoes', 'Fashion', 2000);

INSERT INTO orders VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-01-12'),
(3, 1, '2024-01-15');

INSERT INTO order_items VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 3, 1, 1);

------------------------------------------
-- 3. BASIC SELECT + WHERE + ORDER BY
------------------------------------------

SELECT product_name, price, category
FROM products
WHERE price > 1000
ORDER BY price DESC;

------------------------------------------
-- 4. GROUP BY + AGGREGATE FUNCTIONS
------------------------------------------

SELECT category, SUM(price * quantity) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY category;

------------------------------------------
-- 5. INNER JOIN (customer + order + items)
------------------------------------------

SELECT c.name, o.order_id, SUM(p.price * oi.quantity) AS order_value
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id;

------------------------------------------
-- 6. LEFT JOIN (customers who may not have orders)
------------------------------------------

SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

------------------------------------------
-- 7. RIGHT JOIN (products whether ordered or not)
------------------------------------------

SELECT p.product_name, oi.order_id
FROM order_items oi
RIGHT JOIN products p ON oi.product_id = p.product_id;

------------------------------------------
-- 8. SUBQUERY (top spending customer)
------------------------------------------

SELECT name, city
FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY customer_id
    ORDER BY SUM(p.price * oi.quantity) DESC
    LIMIT 1
);

------------------------------------------
-- 9. VIEW CREATION (for analysis)
------------------------------------------

CREATE VIEW order_summary AS
SELECT 
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    SUM(p.price * oi.quantity) AS total_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id;

-- To use the view
SELECT * FROM order_summary;

------------------------------------------
-- 10. INDEX CREATION (Query Optimization)
------------------------------------------

-- Optimizing searches on customer_id
CREATE INDEX idx_orders_customer ON orders(customer_id);

-- Optimizing searches on product_id
CREATE INDEX idx_items_product ON order_items(product_id);

-- Optimizing category lookups
CREATE INDEX idx_products_category ON products(category);

------------------------------------------
-- END OF SCRIPT
------------------------------------------
