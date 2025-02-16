# E-Commerce Database Analysis & Optimization

A collection of SQL queries and performance analyses for an e-commerce database system. Demonstrates skills in data retrieval, query optimization, and database performance tuning.

## 📊 Key Analyses

### 1. Product Category Distribution
**Purpose:** Understand product distribution across categories  
**Business Value:** Inventory management and category performance analysis

```sql
-- Retrieve total products per category
SELECT c.CategoryID, c.CategoryName, COUNT(pc.ProductId) AS ProductCount
FROM Category c
LEFT JOIN ProductCategory pc ON c.CategoryID = pc.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

 Retrieve the total number of products in each category
SELECT c.CategoryID, c.CategoryName, COUNT(pc.ProductId) AS ProductCount
FROM Category c
LEFT JOIN ProductCategory pc ON c.CategoryID = pc.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

EXPLAIN
SELECT 
    c.CategoryName, 
    COUNT(pc.ProductId) AS TotalProducts
FROM 
    Category c
LEFT JOIN 
    ProductCategory pc ON c.CategoryID = pc.CategoryID
GROUP BY 
    c.CategoryName
ORDER BY 
    TotalProducts DESC;

    ![image](https://github.com/user-attachments/assets/0e42c4ea-6e88-4868-9700-7811b9bc1ddd)


    id|select_type|table|partitions|type|possible_keys               |key                         |key_len|ref                   |rows|filtered|Extra                          |
--+-----------+-----+----------+----+----------------------------+----------------------------+-------+----------------------+----+--------+-------------------------------+
 1|SIMPLE     |c    |          |ALL |                            |                            |       |                      |2000|   100.0|Using temporary; Using filesort|
 1|SIMPLE     |pc   |          |ref |ProductCategoryCategoryIndex|ProductCategoryCategoryIndex|4      |ecommerce.c.CategoryID|   1|   100.0|Using index                    |


** Find the top customers by total spending
SELECT o.OrderCustomerId, c.CustomerUserName, SUM(o.OrderTotal) AS TotalSpent
FROM Orders o
JOIN Customer c ON o.OrderCustomerId = c.CustomerId
GROUP BY o.OrderCustomerId, c.CustomerUserName
ORDER BY TotalSpent DESC
LIMIT 10;

OrderCustomerId|CustomerUserName|TotalSpent|
---------------+----------------+----------+
          89620|user89620       |   5596.19|
           6909|user6909        |   5272.47|
          69327|user69327       |   5136.69|
          37549|user37549       |   4933.59|
          95493|user95493       |   4808.21|
          75353|user75353       |   4710.63|
          41388|user41388       |   4695.35|
          76071|user76071       |   4634.62|
          75145|user75145       |   4632.00|
           7497|user7497        |   4586.83|


EXPLAIN
SELECT 
    c.CustomerId,
    c.CustomerFirstName,
    c.CustomerLastName,
    SUM(o.OrderTotal) AS TotalSpending
FROM 
    Customer c
JOIN 
    Orders o ON c.CustomerId = o.OrderCustomerId
GROUP BY 
    c.CustomerId
ORDER BY 
    TotalSpending DESC
LIMIT 10;

id|select_type|table|partitions|type  |possible_keys                                     |key    |key_len|ref                        |rows  |filtered|Extra                          |
--+-----------+-----+----------+------+--------------------------------------------------+-------+-------+---------------------------+------+--------+-------------------------------+
 1|SIMPLE     |o    |          |ALL   |OrderCustomerIdIndex                              |       |       |                           |134691|   100.0|Using temporary; Using filesort|
 1|SIMPLE     |c    |          |eq_ref|PRIMARY,CustomerUserNameUnique,CustomerEmailUnique|PRIMARY|4      |ecommerce.o.OrderCustomerId|     1|   100.0|                               |

 
--  Retrieve the most recent orders with customer information (latest 1000 orders)
SELECT o.OrderId, o.OrderDate, o.OrderTotal, c.CustomerUserName, c.CustomerEmail
FROM Orders o
JOIN Customer c ON o.OrderCustomerId = c.CustomerId
ORDER BY o.OrderDate DESC
LIMIT 1000;

EXPLAIN
SELECT o.OrderId, o.OrderDate, o.OrderTotal, c.CustomerUserName, c.CustomerEmail
FROM Orders o
JOIN Customer c ON o.OrderCustomerId = c.CustomerId
ORDER BY o.OrderDate DESC
LIMIT 1000;
id|select_type|table|partitions|type  |possible_keys       |key    |key_len|ref                        |rows  |filtered|Extra         |
--+-----------+-----+----------+------+--------------------+-------+-------+---------------------------+------+--------+--------------+
 1|SIMPLE     |o    |          |ALL   |OrderCustomerIdIndex|       |       |                           |147315|   100.0|Using filesort|
 1|SIMPLE     |c    |          |eq_ref|PRIMARY             |PRIMARY|4      |ecommerce.o.OrderCustomerId|     1|   100.0|              |

 List products that have low stock quantities (less than 10)
SELECT ProductId, ProductName, ProductOnHand
FROM Product
WHERE ProductOnHand < 10;

Name         |Value     |
-------------+----------+
ProductId    |P00000069 |
ProductName  |Product 69|
ProductOnHand|3         |

![image](https://github.com/user-attachments/assets/6fcefcb1-d8df-4f3c-b7c4-fefbb377d51d)



![WhatsApp Image 2025-02-17 at 2 06 13 AM](https://github.com/user-attachments/assets/91f6cc6d-0b0b-4559-bc42-fe49136febb8)

Calculate the revenue generated from each product category
SELECT c.CategoryID, c.CategoryName, SUM(oi.OrderItemQuantity * oi.OrderItemPrice) AS TotalRevenue
FROM Category c
JOIN ProductCategory pc ON c.CategoryID = pc.CategoryID
JOIN OrderItem oi ON pc.ProductId = oi.ProductId
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC;
![image](https://github.com/user-attachments/assets/0c5760c0-e7f1-4933-a655-fa9626af41e4)

EXPLAIN ANALYZE SELECT c.CategoryID, c.CategoryName, COUNT(pc.ProductId) AS ProductCount FROM Category c LEFT JOIN ProductCategory pc ON c.CategoryID = pc.CategoryID GROUP BY c.CategoryID, c.CategoryName;

Name   |Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
-------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
EXPLAIN|-> Table scan on <temporary>  (actual time=30.3..30.5 rows=2000 loops=1)¶    -> Aggregate using temporary table  (actual time=30.3..30.3 rows=2000 loops=1)¶        -> Nested loop left join  (cost=2410 rows=2000) (actual time=11.3..28.2 rows=2000 loops=1)¶            -> Table scan on c  (cost=210 rows=2000) (actual time=7.44..22.7 rows=2000 loops=1)¶            -> Covering index lookup on pc using ProductCategoryCategoryIndex (CategoryID=c.CategoryID)  (cost=1 rows=1) (actual time=0.00262..0.00262 rows=0 loops=2000)¶|


EXPLAIN ANALYZE SELECT o.OrderCustomerId, c.CustomerUserName, SUM(o.OrderTotal) AS TotalSpent FROM Orders o JOIN Customer c ON o.OrderCustomerId = c.CustomerId GROUP BY o.OrderCustomerId, c.CustomerUserName ORDER BY TotalSpent DESC LIMIT 10;

Name   |Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
EXPLAIN|-> Limit: 10 row(s)  (actual time=33032..33032 rows=10 loops=1)¶    -> Sort: TotalSpent DESC, limit input to 10 row(s) per chunk  (actual time=33032..33032 rows=10 loops=1)¶        -> Table scan on <temporary>  (actual time=32996..33018 rows=100000 loops=1)¶            -> Aggregate using temporary table  (actual time=32996..32996 rows=100000 loops=1)¶                -> Nested loop inner join  (cost=5.57e+6 rows=4.95e+6) (actual time=33..12164 rows=4.97e+6 loops=1)¶                    -> Table scan on o  (cost=508984 rows=4.95e+6) (actual time=32.9..2613 rows=4.97e+6 loops=1)¶                    -> Single-row index lookup on c using PRIMARY (CustomerId=o.OrderCustomerId)  (cost=0.922 rows=1) (actual time=0.00177..0.00179 rows=1 loops=4.97e+6)¶|

EXPLAIN ANALYZE SELECT o.OrderId, o.OrderDate, o.OrderTotal, c.CustomerUserName, c.CustomerEmail FROM Orders o JOIN Customer c ON o.OrderCustomerId = c.CustomerId ORDER BY o.OrderDate DESC LIMIT 1000;

Name   |Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
-------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
EXPLAIN|-> Limit: 1000 row(s)  (cost=4.58e+6 rows=1000) (actual time=55.6..832 rows=1000 loops=1)¶    -> Nested loop inner join  (cost=4.58e+6 rows=1000) (actual time=55.6..832 rows=1000 loops=1)¶        -> Index scan on o using OrderDateIndex (reverse)  (cost=2.61 rows=1000) (actual time=55.5..829 rows=1000 loops=1)¶        -> Single-row index lookup on c using PRIMARY (CustomerId=o.OrderCustomerId)  (cost=0.922 rows=1) (actual time=0.00234..0.00237 rows=1 loops=1000)¶|

EXPLAIN ANALYZE SELECT ProductId, ProductName, ProductOnHand FROM Product WHERE ProductOnHand < 10;

Name   |Value                                                                                                                                                                                                            |
-------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
EXPLAIN|-> Filter: (product.ProductOnHand < 10)  (cost=103511 rows=332077) (actual time=8.34..1144 rows=9978 loops=1)¶    -> Table scan on Product  (cost=103511 rows=996330) (actual time=8.31..1106 rows=1e+6 loops=1)¶|

EXPLAIN ANALYZE SELECT c.CategoryID, c.CategoryName, SUM(oi.OrderItemQuantity * oi.OrderItemPrice) AS TotalRevenue FROM Category c JOIN ProductCategory pc ON c.CategoryID = pc.CategoryID JOIN OrderItem oi ON pc.ProductId = oi.ProductId GROUP BY c.CategoryID, c.CategoryName ORDER BY TotalRevenue DESC;

Name   |Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
-------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
EXPLAIN|-> Sort: TotalRevenue DESC  (actual time=1.23..1.23 rows=0 loops=1)¶    -> Table scan on <temporary>  (actual time=1.22..1.22 rows=0 loops=1)¶        -> Aggregate using temporary table  (actual time=1.22..1.22 rows=0 loops=1)¶            -> Nested loop inner join  (cost=3.23 rows=1) (actual time=1.21..1.21 rows=0 loops=1)¶                -> Nested loop inner join  (cost=2.2 rows=1) (actual time=1.21..1.21 rows=0 loops=1)¶                    -> Covering index scan on pc using ProductCategoryCategoryIndex  (cost=1.1 rows=1) (actual time=1.21..1.21 rows=0 loops=1)¶                    -> Index lookup on oi using OrderItemProductIndex (ProductId=pc.ProductId)  (cost=1.1 rows=1) (never executed)¶                -> Single-row index lookup on c using PRIMARY (CategoryID=pc.CategoryID)  (cost=1.03 rows=1) (never executed)¶|
