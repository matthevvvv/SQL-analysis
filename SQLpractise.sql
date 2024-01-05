--Dataset: AdventureWorks sample databases
--Data: https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2022.bak
--Questions set: https://www.w3resource.com/sql-exercises/adventureworks/adventureworks-exercises.php
--Database managment system: MS-SQL


--QUESTION 1
--Write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle.

SELECT h.*
FROM HumanResources.Employee h
ORDER BY h.JobTitle ASC;


--QUESTION 2
--From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. 
--Sort the output in ascending order on lastname.

SELECT p.*
FROM Person.Person p
ORDER BY p.LastName ASC;


--QUESTION 3
--From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. 
--The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.

SELECT p.FirstName, p.LastName, p.BusinessEntityID AS employee_id
FROM Person.Person p
ORDER BY LastName ASC;


--QUESTION 4
--From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. 
--Return productid, productnumber, and name. Arranged the output in ascending order on name.

SELECT p.productid, p.productnumber, p.name
FROM Production.Product p
WHERE P.SellStartDate IS NOT NULL 
AND p.ProductLine = 'T'
ORDER BY p.Name;


--QUESTION 5
--From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided. 
--Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal.

SELECT s.salesorderid, s.customerid, s.orderdate, s.TaxAmt/s.subtotal*100 AS tax_percent
FROM sales.salesorderheader s
ORDER BY s.SubTotal ASC;


--QUESTION 6
--From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. 
--Return jobtitle column and arranged the resultset in ascending order.

SELECT DISTINCT h.jobtitle
FROM HumanResources.Employee h
ORDER BY h.jobtitle;


--QUESTION 7
--From the following table write a query in SQL to calculate the total freight paid by each customer. 
--Return customerid and total freight. Sort the output in ascending order on customerid.

SELECT s.CustomerID, SUM(s.Freight) AS total_freight
FROM sales.salesorderheader s
GROUP BY s.CustomerID
ORDER BY s.CustomerID;


--QUESTION 8
--From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. 
--Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.

SELECT s.CustomerID, s.SalesPersonID, AVG(s.SubTotal) AS avg_subtotal, SUM(s.subtotal) AS sum_subtotal
FROM sales.salesorderheader s
GROUP BY s.CustomerID, s.SalesPersonID
ORDER BY s.CustomerID DESC;


--QUESTION 9
--From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500.
--Return productid and sum of the quantity. Sort the results according to the productid in ascending order.

SELECT p.ProductID, SUM(p.quantity)
FROM production.productinventory p
WHERE p.Shelf IN ('A', 'C', 'H')
GROUP BY p.ProductID
HAVING SUM(p.quantity) > 500
ORDER BY p.ProductID;


--QUESTION 10
--From the following table write a query in SQL to find the total quantity for a group of locationid multiplied by 10.

SELECT SUM(p.Quantity) AS total_quantity
FROM production.productinventory p
GROUP BY (p.LocationID*10);


--QUESTION 11
--From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. 
--Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.

SELECT p.BusinessEntityID, p.FirstName, p.LastName,  o.PhoneNumber
FROM Person.Person AS p
JOIN Person.PersonPhone AS o 
ON o.BusinessEntityID = p.BusinessEntityID
WHERE P.LastName LIKE 'L%'
ORDER BY p.LastName, p.FirstName;


--QUESTION 12
--From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. 
--Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.

SELECT s.salespersonid, s.customerid, SUM(s.subtotal) AS sum_subtotal
FROM Sales.SalesOrderHeader AS s
GROUP BY ROLLUP(s.SalesPersonID, s.CustomerID);


--QUESTION 13
--From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. 
--Return locationid, shelf and sum of quantity as TotalQuantity.

SELECT p.LocationID, p.Shelf, SUM(p.quantity) AS total_quantity
FROM production.productinventory AS p
GROUP BY CUBE (p.LocationID , p.Shelf);


--QUESTION 14
--From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. 
--Group the results for all combination of distinct locationid and shelf column. 
--Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity.

SELECT p.LocationID, p.Shelf, SUM(p.quantity) AS total_quantity
FROM production.productinventory AS p
GROUP BY GROUPING SETS (ROLLUP (p.LocationID , p.Shelf),CUBE(p.LocationID, p.Shelf));


--QUESTION 15
--From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. 
--Return locationid and total quantity. Group the results on locationid.

SELECT p.LocationID, SUM(p.quantity) AS total_quantity
FROM production.productinventory AS p
GROUP BY ROLLUP(p.LocationID);


--QUESTION 16
--From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. 
--Sort the result in ascending order on city.

SELECT p.City, COUNT(b.addressid) as number_of_employees
FROM person.Address p
INNER JOIN Person.BusinessEntityAddress AS b
ON p.AddressID = b.AddressID
GROUP BY p.City
ORDER BY p.City;


