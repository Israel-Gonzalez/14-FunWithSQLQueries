-- 1. Return all categories 
SELECT * FROM Categories;

--2. Return the contact name, customer id, and company name of all Customers in London 
SELECT ContactName, CustomerID, CompanyName 
FROM Customers WHERE City = 'London'; 

--3 Return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number
SELECT * FROM Suppliers 
WHERE Fax is not NULL AND (ContactTitle='Marketing Manager' OR ContactTitle='Sales Representative');

--4 Return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Jan 1, 1998 and with freight under 100 units.
SELECT CustomerID 
FROM Orders 
WHERE RequiredDate BETWEEN '01/01/1997' AND '01/01/1998' AND Freight < 100;

--5 Return a list of company names and contact names of all the Owners from the Customer table from Mexico, Sweden and Germany.
SELECT CompanyName, ContactName 
FROM Customers 
WHERE Country IN ('Mexico','Sweden','Germany');

--6 Return a count of the number of discontinued products in the Products table.
SELECT COUNT(Discontinued) 
FROM Products; 

--7 Return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.
SELECT CategoryName,Description 
FROM Categories 
WHERE CategoryName LIKE 'Co%';

--8 Return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.
SELECT CompanyName,City,Country,PostalCode 
FROM Suppliers WHERE Address LIKE '%rue%' 
ORDER BY CompanyName ASC;

--9 Return the product id and the total quantities ordered for each product id in the Order Details table.
SELECT SUM(Quantity) FROM [Order Details] GROUP BY ProductID;

--10 Return the customer name and customer address of all customers with orders that shipped using Speedy Express.
SELECT ContactName, Address
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID  
WHERE Shippers.CompanyName = 'Speedy Express';

--11 Return a list of Suppliers containing company name, contact name, contact title and region description
SELECT CompanyName, ContactName, ContactTitle, Region
FROM Suppliers 
WHERE Region IS NOT NULL;

--12 Return all product names from the Products table that are condiments.
SELECT ProductName 
FROM Products INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID 
WHERE CategoryName = 'Condiments';

--13 Return a list of customer names who have no orders in the Orders table.
SELECT ContactName 
FROM Customers FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
WHERE OrderDate is NULL;

--14 Add a shipper named 'Amazon' to the Shippers table using SQL.
INSERT INTO Shippers (CompanyName) VALUES ('Amazon');

--15 Change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.
UPDATE Shippers SET CompanyName = 'Amazon Prime Shipping' WHERE CompanyName = 'Amazon';

--16 Return a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
SELECT Shippers.CompanyName, SUM(ROUND(Orders.Freight,0)) AS TotalFreight
FROM Shippers 
INNER JOIN Orders 
ON Shippers.ShipperID = Orders.ShipVia 
WHERE OrderDate IS NOT NULL
GROUP BY CompanyName;

--17 Return all employee first and last names from the Employees table by combining the 2 columns aliased as 'DisplayName'. The combined format should be 'LastName, FirstName'.
SELECT LastName + ', ' + FirstName AS DisplayName
FROM Employees;

--18 Add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.
INSERT INTO Customers (CustomerID,CompanyName,ContactName,ContactTitle,Address,City,PostalCode,Country,Phone)
VALUES ('ISGON','Woosh Company','Israel Gonzalez','Developer','1234 W Broadway','San Diego','92105','USA','619-555-1234')
INSERT INTO Orders(CustomerID)
VALUES (@@IDENTITY)
INSERT INTO [Order Details] (OrderID,ProductID,UnitPrice,Quantity,Discount)
VALUES (@@IDENTITY,(SELECT ProductID FROM Products WHERE ProductName LIKE 'Gran%'), 9.95, 12, 0);

--19 Remove yourself and your order from the database.
DELETE FROM Customers 
WHERE CustomerID='ISGON';
DELETE FROM Orders
WHERE CustomerID='ISGON';
DELETE FROM [Order Details]
WHERE OrderID=(@@IDENTITY);

--20 Return a list of products from the Products table along with the total units in stock for each product. Give the computed column a name using the alias, 'TotalUnits'. Include only products with TotalUnits greater than 100.
SELECT ProductName, SUM(UnitsInStock) AS TotalUnits
FROM Products   
WHERE UnitsInStock > 100
GROUP BY ProductName;
