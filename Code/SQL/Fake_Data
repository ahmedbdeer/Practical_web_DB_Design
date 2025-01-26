'''
-- Insert fake data for Category Table (10 categories)
INSERT INTO category (category_id, category_name)
VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home Appliances'),
(5, 'Toys'),
(6, 'Furniture'),
(7, 'Sports'),
(8, 'Beauty'),
(9, 'Groceries'),
(10, 'Automotive');

-- Insert fake data for Product Table (100,000 products)
DELIMITER $$
CREATE PROCEDURE InsertProducts()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100000 DO
        INSERT INTO product (product_id, category_id, name, description, price, stock_quantity)
        VALUES (
            i,
            FLOOR(RAND() * 10 + 1), -- Random category_id between 1 and 10
            CONCAT('Product ', i),
            CONCAT('Description for product ', i),
            ROUND(RAND() * 100 + 1, 2), -- Random price between 1.00 and 100.00
            FLOOR(RAND() * 500 + 1) -- Random stock between 1 and 500
        );
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;
CALL InsertProducts();

-- Insert fake data for Customer Table (10,000 customers)
DELIMITER $$
CREATE PROCEDURE InsertCustomers()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 10000 DO
        INSERT INTO customer (customer_id, first_name, last_name, email, hashed_password)
        VALUES (
            i,
            CONCAT('FirstName', i),
            CONCAT('LastName', i),
            CONCAT('customer', i, '@example.com'),
            MD5(CONCAT('password', i)) -- Simple hashed password for testing
        );
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;
CALL InsertCustomers();

-- Insert fake data for Orders Table (200,000 orders)
DELIMITER $$
CREATE PROCEDURE InsertOrders()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 200000 DO
        INSERT INTO orders (order_id, customer_id, order_date, total_amount)
        VALUES (
            i,
            FLOOR(RAND() * 10000 + 1), -- Random customer_id between 1 and 10,000
            DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 1825) DAY), -- Random date in the past 5 years
            ROUND(RAND() * 500 + 20, 2) -- Random total amount between 20.00 and 500.00
        );
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;
CALL InsertOrders();

-- Insert fake data for Order Details Table (500,000 order details)
DELIMITER $$
CREATE PROCEDURE InsertOrderDetails()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 500000 DO
        INSERT INTO order_details (order_details_id, order_id, product_id, quantity, unit_price)
        VALUES (
            i,
            FLOOR(RAND() * 200000 + 1), -- Random order_id between 1 and 200,000
            FLOOR(RAND() * 100000 + 1), -- Random product_id between 1 and 100,000
            FLOOR(RAND() * 10 + 1), -- Random quantity between 1 and 10
            ROUND(RAND() * 100 + 1, 2) -- Random unit price between 1.00 and 100.00
        );
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;
CALL InsertOrderDetails();
'''