--QUESTION 17
--From the following table write a query in SQL to retrieve the total sales for each year. 
--Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.

SELECT YEAR(s.OrderDate) AS year, SUM(S.TotalDue) AS total_sale
FROM Sales.SalesOrderHeader s
GROUP BY YEAR(s.OrderDate)
ORDER BY YEAR(s.OrderDate);


--QUESTION 18
--From the following table write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2016. 
--Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date.

SELECT YEAR(s.OrderDate) AS year, SUM(S.TotalDue) AS total_sale
FROM Sales.SalesOrderHeader s
GROUP BY YEAR(s.OrderDate) 
HAVING YEAR(s.OrderDate) < '2016'
ORDER BY YEAR(s.OrderDate);


--QUESTION 19
--From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. 
--Returns ContactTypeID, name. Sort the result set in descending order.

SELECT p.ContactTypeID, P.name
FROM Person.ContactType P
WHERE p.name LIKE '%MANAGER%';


--QUESTION 20
--From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. 
--Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.

SELECT s.businessentityid, s.FirstName, s.LastName
FROM Person.BusinessEntityContact p
	INNER JOIN Person.ContactType c
		ON p.ContactTypeID = c.ContactTypeID 
	INNER JOIN Person.Person s
		ON s.BusinessEntityID = p.PersonID
WHERE c.Name LIKE 'Purchasing Manager'
ORDER BY s.LastName, s.FirstName;


--QUESTION 21
--From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. 
--Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
--Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.

SELECT ROW_NUMBER() OVER (PARTITION BY a.postalcode ORDER BY s.salesYTD DESC) AS 'Row Number', p.LastName, s.SalesYTD, a.postalcode
FROM Sales.SalesPerson s
INNER JOIN Person.Person p
	ON s.BusinessEntityID = p.BusinessEntityID
INNER JOIN Person.Address a
	ON s.BusinessEntityID = a.AddressID
WHERE s.SalesYTD IS NOT NULL AND s.TerritoryID IS NOT NULL
ORDER BY a.PostalCode;


--QUESTION 22
--From the following table write a query in SQL to count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. 
--Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts.

SELECT b.contacttypeid, c.name, COUNT(*) AS 'Number of contacts'
FROM Person.BusinessEntityContact b
INNER JOIN Person.ContactType c
	ON b.contacttypeid = c.contacttypeid
GROUP BY b.contacttypeid, c.name
HAVING COUNT(*) > 100
ORDER BY 'Number of contacts' DESC;


--QUESTION 23
--From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. 
--In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.

SELECT FORMAT(h.ratechangedate, 'yyyy-MM-dd') AS fromdate, --CAST(h.ratechangedate as VARCHAR(10)) can be used too
	CONCAT( p.LastName, ', ', p.FirstName,' ', p.MiddleName) AS nameinfull, 
	h.Rate*40 AS Salaryinweek
FROM HumanResources.EmployeePayHistory h
INNER JOIN Person.Person p
	ON p.BusinessEntityID = h.BusinessEntityID
ORDER BY nameinfull



--QUESTION 24
--From the following tables write a query in SQL to calculate and display the latest weekly salary of each employee. 
--Return RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees Sort the output in ascending order on NameInFull.

SELECT CONVERT(VARCHAR, CONVERT(DATE,CAST(h.ratechangedate as VARCHAR(11))),23) AS fromdate,
	CONCAT( p.LastName, ', ', p.FirstName,' ', p.MiddleName) AS nameinfull,
	h.Rate*40 AS Salaryinweek
FROM HumanResources.EmployeePayHistory h 
INNER JOIN Person.Person p
	ON p.BusinessEntityID = h.BusinessEntityID
	WHERE h.RateChangeDate = (SELECT MAX(ratechangedate)
	FROM HumanResources.EmployeePayHistory
	WHERE BusinessEntityID = h.BusinessEntityID)
ORDER BY nameinfull



--QUESTION 25
--From the following table write a query in SQL to find the sum, average, count, minimum, and maximum order quentity for those orders whose id are 43659 and 43664. 
--Return SalesOrderID, ProductID, OrderQty, sum, average, count, max, and min order quantity.

SELECT s.SalesOrderID, s.productid, s.orderqty, 
	SUM(s.OrderQty) OVER( PARTITION BY s.salesorderid) AS total_quantity, 
	AVG(CAST(s.OrderQty AS FLOAT)) OVER( PARTITION BY s.salesorderid) AS avg_quantity,
	COUNT(*) OVER( PARTITION BY s.salesorderid) AS count_quantity, 
	MIN(s.OrderQty) OVER( PARTITION BY s.salesorderid)AS min_quantity, 
	MAX(s.OrderQty) OVER( PARTITION BY s.salesorderid)AS max_quantity 
