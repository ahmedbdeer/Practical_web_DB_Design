** Retrieve the total number of products in each category
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

 


