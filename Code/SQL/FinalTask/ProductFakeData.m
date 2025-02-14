-- Generate random products with realistic attributes
DELIMITER $$
CREATE PROCEDURE InsertProducts()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000000 DO -- Adjust to your target
    INSERT INTO Product (
      ProductId, ProductName, ProductPrice, ProductOnHand, ProductDiscount, ProductShipCost
    ) VALUES (
      CONCAT('P', LPAD(i, 8, '0')), -- P00000001 format
      CONCAT('Product ', i),
      ROUND(RAND() * 1000, 2), -- Random price $0–1000
      FLOOR(RAND() * 1000), -- Stock 0–1000
      ROUND(RAND() * 50, 2), -- Discount 0–50%
      ROUND(RAND() * 20, 2) -- Shipping $0–20
    );
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL InsertProducts();