FROM Sales.SalesOrderDetail s
WHERE s.SalesOrderID IN ('43659','43664')



--QUESTION 26
--From the following table write a query in SQL to find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. 
--Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.

SELECT s.SalesOrderID AS ordernumber, s.productid, s.orderqty AS quantity, 
	SUM(s.orderqty) OVER( ORDER BY s.salesorderid, s.productid) AS total, 
	AVG(CAST(s.orderqty AS FLOAT)) OVER( PARTITION BY s.salesorderid ORDER BY s.salesorderid, s.productid) AS avg,
	COUNT(s.orderqty) OVER( ORDER BY s.salesorderid, s.productid ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING) AS count
FROM Sales.SalesOrderDetail s
WHERE s.SalesOrderID IN ('43659','43664') AND s.ProductID LIKE '71%';


--QUESTION 27
--From the following table write a query in SQL to retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost.

SELECT s.SalesOrderID, SUM(s.unitprice*s.OrderQty) AS orderidcost
FROM Sales.SalesOrderDetail s
GROUP BY s.SalesOrderID
HAVING SUM(s.unitprice*s.OrderQty) > 100000;



--QUESTION 28
--From the following table write a query in SQL to retrieve products whose names start with 'Lock Washer'. 
--Return product ID, and name and order the result set in ascending order on product ID column.

SELECT p.ProductID, p.Name
FROM Production.Product p
WHERE p.Name LIKE 'Lock Washer%'
ORDER BY p.ProductID



--QUESTION 29
--Write a query in SQL to fetch rows from product table and order the result set on an unspecified column listprice. 
--Return product ID, name, and color of the product.

SELECT p.ProductID, p.Name, P.Color
FROM Production.Product p
ORDER BY p.ListPrice;



--QUESTION 30
--From the following table write a query in SQL to retrieve records of employees. Order the output on year (default ascending order) of hiredate. 
--Return BusinessEntityID, JobTitle, and HireDate.

SELECT h.BusinessEntityID, h.JobTitle, h.HireDate
FROM HumanResources.Employee h
ORDER BY YEAR(h.HireDate)



--QUESTION 31
--From the following table write a query in SQL to retrieve those persons whose last name begins with letter 'R'. 
--Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.

SELECT p.lastname, p.firstname
FROM Person.Person p
WHERE p.LastName LIKE 'R%'
ORDER BY p.FirstName, p.LastName DESC;



--QUESTION 32
--From the following table write a query in SQL to order the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'. 
--Return BusinessEntityID, SalariedFlag columns.

SELECT h.BusinessEntityID, h.SalariedFlag 
FROM HumanResources.Employee h
ORDER BY CASE h.SalariedFlag WHEN 'true' THEN h.BusinessEntityID END DESC,
		CASE WHEN h.SalariedFlag = 'false' THEN h.BusinessEntityID END;



--QUESTION 33
--From the following table write a query in SQL to set the result in order by the column TerritoryName 
--when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.

SELECT s.BusinessEntityID, p.LastName, t.Name AS territoryname, t.CountryRegionCode
FROM Sales.SalesPerson s
INNER JOIN Sales.SalesTerritory t
	ON s.TerritoryID = t.TerritoryID
INNER JOIN Person.Person p
	ON p.BusinessEntityID = s.BusinessEntityID
ORDER BY CASE t.CountryRegionCode WHEN 'US' THEN t.Name 
		ELSE t.CountryRegionCode END;


--QUESTION 34
--From the following table write a query in SQL to find those persons who lives in a territory and the value of salesytd except 0. 
--Return first name, last name,row number as 'Row Number', 'Rank', 'Dense Rank' and NTILE as 'Quartile', salesytd and postalcode. Order the output on postalcode column.

SELECT p.FirstName, p.LastName, 
	ROW_NUMBER() OVER(ORDER BY a.postalcode) AS Row_number, 
	RANK() OVER(ORDER BY a.PostalCode) AS Rank,
	DENSE_RANK() OVER(ORDER BY a.PostalCode) AS Dense_Rank,
	NTILE(4) OVER (ORDER BY a.PostalCode) AS Quartile,
	s.SalesYTD, a.PostalCode
FROM Person.Person p
INNER JOIN Sales.SalesPerson s
	ON p.BusinessEntityID = s.BusinessEntityID
INNER JOIN Person.Address a
	ON p.BusinessEntityID = a.AddressID
WHERE s.TerritoryID IS NOT NULL AND s.SalesYTD <> 0



--QUESTION 35
--From the following table write a query in SQL to skip the first 10 rows from the sorted result set and return all remaining rows.

