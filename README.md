# Practical Web DataBase Design Link:https://link.springer.com/book/10.1007/978-1-4302-5377-8
# Mentorship Project

## Index:
- An Introduction to the Content of the Book
- Book Example Design and Implementation in MySQL & PostgreSQL
- E-commerce Application Design
- De-normalized ERD Design
- Common Queries (e.g., Top-Selling Products, Daily or Monthly Reports)
- MySQL Database Performance Tuning
- Using `EXPLAIN` for Query Optimization
- Indexes: Performance and Best Practices
- Query Comparisons Before and After Optimization
- MySQL Architecture
- Tools Used in the Project

## Book Content
**Practical Web Database Design** is an excellent textbook authored by experienced professional engineers. It provides insightful coverage of database design and implementation, consisting of nine chapters and an appendix. 

### Key Topics Covered:
1. **Introduction:**
   - Definition of databases.
   - A brief history of the evolution from file systems to databases.
   - Introduction to DBMS models and their applications in web systems.

2. **Core Database Concepts:**
   - Data models and relational models (Tables, Rows, Columns, Domains, and Data Types).
   - Constraints for effective database design (Primary Keys, Foreign Keys).
   - Normalization (1NF to 5NF) with practical examples.
   - Data integrity and physical data access methods (Sequential, Direct, and Indexed Access).

3. **SQL Basics:**
   - History and categories of SQL.
   - Understanding DDL, DML, and querying using `SELECT`, `WHERE`, `HAVING`, and `JOIN` clauses.
   - Hands-on examples through an e-commerce project (covered in Chapters 3–7).

4. **Database Design Fundamentals:**
   - Data modeling with solid academic definitions.
   - Entity relationships: One-to-Many, Many-to-Many, Recursive, and One-to-One.
   - De-normalization techniques for performance improvement.

5. **System Design Process:**
   - A complete guide from A to Z on system design.
   - Steps to gather requirements, identify entities, attributes, and relationships.
   - Conceptual data model preparation.

6. **Advanced Database Features:**
   - Sub-queries, stored procedures, and triggers.
   - Database performance tuning.
   - Types of indexes and best practices for their implementation.
   - Managing concurrency: Locking and transactions.

7. **Database Security and Maintenance:**
   - Security rules for effective database management.
   - Tips on maintenance, focusing on both developers and system administrators.

### E-commerce Example:
The book features a comprehensive e-commerce application example, particularly in Chapter 5. It outlines the SOLID steps to follow for designing a well-structured system:
- **Requirement Gathering:**
   - Interact with the business owner and potential customers to understand needs.
   - Example questions include:
     - What types of products will be sold?
     - What information about the products must be maintained?
     - How will the database store customer orders?

- **Entity Design:**
   - The `Product` entity captures all product details. As products may vary significantly, the author emphasizes designing with flexibility to handle potential null values.
### E-Commerce ERD Diagram 
https://github.com/ahmedbdeer/Practical_web_DB_Design/blob/main/DB_SHEMA_ECOMMERCE.png

8. ** Session Search Summary:
# Core Database Models - Differences Table

| Model                | Structure             | Relationships          | Use Case                        | Limitations                            |
|----------------------|-----------------------|------------------------|---------------------------------|----------------------------------------|
| Hierarchical         | Tree-like            | Parent-child           | File systems                    | Rigid structure                         |
| Network              | Graph-based          | Many-to-many           | Complex relationships           | Complexity                              |
| Relational           | Tables               | Keys (primary/foreign) | General-purpose databases       | Limited for unstructured data           |
| Object               | Objects              | Inheritance & methods  | Complex applications            | Learning curve                          |
| Object-Relational    | Hybrid               | Keys & objects         | Advanced relational use cases   | Complexity                              |
| Multimedia Database  | Optimized files      | Indexed multimedia     | Media-heavy applications        | Storage & indexing complexity           |
| Distributed          | Multi-location       | Partitioned/replicated | Scalability & fault tolerance   | Synchronization issues                  |
| File Storage         | Files                | None                   | Unstructured data               | Limited queries                         |
| XML Database         | XML documents        | Nested, hierarchical   | Data exchange formats           | Performance on large datasets           |
| DBMS                 | Depends on model     | Varies                 | Data management for applications | High resource requirements              |

## Example: Adding Shortened Descriptions
| Model         | Structure  | Relationships | Use Case            | Limitations         |
|---------------|------------|---------------|---------------------|---------------------|
| Hierarchical  | Tree-like  | Parent-child  | File systems        | Rigid structure     |
| Relational    | Tables     | Keys          | General databases   | Unstructured data   |

## Understanding DBMS (Database Management System)
A Database Management System (DBMS) is specialized software that acts as a central interface between users and the database. It ensures efficient management, access, and organization of data in a structured manner
an e-commerce platform:
•	All product details, user accounts, orders, and payments are stored in a database.
•	The DBMS acts as the system managing this data:
o	For users: Provides tools to search for products (queries).
o	For administrators: Offers tools to monitor database performance, structure product categories, and ensure no duplicate or incorrect data exists.

## ENUM and LOOKUP in Database Tables
Both ENUM and LOOKUP are used to manage predefined sets of values in a database, but they work in different ways and serve slightly different purposes
- ** •	ENUM is a data type in databases (like MySQL) that allows you to define a column with a predefined set of possible values
- ** Use Cases
•	To store static or limited choices like statuses, sizes, or categories.
How It Works
When creating a table, you define the possible values for the column:

```
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    size ENUM('Small', 'Medium', 'Large')
);
```
- ** •	A LOOKUP table is a separate table in the database used to store possible values for a column. Instead of hardcoding the values, the main table references the LOOKUP table through a foreign key
- ** Use Cases
•	Ideal for scenarios where the predefined values may grow, change, or need additional details (e.g., country codes, product categories, etc.).
'''
-- Create the lookup table
CREATE TABLE size_lookup (
    id INT AUTO_INCREMENT PRIMARY KEY,
    size_name VARCHAR(50) NOT NULL
);
'''
# Real-Life E-commerce SQL Examples

This section focuses on practical SQL examples for real-world e-commerce applications. Below are additional queries and optimizations to complement the repository.

## Important Queries

### 1. Retrieve Products Purchased by a Specific Customer
A common use case in e-commerce is retrieving products related to an order made by a specific customer. This query optimizes performance and readability:

```
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

```
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

```
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

```
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
```
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
```
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

This optimized query reduces nested joins, improving readability and execution time.

---
