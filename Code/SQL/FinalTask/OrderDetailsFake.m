database functions to insert data in order, order details tables
DELIMITER $$

CREATE PROCEDURE InsertOrders(IN numRows INT)
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE orderDate DATE;
  DECLARE customerId INT;

  WHILE i <= numRows DO
    -- Generate random order date within the last 5 years
    SET orderDate = DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365 * 5) DAY);

    -- Random customer ID (assuming you have 100,000 customers)
    SET customerId = FLOOR(1 + RAND() * 100000);

    -- Insert order
    INSERT INTO Orders (
      OrderTotal, OrderDiscount, OrderTax, OrderShipping,
      OrderDate, OrderCustomerId
    ) VALUES (
      ROUND(RAND() * 1000, 2), -- Total $0–1000
      ROUND(RAND() * 50, 2), -- Discount 0–50%
      ROUND(RAND() * 100, 2), -- Tax $0–100
      ROUND(RAND() * 20, 2), -- Shipping $0–20
      orderDate,
      customerId
    );

    SET i = i + 1;
  END WHILE;
END$$

DELIMITER ;

''''
insert 2 million orders
''''
CALL InsertOrders(2000000);

''''
InsertOrderItems
''''''

DELIMITER $$

CREATE PROCEDURE InsertOrderItems()
BEGIN
  DECLARE orderId INT;
  DECLARE productId CHAR(10);
  DECLARE numItems INT;
  DECLARE done INT DEFAULT FALSE;

  -- Cursor to loop through all orders
  DECLARE cur CURSOR FOR SELECT OrderId FROM Orders;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;

  read_loop: LOOP
    FETCH cur INTO orderId;
    IF done THEN LEAVE read_loop; END IF;

    -- Random number of items per order (1–5)
    SET numItems = FLOOR(1 + RAND() * 5);

    -- Insert items for the current order
    INSERT INTO OrderItem (
      OrderId, ProductId, OrderItemQuantity, OrderItemPrice,
      OrderItemDiscount, OrderItemTax, OrderItemShipping
    )
    SELECT
      orderId,
      ProductId,
      FLOOR(1 + RAND() * 4), -- Quantity 1–5
      ProductPrice,
      ProductDiscount,
      ProductPrice * 0.07, -- 7% tax
      ProductShipCost
    FROM Product
    ORDER BY RAND()
    LIMIT numItems;

  END LOOP;

  CLOSE cur;
END$$

DELIMITER ;

''''''
insert order items for all orders
''''''
CALL InsertOrderItems();