SELECT DepartmentID, Name, GroupName
FROM HumanResources.Department
ORDER BY DepartmentID OFFSET 10 ROWS;



--QUESTION 36
--From the following table write a query in SQL to skip the first 5 rows and return the next 5 rows from the sorted result set.

SELECT DepartmentID, Name, GroupName
FROM HumanResources.Department
ORDER BY DepartmentID 
	OFFSET 5 ROWS
	FETCH NEXT 5 ROWS ONLY;



--QUESTION 37
-- From the following table write a query in SQL to list all the products that are Red or Blue in color. Return name, color and listprice.Sorts this result by the column listprice.

SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color IN ('Blue', 'Red')
ORDER BY ListPrice;



--QUESTION 38
--Create a SQL query from the SalesOrderDetail table to retrieve the product name and any associated sales orders. 
--Additionally, it returns any sales orders that don't have any items mentioned in the Product table as well as any products that have sales orders other than those that are listed there. 
--Return product name, salesorderid. Sort the result set on product name column.

SELECT p.Name, s.SalesOrderID
FROM Production.Product p
FULL OUTER JOIN Sales.SalesOrderDetail s
	ON p.ProductID = s.ProductID
ORDER BY p.Name;



--QUESTION 39
--From the following table write a SQL query to retrieve the product name and salesorderid. Both ordered and unordered products are included in the result set.

SELECT p.Name, s.SalesOrderID
FROM Production.Product p
LEFT OUTER JOIN Sales.SalesOrderDetail s
	ON p.ProductID = s.ProductID
ORDER BY p.Name;



--QUESTION 40
--From the following tables write a SQL query to get all product names and sales order IDs. Order the result set on product name column.

SELECT p.Name, s.SalesOrderID
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail s
	ON p.ProductID = s.ProductID
ORDER BY p.Name



--QUESTION 41
--From the following tables write a SQL query to retrieve the territory name and BusinessEntityID. 
--The result set includes all salespeople, regardless of whether or not they are assigned a territory.

SELECT t.Name, p.BusinessEntityID
FROM Sales.SalesTerritory t
RIGHT JOIN Sales.SalesPerson p
	ON p.TerritoryID = t.TerritoryID



--QUESTION 42
--Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. 
--Order the result set on lastname then by firstname.

SELECT CONCAT(p.FirstName, ' ', p.LastName) AS name, a.City
FROM Person.Person p
JOIN Person.BusinessEntityAddress t
	ON p.BusinessEntityID = t.BusinessEntityID
JOIN Person.Address a
	ON t.AddressID = a.AddressID
ORDER BY p.LastName, p.FirstName



--QUESTION 43
--Write a SQL query to return the businessentityid,firstname and lastname columns of all persons in the person table (derived table) with persontype is 'IN' and the last name is 'Adams'. 
--Sort the result set in ascending order on firstname. A SELECT statement after the FROM clause is a derived table.

SELECT *
FROM ( SELECT p.businessentityid, p.FirstName, p.LastName
	FROM Person.Person p
	WHERE p.PersonType = 'IN' AND p.LastName = 'Adams') AS derived
ORDER BY FirstName;



--QUESTION 44
--Create a SQL query to retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.

SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID <= 1500 AND LastName LIKE 'Al%' AND FirstName LIKE 'M%'
ORDER BY BusinessEntityID



--QUESTION 45
--Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.

SELECT ProductID, Name, Color
FROM (SELECT * FROM Production.Product p
	WHERE p.Name IN ('Blade', 'Crown Race', 'AWC Logo Cap')) AS items



--QUESTION 46
--Create a SQL query to display the total number of sales orders each sales representative receives annually. 
--Sort the result set by SalesPersonID and then by the date component of the orderdate in ascending order. Return the year component of the OrderDate, SalesPersonID, and SalesOrderID.

SELECT SalesPersonID, YEAR(OrderDate),
COUNT(*) OVER( PARTITION BY salespersonid, YEAR(OrderDate)) AS count_quantity
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL

SELECT SalesPersonID, 
	COUNT(SalesOrderID) AS totalsales,
	YEAR(OrderDate) AS salesyear
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY YEAR(OrderDate), SalesPersonID
ORDER BY SalesPersonID, salesyear;



--QUESTION 47
--From the following table write a query in SQL to find the average number of sales orders for all the years of the sales representatives.

SELECT COUNT(salespersonid)/COUNT(DISTINCT(salespersonid)) AS 'Average Sales Per Person'
FROM Sales.SalesOrderHeader

--OR

WITH Sales_CTE (SalesPersonID, NumberOfOrders)
AS
(SELECT SalesPersonID, COUNT(*)
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID)

SELECT AVG(NumberOfOrders) AS 'Average Sales Per Person'
FROM Sales_CTE;