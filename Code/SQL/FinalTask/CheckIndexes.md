# Check Indexes

## Verify Indexes in the Database
Ensure that the indexes listed in your file exist in the database. You can check the indexes for each table using the following SQL queries:

```sql
SHOW INDEX FROM category;
SHOW INDEX FROM customer;
SHOW INDEX FROM order_details;
SHOW INDEX FROM orders;
SHOW INDEX FROM product;
```

---

## **Indexes for Each Table**

### **Product Table**
```sql
SHOW INDEX FROM product;
```
| Table   | Non_unique | Key_name                 | Seq_in_index | Column_name  | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
|---------|-----------|--------------------------|--------------|--------------|-----------|-------------|----------|--------|------|------------|---------|---------------|---------|------------|
| product | 0         | PRIMARY                  | 1            | product_id   | A         | 97402       |          |        |      | BTREE      |         |               | YES     |            |
| product | 1         | idx_product_category_id  | 1            | category_id  | A         | 9           |          |        |      | BTREE      |         |               | YES     |            |

---

### **Customer Table**
```sql
SHOW INDEX FROM customer;
```
| Table    | Non_unique | Key_name              | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
|----------|-----------|-----------------------|--------------|-------------|-----------|-------------|----------|--------|------|------------|---------|---------------|---------|------------|
| customer | 0         | PRIMARY               | 1            | customer_id | A         | 10108       |          |        |      | BTREE      |         |               | YES     |            |
| customer | 1         | idx_customer_email    | 1            | email       | A         | 10000       |          |        |      | BTREE      |         |               | YES     |            |

---

### **Order Details Table**
```sql
SHOW INDEX FROM order_details;
```
| Table          | Non_unique | Key_name                     | Seq_in_index | Column_name      | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
|---------------|-----------|-----------------------------|--------------|------------------|-----------|-------------|----------|--------|------|------------|---------|---------------|---------|------------|
| order_details | 0         | PRIMARY                     | 1            | order_details_id | A         | 468096       |          |        |      | BTREE      |         |               | YES     |            |
| order_details | 1         | idx_order_details_order_id  | 1            | order_id         | A         | 180633       |          |        |      | BTREE      |         |               | YES     |            |
| order_details | 1         | idx_order_details_product_id | 1            | product_id       | A         | 98855        |          |        |      | BTREE      |         |               | YES     |            |

---

### **Orders Table**
```sql
SHOW INDEX FROM orders;
```
| Table  | Non_unique | Key_name               | Seq_in_index | Column_name  | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
|--------|-----------|------------------------|--------------|--------------|-----------|-------------|----------|--------|------|------------|---------|---------------|---------|------------|
| orders | 0         | PRIMARY                | 1            | order_id     | A         | 187880       |          |        |      | BTREE      |         |               | YES     |            |
| orders | 1         | idx_order_customer_id  | 1            | customer_id  | A         | 10047        |          |        |      | BTREE      |         |               | YES     |            |
| orders | 1         | idx_customer_date      | 1            | customer_id  | A         | 9945         |          |        |      | BTREE      |         |               | YES     |            |
| orders | 1         | idx_customer_date      | 2            | order_date   | A         | 199512       |          |        |      | BTREE      |         |               | YES     |            |

---

### **Summary**
This document provides an overview of the database indexes used in different tables. Proper indexing ensures better query performance and efficient data retrieval. If you notice any missing indexes or performance issues, consider optimizing queries and adding necessary indexes.
