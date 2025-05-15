-- Create database
-- CREATE DATABASE OrderDB;

-- USE OrderDB;

-- Create ProducctDetail table
-- CREATE TABLE ProductDetail (
--     OrderID INT,
--     CustomerName VARCHAR(100),
--     Products VARCHAR(255)  -- Contains comma-separated values (violates 1NF)
-- );

-- Create OrderDetail table
-- CREATE TABLE OrderDetails (
--     OrderID INT,
--     CustomerName VARCHAR(100),
--     Product VARCHAR(50),
--     Quantity INT
-- );

-- INSERT INTO ProductDetail (OrderID, CustomerName, Products)
-- VALUES 
--     (101, 'John Doe', 'Laptop, Mouse'),
--     (102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
--     (103, 'Emily Clark', 'Phone');

-- INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
-- VALUES 
--     (101, 'John Doe', 'Laptop', 2),
--     (101, 'John Doe', 'Mouse', 1),
--     (102, 'Jane Smith', 'Tablet', 3),
--     (102, 'Jane Smith', 'Keyboard', 1),
--     (102, 'Jane Smith', 'Mouse', 2),
--     (103, 'Emily Clark', 'Phone', 1);

-- First create a numbers/tally table (or use an existing one)
-- CREATE TEMPORARY TABLE numbers (n INT);
-- INSERT INTO numbers VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

-- Then use SUBSTRING_INDEX to split the products
-- INSERT INTO OrderDetails_1NF (OrderID, CustomerName, Product)
-- SELECT 
--     p.OrderID,
--     p.CustomerName,
--     TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(p.Products, ',', n.n), ',', -1)) AS Product
-- FROM 
--     ProductDetail p
-- JOIN 
--     numbers n
-- ON 
--     n.n <= LENGTH(p.Products) - LENGTH(REPLACE(p.Products, ',', '')) + 1
-- WHERE 
--     SUBSTRING_INDEX(SUBSTRING_INDEX(p.Products, ',', n.n), ',', -1) != '';

-- SELECT * FROM OrderDetails_1NF;
 
-- Create Orderrs table 
-- CREATE TABLE Orderrs (removes partial dependency)
--     OrderID INT PRIMARY KEY,
--     CustomerName VARCHAR(100)
-- );

-- Step 2: Create OrrderItems table
-- CREATE TABLE OrrderItems (
--     OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
--     OrderID INT,
--     Product VARCHAR(50),
-- Quantity INT,
--     FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
-- ) ENGINE=InnoDB;

-- Step 3: Populate Orderrs table from 1NF data
-- INSERT INTO Orderrs (OrderID, CustomerName)
-- SELECT DISTINCT OrderID, CustomerName
-- FROM OrderDetails_1NF;

-- Step 4: Populate OrrderItems table
-- INSERT INTO OrrderItems (OrderID, Product, Quantity)
-- SELECT OrderID, Product, Quantity
-- FROM OrderDetails_1NF;

-- Optional: Add index for better performance
-- CREATE INDEX idx_orderritems_orderid ON OrderItems(OrderID);

-- Check the structure of OrderDetails_1NF
-- DESCRIBE OrderDetails_1NF;

-- Add the Quantity column if missing
-- ALTER TABLE OrderDetails_1NF ADD COLUMN Quantity INT DEFAULT 1;

-- Then insert into OrderItems
-- INSERT INTO OrderItems (OrderID, Product, Quantity)
-- SELECT OrderID, Product, Quantity 
-- FROM OrderDetails_1NF;

-- Create Orderrs table (removes partial dependency)
-- CREATE TABLE Orderrs (
--      OrderID INT PRIMARY KEY,
--      CustomerName VARCHAR(100)
--  );

-- Step 2: Create OrrderItems table
-- CREATE TABLE OrrderItems (
--     OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
--      OrderID INT,
--      Product VARCHAR(50),
--  Quantity INT,
--      FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
--  ) ENGINE=InnoDB;

-- Step 3: Populate Orderrs table from 1NF data
--  INSERT INTO Orderrs (OrderID, CustomerName)
--  SELECT DISTINCT OrderID, CustomerName
--  FROM OrderDetails_1NF;

-- Step 4: Populate OrrderItems table
 -- INSERT INTO OrrderItems (OrderID, Product, Quantity)
--  SELECT OrderID, Product, Quantity
--  FROM OrderDetails_1NF;

-- Optional: Add index for better performance
 -- CREATE INDEX idx_orderritems_orderid ON OrderItems(OrderID);

-- Verify 1NF results
-- SELECT * FROM OrderDetails_1NF ORDER BY OrderID, Product;

-- Verify 2NF results
-- SELECT * FROM Orders;
-- SELECT * FROM OrderItems ORDER BY OrderID, Product;
