USE SalesOrdersExample;

SELECT * FROM Customers;
SELECT CONCAT(CustFirstName, " ", CustLastName) AS CustomerName,
	CONCAT("+", EmpAreaCode, " ", EmpPhoneNumber) AS PhoneNumber
FROM Customers, Employees; 

SELECT * FROM Customers WHERE CustState = 'WA';
SELECT * FROM Customers WHERE CustState IN ('WA','OR'); 

SELECT COUNT(*) AS Customers, CustState
FROM Customers
GROUP BY CustState;

SELECT CustFirstName, CustLastName, OrderDate
FROM Customers c JOIN Orders o
ON o.CustomerID = c.CustomerID
ORDER BY CustLastName, CustFirstName, OrderDate DESC;

SELECT CustFirstName, CustLastName, OrderDate
FROM Customers c LEFT OUTER JOIN Orders o 
ON o.CustomerID=c.CustomerID
ORDER BY CustLastName, CustFirstName, OrderDate DESC;

SELECT CustFirstName, CustLastName, OrderDate
FROM Customers c LEFT OUTER JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE o.OrderDate = ( SELECT MAX(o.OrderDate) FROM orders o)
ORDER BY CustLastName, CustFirstName, OrderDate DESC;

DROP VIEW CustOrderItems;

CREATE VIEW CustOrderItems AS 
SELECT CustFirstName, CustLastName, OrderNumber, OrderDate, ShipDate,
	(QuantityOrdered*QuotedPrice) AS ItemTotal
FROM Customers 
NATURAL JOIN Orders
NATURAL JOIN Order_Details;

SELECT CustFirstName, CustLastName, OrderNumber, OrderDate, ShipDate,
	SUM(ItemTotal) AS OrderTotal 
FROM CustOrderItems 
GROUP BY OrderNumber;

SELECT * FROM CustOrderItems;

SELECT EmpFirstName, EmpLastName, ProductName, 
	SUM(QuantityOrdered*QuotedPrice) AS TotalSold
FROM Employees 
NATURAL JOIN Orders
NATURAL JOIN Order_Details
NATURAL JOIN Products 
GROUP BY EmpLastName, ProductName;

SELECT EmpFirstName, EmpLastName, ProductName, YEAR(OrderDate) as Year,
	SUM(QuantityOrdered*QuotedPrice) AS TotalValue
FROM Employees 
NATURAL JOIN Orders
NATURAL JOIN Order_Details
NATURAL JOIN Products
GROUP BY EmpFirstName, ProductName, Year
ORDER BY Year, TotalValue DESC;

SELECT CustFirstName, CustLastName FROM Customers c
WHERE NOT EXISTS(
			SELECT * FROM Orders d
			WHERE d.CustomerID = c.CustomerID
);
