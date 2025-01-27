# Real-Life E-commerce SQL Examples

This section focuses on practical SQL examples for real-world e-commerce applications. Below are additional queries and optimizations to complement the repository.

## Important Queries

### 1. Retrieve Products Purchased by a Specific Customer
A common use case in e-commerce is retrieving products related to an order made by a specific customer. This query optimizes performance and readability:

```sql
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       o.order_id,
       o.total_amount,
       p.product_id,
       p.name
FROM customer c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN product p ON od.product_id = p.product_id
WHERE c.customer_id = 123;  -- Replace with the specific customer ID
```

### 2. Top-Selling Products in a Category for the Current Month
This query lists the top-selling products within a category for the current month:

```sql
SELECT p.product_id,
       p.name,
       c.category_name,
       SUM(od.quantity) AS total_quantity
FROM product p
    JOIN category c ON p.category_id = c.category_id
    JOIN order_details od ON p.product_id = od.product_id
    JOIN orders o ON od.order_id = o.order_id
WHERE c.category_name = 'Electronics'  -- Replace with the desired category
  AND MONTH(o.order_date) = MONTH(CURRENT_DATE)
  AND YEAR(o.order_date) = YEAR(CURRENT_DATE)
GROUP BY p.product_id, p.name, c.category_name
ORDER BY total_quantity DESC
LIMIT 5;
```

### 3. Customer Order Summary
Generate a report summarizing total orders and amounts for each customer:

```sql
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.total_amount) AS total_spent
FROM customer c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10; -- Top 10 customers by spending
```

### 4. Recently Purchased Products
Suggest recently purchased products to customers based on category:

```sql
SELECT p.product_id, 
       p.name,
       c.category_name,
       COUNT(od.order_details_id) AS purchase_count
FROM product p
    JOIN category c ON p.category_id = c.category_id
    JOIN order_details od ON p.product_id = od.product_id
    JOIN orders o ON od.order_id = o.order_id
WHERE c.category_id = (SELECT category_id FROM product WHERE product_id = 101)  -- Viewed product ID
  AND p.product_id != 101  -- Exclude the viewed product
GROUP BY p.product_id, p.name, c.category_name
ORDER BY purchase_count DESC
LIMIT 5;
```

### 5. Performance Optimization Example
Optimize nested joins to improve query performance:

**Original Query:**
```sql
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       o.order_id,
       o.total_amount,
       p.product_id,
       p.name
FROM customer c 
    JOIN (orders o 
        JOIN (order_details od 
            JOIN product p ON od.product_id = p.product_id)
        ON o.order_id = od.order_id)
    ON c.customer_id = o.customer_id
WHERE c.customer_id = 500;
```

**Optimized Query:**
```sql
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       o.order_id,
       o.total_amount,
       p.product_id,
       p.name
FROM customer c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN product p ON od.product_id = p.product_id
WHERE c.customer_id = 500;
```
