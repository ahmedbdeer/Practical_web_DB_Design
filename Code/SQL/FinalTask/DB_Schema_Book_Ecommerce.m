CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Product Table (with optional indexes)
CREATE TABLE Product (
  ProductId CHAR(10) PRIMARY KEY,
  ProductName VARCHAR(100) NOT NULL,
  ProductDescription VARCHAR(500),
  ProductLongDescription VARCHAR(2000),
  ProductSize VARCHAR(10),
  ProductColour VARCHAR(10),
  ProductWeight SMALLINT,
  ProductPrice NUMERIC(7,2),
  ProductOnHand SMALLINT NOT NULL,
  ProductComments VARCHAR(1000),
  ProductImage VARCHAR(100),
  ProductDiscount NUMERIC(7,2) NOT NULL,
  ProductShipCost NUMERIC(7,2) NOT NULL
);
-- Optional: CREATE INDEX ProductNameIndex ON Product(ProductName);

-- Category Table (fixed hierarchy)
CREATE TABLE Category (
  CategoryID INT AUTO_INCREMENT PRIMARY KEY,
  CategoryName VARCHAR(100) NOT NULL,
  CategoryDescription VARCHAR(1000),
  CategoryParentId INT NULL, -- Now NULLable
  FOREIGN KEY (CategoryParentId) REFERENCES Category(CategoryID)
);
CREATE INDEX CategoryParentIdIndex ON Category(CategoryParentId);

-- ProductCategory Table
CREATE TABLE ProductCategory(
  ProductId CHAR(10),
  CategoryID INT NOT NULL,
  ProductCategoryDefault CHAR(1) NOT NULL,
  PRIMARY KEY (ProductId, CategoryID),
  FOREIGN KEY(ProductId) REFERENCES Product(ProductId),
  FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);
CREATE INDEX ProductCategoryCategoryIndex ON ProductCategory(CategoryID);

-- Customer Table (with uniqueness)
CREATE TABLE Customer (
  CustomerId INT AUTO_INCREMENT PRIMARY KEY,
  CustomerUserName VARCHAR(20) NOT NULL,
  CustomerPassword VARCHAR(20) NOT NULL, -- Consider increasing length
  CustomerEmail VARCHAR(100) NOT NULL,
  CustomerFirstName VARCHAR(50),
  CustomerLastName VARCHAR(50),
  CustomerAddresse1 VARCHAR(100), -- Fix typo to CustomerAddress1
  CustomerAddresse2 VARCHAR(100),
  CustomerCity VARCHAR(100),
  CustomerProvience VARCHAR(100),
  CustomerCountry VARCHAR(50),
  CustomerPostal VARCHAR(10)
);
CREATE UNIQUE INDEX CustomerUserNameUnique ON Customer(CustomerUserName);
CREATE UNIQUE INDEX CustomerEmailUnique ON Customer(CustomerEmail);

-- Orders Table
CREATE TABLE Orders (
  OrderId INT AUTO_INCREMENT PRIMARY KEY,
  OrderTotal NUMERIC(7,2) NOT NULL,
  OrderDiscount NUMERIC(7,2) NOT NULL,
  OrderTax NUMERIC(7,2) NOT NULL,
  OrderShipping NUMERIC(7,2) NOT NULL,
  OrderDate DATE NOT NULL,
  OrderShipDate DATE,
  OrderCustomerId INT NOT NULL,
  FOREIGN KEY (OrderCustomerId) REFERENCES Customer(CustomerId)
);
CREATE INDEX OrderCustomerIdIndex ON Orders(OrderCustomerId);
CREATE INDEX OrderDateIndex ON Orders(OrderDate);

-- OrderItem Table
CREATE TABLE OrderItem (
  OrderId INT NOT NULL,
  ProductId CHAR(10) NOT NULL,
  OrderItemQuantity SMALLINT NOT NULL,
  OrderItemPrice NUMERIC(7,2) NOT NULL,
  OrderItemDiscount NUMERIC(7,2) NOT NULL,
  OrderItemTax NUMERIC(7,2) NOT NULL,
  OrderItemShipping NUMERIC(7,2) NOT NULL,
  PRIMARY KEY (OrderId, ProductId),
  FOREIGN KEY (OrderId) REFERENCES Orders (OrderId),
  FOREIGN KEY (ProductId) REFERENCES Product (ProductId)
);
CREATE INDEX OrderItemProductIndex ON OrderItem(ProductId);
