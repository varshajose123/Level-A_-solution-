/* 1. List of all customers */
SELECT * FROM sales.customer

/* 2 */
SELECT * FROM Person.Person
WHERE CompanyName LIKE '%N'

/* 3 */
SELECT * FROM Person.Person
WHERE City IN ('Berlin', 'London')

/* 4 */
SELECT * FROM Person.Person
WHERE CountryRegionCode IN ('GB', 'US')

/* 5 */
SELECT * FROM Production.Product
ORDER BY Name

/* 6 */
SELECT * FROM Production.Product
WHERE Name LIKE 'A%'

/* 7 */
SELECT DISTINCT p.*
FROM Person.Person p
JOIN Sales.SalesOrderHeader soh ON p.BusinessEntityID = soh.CustomerID

/* 8 */
SELECT DISTINCT p.*
FROM Person.Person p
JOIN Sales.SalesOrderHeader soh ON p.BusinessEntityID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product pr ON sod.ProductID = pr.ProductID
WHERE p.City = 'London' AND pr.Name = 'Chai'

/* 9 */
SELECT * FROM Person.Person p
WHERE NOT EXISTS (
    SELECT 1
    FROM Sales.SalesOrderHeader soh
    WHERE p.BusinessEntityID = soh.CustomerID
)

/* 10 */
SELECT DISTINCT p.*
FROM Person.Person p
JOIN Sales.SalesOrderHeader soh ON p.BusinessEntityID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product pr ON sod.ProductID = pr.ProductID
WHERE pr.Name = 'Tofu'

/* 11 */
SELECT TOP 1 *
FROM Sales.SalesOrderHeader
ORDER BY OrderDate

/* 12 */
SELECT TOP 1 soh.*
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
ORDER BY sod.UnitPrice DESC

/* 13 */
SELECT SalesOrderID, AVG(OrderQty) AS AvgQuantity
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
/* 14 */
SELECT SalesOrderID, MIN(OrderQty) AS MinQuantity, MAX(OrderQty) AS MaxQuantity
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID

/* 15 */
SELECT e.ManagerID, COUNT(*) AS TotalEmployees
FROM HumanResources.Employee e
WHERE e.ManagerID IS NOT NULL
GROUP BY e.ManagerID

/* 16 */
SELECT SalesOrderID, SUM(OrderQty) AS TotalQuantity
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty) > 300

/* 17 */
SELECT * FROM Sales.SalesOrderHeader
WHERE OrderDate >= '1996-12-31'

/* 18 */
SELECT * FROM Sales.SalesOrderHeader
WHERE ShipToAddressID IN (
    SELECT AddressID
    FROM Person.Address
    WHERE CountryRegionCode = 'CA'
)

/* 19 */
SELECT * FROM Sales.SalesOrderHeader
WHERE TotalDue > 200

/* 20 */
SELECT a.CountryRegionCode, SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
GROUP BY a.CountryRegionCode

/* 21 */
SELECT p.FirstName + ' ' + p.LastName AS ContactName, COUNT(soh.SalesOrderID) AS NumberOfOrders
FROM Person.Person p
JOIN Sales.SalesOrderHeader soh ON p.BusinessEntityID = soh.CustomerID
GROUP BY p.FirstName, p.LastName

/* 22 */
SELECT p.FirstName + ' ' + p.LastName AS ContactName
FROM Person.Person p
JOIN Sales.SalesOrderHeader soh ON p.BusinessEntityID = soh.CustomerID
GROUP BY p.FirstName, p.LastName
HAVING COUNT(soh.SalesOrderID) > 3

/* 23 */
SELECT DISTINCT pr.*
FROM Production.Product pr
JOIN Sales.SalesOrderDetail sod ON pr.ProductID = sod.ProductID
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE pr.DiscontinuedDate IS NOT NULL
AND soh.OrderDate BETWEEN '1997-01-01' AND '1998-01-01'

