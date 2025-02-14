database function to insert data in categories table around 100 row
-- Generate categories with parent-child relationships
DELIMITER $$
CREATE PROCEDURE InsertCategories()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 100000 DO -- Adjust to your desired category count
    INSERT INTO Category (CategoryName, CategoryDescription, CategoryParentId)
    VALUES (
      CONCAT('Category ', i),
      CONCAT('Description for category ', i),
      CASE WHEN i % 10 = 0 THEN FLOOR(RAND() * i) ELSE NULL END -- 10% have parents
    );
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;
CALL InsertCategories();
