## Composite Index Best Practices

### 1. Composite Index
Test the impact of a composite index on performance by comparing a query with and without it:

```sql
-- Without composite index (Full table scan)
EXPLAIN ANALYZE 
SELECT * 
FROM orders 
WHERE customer_id = 123 AND order_date = '2023-09-09';

-- Create composite index
ALTER TABLE orders ADD INDEX idx_customer_date (customer_id, order_date);

-- With composite index
EXPLAIN ANALYZE 
SELECT * 
FROM orders 
WHERE customer_id = 123 AND order_date = '2023-09-09';
```

### 2. How to Choose Primary Key
Evaluate the performance of queries based on different primary key choices:

```sql
-- Current primary key
EXPLAIN ANALYZE 
SELECT * FROM customer WHERE customer_id = 123;

-- Changing primary key (e.g., composite key for multi-column uniqueness)
ALTER TABLE customer DROP PRIMARY KEY, ADD PRIMARY KEY (email, customer_id);

-- Re-run the query to compare performance
EXPLAIN ANALYZE 
SELECT * FROM customer WHERE email = 'test@example.com';
```

### 3. Index Performance
Test the effect of adding/removing indexes on query execution:

```sql
-- Without index
EXPLAIN ANALYZE 
SELECT * FROM product WHERE name = 'Camera';

-- Add index
ALTER TABLE product ADD INDEX idx_name (name);

-- With index
EXPLAIN ANALYZE 
SELECT * FROM product WHERE name = 'Camera';
```

### 4. Covering Index
Use a covering index to optimize performance when all queried columns are part of the index:

```sql
-- Without covering index
EXPLAIN ANALYZE 
SELECT product_id, name FROM product WHERE category_id = 2;

-- Add covering index
ALTER TABLE product ADD INDEX idx_category_name (category_id, name);

-- With covering index
EXPLAIN ANALYZE 
SELECT product_id, name FROM product WHERE category_id = 2;
```

### 5. Spotting Performance Problems
Identify slow queries and optimize:

```sql
-- Identify slow queries
SHOW PROCESSLIST;

-- Check query performance
EXPLAIN ANALYZE 
SELECT * FROM order_details WHERE quantity > 10;

-- Add index to improve performance
ALTER TABLE order_details ADD INDEX idx_quantity (quantity);

-- Re-run query
EXPLAIN ANALYZE 
SELECT * FROM order_details WHERE quantity > 10;
```