/* 24 */
SELECT e.FirstName, e.LastName, s.FirstName AS SupervisorFirstName, s.LastName AS SupervisorLastName
FROM HumanResources.Employee e
LEFT JOIN HumanResources.Employee s ON e.ManagerID = s.BusinessEntityID

/* 25 */
SELECT e.BusinessEntityID, SUM(sod.LineTotal) AS TotalSales
FROM HumanResources.Employee e
JOIN Sales.SalesOrderHeader soh ON e.BusinessEntityID = soh.SalesPersonID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY e.BusinessEntityID

/* 26 */
SELECT * FROM HumanResources.Employee
WHERE FirstName LIKE '%a%'

/* 27 */
SELECT ManagerID, COUNT(*) AS NumberOfReports
FROM HumanResources.Employee
WHERE ManagerID IS NOT NULL
GROUP BY ManagerID
HAVING COUNT(*) > 4

/* 28 */
SELECT soh.SalesOrderID, p.Name AS ProductName
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID

/* 29 */
WITH BestCustomer AS (
    SELECT CustomerID
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
    ORDER BY SUM(TotalDue) DESC
    LIMIT 1
)
SELECT soh.*
FROM Sales.SalesOrderHeader soh
JOIN BestCustomer bc ON soh.CustomerID = bc.CustomerID

/* 30 */
SELECT soh.*
FROM Sales.SalesOrderHeader soh
JOIN Person.Person p ON soh.CustomerID = p.BusinessEntityID
WHERE p.Fax IS NULL

/* 31 */
SELECT DISTINCT a.PostalCode
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
WHERE p.Name = 'Tofu'

/* 32 */
SELECT DISTINCT p.Name
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
WHERE a.CountryRegionCode = 'FR'

/* 33 */
SELECT p.Name AS ProductName, pc.Name AS CategoryName
FROM Production.Product p
JOIN Production.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
JOIN Production.ProductVendor pv ON p.ProductID = pv.ProductID
JOIN Purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
WHERE v.Name = 'Specialty Biscuits, Ltd.'

/* 34 */
SELECT p.*
FROM Production.Product p
LEFT JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
WHERE sod.ProductID IS NULL

/* 35 */
SELECT p.*
FROM Production.Product p
WHERE p.UnitsInStock < 10 AND p.UnitsOnOrder = 0

/* 36 */
SELECT TOP 10 a.CountryRegionCode, SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
GROUP BY a.CountryRegionCode
ORDER BY SUM(soh.TotalDue) DESC

/* 37 */
SELECT soh.SalesPersonID, COUNT(*) AS NumberOfOrders
FROM Sales.SalesOrderHeader soh
WHERE soh.CustomerID BETWEEN @StartCustomerID AND @EndCustomerID
GROUP BY soh.SalesPersonID

/* 38 */
SELECT TOP 1 soh.OrderDate
FROM Sales.SalesOrderHeader soh
ORDER BY soh.TotalDue DESC

/* 39 */
SELECT p.Name AS ProductName, SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY p.Name

/* 40 */
SELECT pv.BusinessEntityID AS SupplierID, COUNT(pv.ProductID) AS NumberOfProducts
FROM Production.ProductVendor pv
GROUP BY pv.BusinessEntityID

/* 41 */
SELECT TOP 10 p.BusinessEntityID, SUM(soh.TotalDue) AS TotalBusiness
FROM Sales.SalesOrderHeader soh
JOIN Person.Person p ON soh.CustomerID = p.BusinessEntityID
GROUP BY p.BusinessEntityID
ORDER BY SUM(soh.TotalDue) DESC

/* 42 */
SELECT TOP 10 p.BusinessEntityID, SUM(soh.TotalDue) AS TotalBusiness
FROM Sales.SalesOrderHeader soh
JOIN Person.Person p ON soh.CustomerID = p.BusinessEntityID
GROUP BY p.BusinessEntityID
ORDER BY SUM(soh.TotalDue) DESC





