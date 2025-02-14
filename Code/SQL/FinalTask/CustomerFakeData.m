database functions to insert data in customer tables around 1million rows
-- Generate fake customer data
DELIMITER $$
CREATE PROCEDURE InsertCustomers()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 1000000 DO -- Adjust to your target
    INSERT INTO Customer (
      CustomerUserName, CustomerPassword, CustomerEmail, CustomerFirstName, CustomerLastName
    ) VALUES (
      CONCAT('user', i),
      'fakePassword123', -- Use hashing in real systems
      CONCAT('user', i, '@example.com'),
      ELT(FLOOR(1 + RAND() * 10), 'John', 'Emma', 'Liam', 'Olivia', 'Noah', 'Ava', 'James', 'Isabella', 'William', 'Sophia'),
      ELT(FLOOR(1 + RAND() * 10), 'Smith', 'Johnson', 'Brown', 'Davis', 'Wilson', 'Moore', 'Taylor', 'Anderson', 'Thomas', 'Jackson')
    );
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL InsertCustomers();
