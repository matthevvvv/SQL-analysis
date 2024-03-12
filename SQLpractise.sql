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
ORDER BY nameinfull;



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
ORDER BY nameinfull;



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
WHERE s.SalesOrderID IN ('43659','43664');



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
ORDER BY p.ProductID;



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
ORDER BY YEAR(h.HireDate);



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
WHERE s.TerritoryID IS NOT NULL AND s.SalesYTD <> 0;



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
ORDER BY p.Name;



--QUESTION 41
--From the following tables write a SQL query to retrieve the territory name and BusinessEntityID. 
--The result set includes all salespeople, regardless of whether or not they are assigned a territory.

SELECT t.Name, p.BusinessEntityID
FROM Sales.SalesTerritory t
RIGHT JOIN Sales.SalesPerson p
	ON p.TerritoryID = t.TerritoryID;



--QUESTION 42
--Write a query in SQL to find the employee's full name (firstname and lastname) and city from the following tables. 
--Order the result set on lastname then by firstname.

SELECT CONCAT(p.FirstName, ' ', p.LastName) AS name, a.City
FROM Person.Person p
JOIN Person.BusinessEntityAddress t
	ON p.BusinessEntityID = t.BusinessEntityID
JOIN Person.Address a
	ON t.AddressID = a.AddressID
ORDER BY p.LastName, p.FirstName;



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
ORDER BY BusinessEntityID;



--QUESTION 45
--Write a SQL query to find the productid, name, and colour of the items 'Blade', 'Crown Race' and 'AWC Logo Cap' using a derived table with multiple values.

SELECT ProductID, Name, Color
FROM (SELECT * FROM Production.Product p
	WHERE p.Name IN ('Blade', 'Crown Race', 'AWC Logo Cap')) AS items;



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



--QUESTION 48
--Write a SQL query on the following table to retrieve records with the characters green_ in the LargePhotoFileName field. 
--The following table's columns must all be returned.

SELECT *
FROM Production.ProductPhoto
WHERE LargePhotoFileName LIKE '%green/_%' ESCAPE '/';



--QUESTION 49
--Write a SQL query to retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. 
--Return Addressline1, Addressline2, city, postalcode, countryregioncode columns.

SELECT a.AddressLine1, a.AddressLine2, a.City, a.PostalCode, s.CountryRegionCode
FROM Person.Address a
INNER JOIN Person.StateProvince s
	ON a.StateProvinceID = s.StateProvinceID
WHERE (a.City LIKE 'Pa%') AND (s.CountryRegionCode <> 'US');



--QUESTION 50
--From the following table write a query in SQL to fetch first twenty rows. Return jobtitle, hiredate. Order the result set on hiredate column in descending order.

SELECT TOP 20 JobTitle, HireDate
FROM HumanResources.Employee
ORDER BY HireDate DESC;



--QUESTION 51
--From the following tables write a SQL query to retrieve the orders with orderqtys greater than 5 or unitpricediscount less than 1000, and totaldues greater than 100. 
--Return all the columns from the tables.

SELECT h.*, d.*
FROM Sales.SalesOrderHeader h
INNER JOIN sales.SalesOrderDetail d
	ON h.SalesOrderID = d.SalesOrderID
WHERE (d.OrderQty > 5 OR D.UnitPriceDiscount < 1000) 
	AND h.TotalDue > 100;



--QUESTION 52
--From the following table write a query in SQL that searches for the word 'red' in the name column. Return name, and color columns from the table.

SELECT Name, Color
FROM Production.Product
WHERE Name LIKE '%red%';



--QUESTION 53
--From the following table write a query in SQL to find all the products with a price of $80.99 that contain the word Mountain. 
--Return name, and listprice columns from the table.

SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice = '80.99' AND Name LIKE '%Mountain%';



--QUESTION 54
--From the following table write a query in SQL to retrieve all the products that contain either the phrase Mountain or Road. Return name, and color columns.

SELECT Name, Color
FROM Production.Product
WHERE Name LIKE '%Mountain%' OR NAME LIKE '%Road%';



--QUESTION 55
--From the following table write a query in SQL to search for name which contains both the word 'Mountain' and the word 'Black'. Return Name and color.

SELECT Name, Color 
FROM Production.Product
WHERE Name LIKE '%Mountain%' AND NAME LIKE '%Black%';



--QUESTION 56
--From the following table write a query in SQL to return all the product names with at least one word starting with the prefix chain in the Name column.

SELECT Name, Color
FROM Production.Product
WHERE Name LIKE 'Chain' OR Name LIKE 'Chain %';



--QUESTION 57
--From the following table write a query in SQL to return all category descriptions containing strings with prefixes of either chain or full.

SELECT Name, Color
FROM Production.Product
WHERE Name LIKE 'Chain' OR Name LIKE 'Chain %' OR Name LIKE 'Full%' ;



--QUESTION 58
--From the following table write a SQL query to output an employee's name and email address, separated by a new line character.

SELECT CONCAT(p.firstname, ' ', p.LastName, CHAR(10), e.EmailAddress)
FROM Person.Person p
INNER JOIN Person.EmailAddress e
ON p.BusinessEntityID = e.BusinessEntityID;



--QUESTION 59
--From the following table write a SQL query to locate the position of the string "yellow" where it appears in the product name.

SELECT Name, CHARINDEX('yellow', Name) AS starting_position
FROM Production.Product
WHERE CHARINDEX('yellow', Name) > 0;



--QUESTION 60
--From the following table write a query in SQL to concatenate the name, color, and productnumber columns.

SELECT CONCAT(Name, '	color:-', Color, ' Product Number:', ProductNumber) AS result, Color
FROM Production.Product;



--QUESTION 61
--Write a SQL query that concatenate the columns name, productnumber, colour, and a new line character from the following table, each separated by a specified character.

SELECT CONCAT(Name, ',',ProductNumber,',', Color, CHAR(10)) AS	databaseinfo
FROM Production.Product;
 


--QUESTION 62
--From the following table write a query in SQL to return the five leftmost characters of each product name.

SELECT LEFT(Name, 5) AS leftmost
FROM Production.Product;



--QUESTION 63
--From the following table write a query in SQL to select the number of characters and the data in FirstName for people located in Australia.

SELECT LEN(FirstName) AS 'length', FirstName, LastName
FROM Sales.vindividualcustomer
WHERE CountryRegionName = 'Australia';



--QUESTION 64
--From the following tables write a query in SQL to return the number of characters in the column FirstName and the first and last name of contacts located in Australia.

SELECT DISTINCT LEN(c.FirstName) AS fnamelength, c.FirstName, c.LastName
FROM Sales.vstorewithcontacts c
INNER JOIN Sales.vstorewithaddresses a
	ON c.BusinessEntityID = a.BusinessEntityID
WHERE CountryRegionName = 'Australia';



--QUESTION 65
--From the following table write a query in SQL to select product names that have prices between $1000.00 and $1220.00. 
--Return product name as Lower, Upper, and also LowerUpper.

SELECT LOWER(Name) AS 'lower', 
	UPPER(Name) AS 'upper', 
	LOWER(UPPER(Name ))AS 'lowerupper'
FROM Production.Product
WHERE StandardCost BETWEEN 1000 AND 1220;



--QUESTION 66
--Write a query in SQL to remove the spaces from the beginning of a string.

SELECT  '     five space then the text' AS "Original Text",
	LTRIM('     five space then the text') AS "Trimmed Text(space removed)";



--QUESTION 67
--From the following table write a query in SQL to remove the substring 'HN' from the start of the column productnumber. 
--Filter the results to only show those productnumbers that start with "HN". Return original productnumber column and 'TrimmedProductnumber'.

SELECT ProductNumber, SUBSTRING(ProductNumber, 3, LEN(Productnumber)) AS Trimmed
FROM Production.Product
WHERE ProductNumber LIKE 'HN%';



--QUESTION 68
--From the following table write a query in SQL to repeat a 0 character four times in front of a production line for production line 'T'.

SELECT NAME, CONCAT('0000', ProductLine) AS "Line Code"
FROM Production.Product
WHERE ProductLine = 'T';



--QUESTION 69
--From the following table write a SQL query to retrieve all contact first names with the characters inverted for people whose businessentityid is less than 6.

SELECT FirstName, REVERSE(Firstname) AS Reverse_name
FROM Person.Person
WHERE BusinessEntityID < 6;



--QUESTION 70
--From the following table write a query in SQL to return the eight rightmost characters of each name of the product. 
--Also return name, productnumber column. Sort the result set in ascending order on productnumber.

SELECT Name, ProductNumber, SUBSTRING(NAME, LEN(Name)-7, 9) AS "Product Name"  
FROM Production.Product
ORDER BY ProductNumber;

--OR

SELECT name, productnumber, RIGHT(name, 8) AS "Product Name"  
FROM production.product 
ORDER BY productnumber;



--QUESTION 71
--Write a query in SQL to remove the spaces at the end of a string.

SELECT  CONCAT('text then five spaces     ','after space') AS "Original Text",
	CONCAT(RTRIM('text then five spaces    '),'after space') AS "Trimmed Text(space removed)";



--QUESTION 72
--From the following table write a query in SQL to fetch the rows for the product name ends with the letter 'S' or 'M' or 'L'. Return productnumber and name.



SELECT ProductNumber,Name
FROM Production.Product
WHERE 
Name LIKE '% S' OR Name LIKE '% M' OR Name LIKE '% L';



--QUESTION 73
--From the following table write a query in SQL to replace null values with 'N/A' and return the names separated by commas in a single row.

SELECT STRING_AGG(COALESCE(FirstName, 'N/A'),',') AS test
FROM Person.Person;



--QUESTION 74
--From the following table write a query in SQL to return the names and modified date separated by commas in a single row.

SELECT STRING_AGG(CONCAT(firstname, ' ', lastname, ' ', '(',ModifiedDate,')'), ',') AS test
FROM Person.Person;



--QUESTION 75
--From the following table write a query in SQL to find the email addresses of employees and groups them by city. Return top ten rows.

SELECT TOP 4 a.City, STRING_AGG(e.emailaddress, ';') AS emails
FROM Person.EmailAddress e
INNER JOIN Person.BusinessEntityAddress b
	ON e.BusinessEntityID = b.BusinessEntityID
INNER JOIN Person.Address a
	ON b.AddressID = a.AddressID
GROUP BY a.City;



--QUESTION 76
--From the following table write a query in SQL to create a new job title called "Production Assistant" in place of "Production Supervisor".

SELECT jobtitle, STUFF(jobtitle, 12, 10, 'Assistant') as "New Jobtitle"
FROM humanresources.employee 
WHERE SUBSTRING(jobtitle,12,10)='Supervisor';



--QUESTION 77
--From the following table write a SQL query to retrieve all the employees whose job titles begin with "Sales". 
--Return firstname, middlename, lastname and jobtitle column.

SELECT p.FirstName, p.MiddleName, p.LastName, h.JobTitle
FROM Person.Person p
JOIN HumanResources.Employee h
ON p.BusinessEntityID = h.BusinessEntityID
WHERE h.JobTitle LIKE 'Sales%';



--QUESTION 78
--From the following table write a query in SQL to return the last name of people so that it is in uppercase, trimmed, and concatenated with the first name.

SELECT TRIM(CONCAT(UPPER(lastname), ', ', firstname)) AS name
FROM Person.Person;


--QUESTION 79
--From the following table write a query in SQL to show a resulting expression that is too small to display. 
--Return FirstName, LastName, Title, and SickLeaveHours. The SickLeaveHours will be shown as a small expression in text format.

SELECT p.FirstName, p.LastName, p.Title, CAST(h.SickLeaveHours AS char(1)) AS "Sick Leave"
FROM HumanResources.Employee h
JOIN Person.Person p
ON p.BusinessEntityID = h.BusinessEntityID;



--QUESTION 80
--From the following table write a query in SQL to retrieve the name of the products. Product, that have 33 as the first two digits of listprice.

SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice LIKE '33%';



--QUESTION 81
--From the following table write a query in SQL to calculate by dividing the total year-to-date sales (SalesYTD) by the commission percentage (CommissionPCT). 
--Return SalesYTD, CommissionPCT, and the value rounded to the nearest whole number.

SELECT SalesYTD, CommissionPct, CAST(ROUND(SalesYTD/NULLIF(CommissionPct,0),0)AS INT) AS division
FROM Sales.SalesPerson;



--QUESTION 82
--From the following table write a query in SQL to find those persons that have a 2 in the first digit of their SalesYTD. 
--Convert the SalesYTD column to an int type, and then to a char(20) type. Return FirstName, LastName, SalesYTD, and BusinessEntityID.

SELECT p.FirstName, p.LastName, CAST(CAST(s.SalesYTD AS INT) AS CHAR(20)) AS salesytd, p.BusinessEntityID
FROM Person.Person p
JOIN Sales.SalesPerson s
ON p.BusinessEntityID = s.BusinessEntityID
WHERE s.SalesYTD LIKE '2%';  



--QUESTION 83
--From the following table write a query in SQL to convert the Name column to a char(16) column. 
--Convert those rows if the name starts with 'Long-Sleeve Logo Jersey'. Return name of the product and listprice.

SELECT CAST(Name AS CHAR(16)), ListPrice
FROM Production.Product
WHERE Name LIKE 'Long-Sleeve Logo Jersey%';



--QUESTION 84
--From the following table write a SQL query to determine the discount price for the salesorderid 46672. Calculate only those orders with discounts of more than.02 percent. 
--Return productid, UnitPrice, UnitPriceDiscount, and DiscountPrice (UnitPrice*UnitPriceDiscount ).

SELECT ProductID, UnitPrice, UnitPriceDiscount, UnitPrice*UnitPriceDiscount AS DiscountPrice
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0.02 AND SalesOrderID = 46672;



--QUESTION 85
--From the following table write a query in SQL to calculate the average vacation hours, and the sum of sick leave hours, that the vice presidents have used.

SELECT AVG(vacationhours) AS 'Average vacation hours', SUM(sickleavehours) AS 'Total sick leave hours'
FROM HumanResources.Employee
WHERE JobTitle LIKE 'Vice President%';



--QUESTION 86
--From the following table write a query in SQL to calculate the average bonus received and the sum of year-to-date sales for each territory. 
--Return territoryid, Average bonus, and YTD sales.

SELECT TerritoryID, AVG(Bonus) AS 'Average bonus', SUM(SalesYTD) AS 'YTD sales'
FROM Sales.SalesPerson
GROUP BY TerritoryID;



--QUESTION 87
--From the following table write a query in SQL to return the average list price of products. Consider the calculation only on unique values.

SELECT AVG(DISTINCT(ListPrice))
FROM Production.Product;



--QUESTION 88
--From the following table write a query in SQL to return a moving average of yearly sales for each territory. 
--Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.

SELECT BusinessEntityID, TerritoryID, YEAR(modifieddate), SalesYTD, 
AVG(salesYTD) OVER (PARTITION BY territoryid ORDER BY YEAR(modifieddate)) AS MovingAvg, 
SUM(salesYTD) OVER (PARTITION BY territoryid ORDER BY YEAR(modifieddate)) AS CumulativeTotal
FROM Sales.SalesPerson;



--QUESTION 89
--From the following table write a query in SQL to return a moving average of sales, by year, for all sales territories. 
--Return BusinessEntityID, TerritoryID, SalesYear, SalesYTD, average SalesYTD as MovingAvg, and total SalesYTD as CumulativeTotal.

SELECT BusinessEntityID, TerritoryID, YEAR(ModifiedDate) AS salesyear, SalesYTD, SalesYTD ,
AVG(salesYTD) OVER (PARTITION BY YEAR(modifieddate) ORDER BY YEAR(modifieddate)) AS MovingAvg, 
SUM(salesYTD) OVER (PARTITION BY YEAR(modifieddate) ORDER BY YEAR(modifieddate)) AS CumulativeTotal
FROM Sales.SalesPerson;



--QUESTION 90
--From the following table write a query in SQL to return the number of different titles that employees can hold.

SELECT COUNT(DISTINCT JobTitle) AS 'Number of Jobtitles'
FROM HumanResources.Employee;



--QUESTION 91
--From the following table write a query in SQL to find the total number of employees.

SELECT COUNT(*) AS 'Number of employees'
FROM HumanResources.Employee;



--QUESTION 92
--From the following table write a query in SQL to find the average bonus for the salespersons who achieved the sales quota above 25000. 
--Return number of salespersons, and average bonus.

SELECT COUNT(BusinessEntityID) AS count, AVG(bonus) AS avg
FROM Sales.SalesPerson
WHERE SalesQuota > 25000;



--QUESTION 93
--From the following tables wirte a query in SQL to return aggregated values for each department. 
--Return name, minimum salary, maximum salary, average salary, and number of employees in each department.

SELECT DISTINCT d.name,
	MIN(e.rate) OVER (PARTITION BY h.departmentid ORDER BY h.departmentid) AS minsalary,
	MAX(e.rate) OVER (PARTITION BY h.departmentid ORDER BY h.departmentid) AS maxsalary,
	AVG(e.rate) OVER (PARTITION BY h.departmentid ORDER BY h.departmentid) AS avgsalary,
	COUNT(h.BusinessEntityID) OVER (PARTITION BY h.departmentid ORDER BY h.departmentid) AS employeesperdept
FROM HumanResources.EmployeePayHistory e
INNER JOIN HumanResources.EmployeeDepartmentHistory h
	ON e.BusinessEntityID = h.BusinessEntityID
INNER JOIN HumanResources.Department d
	ON h.DepartmentID = d.DepartmentID
WHERE h.EndDate IS NULL;



--QUESTION 94
--From the following tables write a SQL query to return the departments of a company that each have more than 15 employees.

SELECT JobTitle, COUNT(BusinessEntityID) AS employeenumber
FROM HumanResources.Employee
GROUP BY JobTitle
HAVING COUNT(BusinessEntityID) > 15;



--QUESTION 95
--From the following table write a query in SQL to find the number of products that ordered in each of the specified sales orders.

SELECT salesorderid, COUNT(orderqty) AS productcount
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID;



--QUESTION 96
--From the following table write a query in SQL to compute the statistical variance of the sales quota values for each quarter in a calendar year for a sales person. 
--Return year, quarter, salesquota and variance of salesquota.

SELECT QuotaDate AS year, datepart(QUARTER, quotadate) AS quarter, AVG(salesquota), VAR(SalesQuota) AS variance
FROM Sales.SalesPersonQuotaHistory
GROUP BY QuotaDate, datepart(QUARTER, quotadate);



--QUESTION 97
--From the following table write a query in SQL to populate the variance of all unique values as well as all values, including any duplicates values of SalesQuota column.

SELECT VAR(DISTINCT SalesQuota) AS distinct_values, VAR(SalesQuota) AS all_values
FROM Sales.SalesPersonQuotaHistory;



--QUESTION 98
--From the following table write a query in SQL to return the total ListPrice and StandardCost of products for each color. Products that name starts with 'Mountain' and ListPrice is more than zero. 
--Return Color, total list price, total standardcode. Sort the result set on color in ascending order.

SELECT Color, SUM(ListPrice) AS sum, SUM(StandardCost) AS sum
FROM Production.Product
WHERE Name LIKE 'Mountain%' 
	AND ListPrice > 0
	AND Color IS NOT NULL
GROUP BY Color;



--QUESTION 99
--From the following table write a query in SQL to find the TotalSalesYTD of each SalesQuota. 
--Show the summary of the TotalSalesYTD amounts for all SalesQuota groups. Return SalesQuota and TotalSalesYTD.

SELECT SalesQuota, SUM(SalesYTD),
GROUPING(SalesQuota) AS Grouping
FROM Sales.SalesPerson
GROUP BY ROLLUP(SalesQuota);



--QUESTION 100
--From the following table write a query in SQL to calculate the sum of the ListPrice and StandardCost for each color. Return color, sum of ListPrice.

SELECT Color, SUM(ListPrice) AS totallist, SUM(StandardCost) AS totalcost
FROM Production.Product
GROUP BY Color;



--QUESTION 101
--From the following table write a query in SQL to calculate the salary percentile for each employee within a given department. 
--Return department, last name, rate, cumulative distribution and percent rank of rate. Order the result set by ascending on department and descending on rate.

SELECT r.Name, p.LastName, e.Rate, 
SUM(1.0) OVER (ORDER BY e.rate) / COUNT(*) OVER () AS cumedist, 
PERCENT_RANK() OVER (ORDER BY E.RATE) AS pctrank
FROM HumanResources.EmployeeDepartmentHistory d
INNER JOIN HumanResources.EmployeePayHistory e
	ON d.BusinessEntityID = e.BusinessEntityID
INNER JOIN Person.Person p
	ON d.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.Department r
	ON d.DepartmentID = r.DepartmentID;



--QUESTION 102
--From the following table write a query in SQL to return the name of the product that is the least expensive in a given product category. 
--Return name, list price and the first value i.e. LeastExpensive of the product.

SELECT name, listprice, FIRST_VALUE(Name) OVER (ORDER BY LISTPRICE) AS LeastExpensive
FROM Production.Product
WHERE ListPrice > 0 AND ProductSubcategoryID = 1;



--QUESTION 103
--From the following table write a query in SQL to return the employee with the fewest number of vacation hours compared to other employees with the same job title. 
--Partitions the employees by job title and apply the first value to each partition independently.

SELECT FIRST_VALUE(E.JOBTITLE) OVER (PARTITION BY e.jobtitle ORDER BY e.VacationHours) AS jobtitle, 
p.LastName , e.VacationHours,
FIRST_VALUE(p.lastname) OVER (PARTITION BY e.jobtitle ORDER BY e.VacationHours) AS fewestvacationhours
FROM Person.Person p
INNER JOIN HumanResources.Employee e	
	ON p.BusinessEntityID = e.BusinessEntityID;



--QUESTION 104
--From the following table write a query in SQL to return the difference in sales quotas for a specific employee over previous years. 
--Returun BusinessEntityID, sales year, current quota, and previous quota.

SELECT BusinessEntityID, YEAR(quotadate) AS salesyear, SalesQuota AS currentquota,
LAG(salesquota, 1, 0) OVER (ORDER BY  YEAR(quotadate)) AS previousquota
FROM Sales.SalesPersonQuotaHistory;



--QUESTION 105
--From the following table write a query in SQL to compare year-to-date sales between employees. 
--Return TerritoryName, BusinessEntityID, SalesYTD, and sales of previous year i.e.PrevRepSales. Sort the result set in ascending order on territory name.

SELECT TerritoryName, BusinessEntityID, SalesYTD,  LAG(salesytd, 1, 0) OVER (PARTITION BY territoryname ORDER BY salesytd DESC) AS prevrepsales
FROM Sales.vSalesPerson
ORDER BY TerritoryName;



--QUESTION 106
--From the following tables write a query in SQL to return the hire date of the last employee in each department for the given salary (Rate). 
--Return department, lastname, rate, hiredate, and the last value of hiredate.

SELECT d.department, d.LastName, p.Rate, e.HireDate, 
LAST_VALUE(e.hiredate) OVER (PARTITION BY d.department ORDER BY p.rate) AS lastvalue
FROM HumanResources.vEmployeeDepartmentHistory d
INNER JOIN HumanResources.EmployeePayHistory p
	ON d.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.Employee e
	ON p.BusinessEntityID = e.BusinessEntityID;



--QUESTION 107
--From the following table write a query in SQL to compute the difference between the sales quota value for the current quarter and the first and last quarter of the year respectively for a given number of employees. 
--Return BusinessEntityID, quarter, year, differences between current quarter and first and last quarter. 
--Sort the result set on BusinessEntityID, SalesYear, and Quarter in ascending order.

SELECT BusinessEntityID, DATEPART(quarter, quotadate) AS quarter, YEAR(QuotaDate) AS salesyear, salesquota AS thisyearquota,
salesquota - FIRST_VALUE(salesquota) OVER (PARTITION BY businessentityid, YEAR(QuotaDate) ORDER BY DATEPART(quarter, quotadate)) AS difffromfirstquarter,
salesquota - LAST_VALUE(salesquota) OVER (PARTITION BY businessentityid, YEAR(QuotaDate) ORDER BY DATEPART(quarter, quotadate) 
	RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS differencefromlastquarter
FROM Sales.SalesPersonQuotaHistory
ORDER BY BusinessEntityID, salesyear, quarter;



--QUESTION 108
--From the following table write a query in SQL to return the statistical variance of the sales quota values for a salesperson for each quarter in a calendar year. 
--Return quotadate, quarter, SalesQuota, and statistical variance. Order the result set in ascending order on quarter.

SELECT YEAR(QuotaDate) AS year, DATEPART(quarter, quotadate) AS quarter, SalesQuota, 
VAR(salesquota) OVER (ORDER BY YEAR(QuotaDate), DATEPART(quarter, quotadate)) AS variance
FROM Sales.SalesPersonQuotaHistory
WHERE YEAR(QuotaDate) LIKE 2012 AND businessentityid = 277;



--QUESTION 109
--From the following table write a query in SQL to return the difference in sales quotas for a specific employee over subsequent years. 
--Return BusinessEntityID, year, SalesQuota, and the salesquota coming in next row.

SELECT BusinessEntityID, YEAR(QuotaDate) AS salesyear, SalesQuota AS currentquota,
LEAD(salesquota, 1, 0) OVER (ORDER BY YEAR(QuotaDate)) AS nextquota
FROM Sales.SalesPersonQuotaHistory
WHERE BusinessEntityID = 277;



--QUESTION 110
--From the following query write a query in SQL to compare year-to-date sales between employees for specific terrotery. 
--Return TerritoryName, BusinessEntityID, SalesYTD, and the salesquota coming in next row.

SELECT TerritoryName, BusinessEntityID, SalesYTD, LEAD(SalesYTD, 1, 0) OVER (PARTITION BY TERRITORYNAME ORDER BY SALESYTD) AS nextrepsales
FROM Sales.vSalesPerson
WHERE TerritoryName IN ('Northwest', 'Canada');



--QUESTION 111
--From the following table write a query in SQL to obtain the difference in sales quota values for a specified employee over subsequent calendar quarters. 
--Return year, quarter, sales quota, next sales quota, and the difference in sales quota. Sort the result set on year and then by quarter, both in ascending order.

SELECT YEAR(QuotaDate) AS year, DATEPART(quarter, quotadate)  AS quarter, SalesQuota,
LEAD(SalesQuota, 1, 0) OVER ( ORDER BY YEAR(QuotaDate), DATEPART(quarter, quotadate)) AS nextquota,
SalesQuota - LEAD(SalesQuota, 1, 0) OVER ( ORDER BY YEAR(QuotaDate), DATEPART(quarter, quotadate)) AS diff
FROM Sales.SalesPersonQuotaHistory
WHERE businessentityid = 277 AND YEAR(QuotaDate) IN (2012,2013)  
ORDER BY YEAR(QuotaDate), DATEPART(quarter, quotadate);



--QUESTION 112
--From the following table write a query in SQL to compute the salary percentile for each employee within a given department. 
--Return Department, LastName, Rate, CumeDist, and percentile rank. Sort the result set in ascending order on department and descending order on rate.

SELECT v.department, v.LastName, e.rate,
CUME_DIST() OVER (PARTITION BY v.department ORDER BY e.rate) AS CumeDist,
PERCENT_RANK() OVER (PARTITION BY v.department ORDER BY e.rate) AS PercRank
FROM HumanResources.vEmployeeDepartmentHistory v
INNER JOIN HumanResources.EmployeePayHistory e
	ON v.BusinessEntityID = e.BusinessEntityID
ORDER BY v.Department, e.Rate;



--QUESTION 113
--From the following table write a query in SQL to add two days to each value in the OrderDate column, to derive a new column named PromisedShipDate. 
--Return salesorderid, orderdate, and promisedshipdate column.

SELECT SalesOrderID, OrderDate, DATEADD(DAY , 2, OrderDate) AS promisedshipdate
FROM Sales.SalesOrderHeader;



--QUESTION 114
--From the following table write a query in SQL to obtain a newdate by adding two days with current date for each salespersons. 
--Filter the result set for those salespersons whose sales value is more than zero.

SELECT p.FirstName, p.LastName, DATEADD(DAY , 2, GETDATE()) AS 'New Date' 
FROM Sales.SalesPerson s
INNER JOIN Person.Person p
	ON s.BusinessEntityID = p.BusinessEntityID
INNER JOIN Person.Address a
	ON p.BusinessEntityID = a.AddressID
WHERE s.SalesQuota IS NOT NULL;



--QUESTION 115
--From the following table write a query in SQL to find the differences between the maximum and minimum orderdate.

SELECT DATEDIFF(DAY, MIN(ORDERDATE), MAX(ORDERDATE)) AS difference 
FROM Sales.SalesOrderHeader;



--QUESTION 116
--From the following table write a query in SQL to rank the products in inventory, by the specified inventory locations, according to their quantities. 
--Divide the result set by LocationID and sort the result set on Quantity in descending order.

SELECT i.ProductID, p.Name, i.LocationID,i.Quantity, DENSE_RANK() OVER (PARTITION BY I.LOCATIONID ORDER BY i.quantity DESC) AS quantrank
FROM Production.ProductInventory i
INNER JOIN Production.Product p
	ON p.ProductID = i.ProductID
WHERE i.LocationID IN (3, 4)
ORDER BY I.LOCATIONID;



--QUESTION 117
--From the following table write a query in SQL to return the top ten employees ranked by their salary.

SELECT TOP 10 BusinessEntityID, Rate, DENSE_RANK() OVER (ORDER BY rate DESC) AS rankbysalary
FROM HumanResources.EmployeePayHistory;



--QUESTION 118
--From the following table write a query in SQL to divide rows into four groups of employees based on their year-to-date sales. 
--Return first name, last name, group as quartile, year-to-date sales, and postal code.

SELECT p.FirstName, p.LastName, NTILE(4) OVER (ORDER BY s.SalesYTD DESC) AS quartile, s.SalesYTD, a.PostalCode
FROM Sales.SalesPerson s
INNER JOIN Person.Person p
	ON s.BusinessEntityID = p.BusinessEntityID
INNER JOIN Person.Address a
	ON p.BusinessEntityID = a.AddressID;



--QUESTION 119
--From the following tables write a query in SQL to rank the products in inventory the specified inventory locations according to their quantities. 
--The result set is partitioned by LocationID and logically ordered by Quantity. Return productid, name, locationid, quantity, and rank.

SELECT i.ProductID, p.Name, i.LocationID, i.Quantity,
RANK() OVER (PARTITION BY I.LOCATIONID ORDER BY i.quantity DESC) AS rank
FROM Production.ProductInventory i
INNER JOIN Production.Product p
	ON i.ProductID = p.ProductID
WHERE i.LocationID IN (3, 4);



--QUESTION 120
--From the following table write a query in SQL to find the salary of top ten employees. Return BusinessEntityID, Rate, and rank of employees by salary.

SELECT TOP 10 BusinessEntityID, Rate, RANK() OVER ( ORDER BY rate DESC) AS rankbysalary
FROM HumanResources.EmployeePayHistory e1
WHERE RateChangeDate = (SELECT MAX(RateChangeDate)   
                        FROM HumanResources.EmployeePayHistory AS e2  
                        WHERE e1.BusinessEntityID = e2.BusinessEntityID)  
ORDER BY BusinessEntityID;



--QUESTION 121
--From the following table write a query in SQL to calculate a row number for the salespeople based on their year-to-date sales ranking. 
--Return row number, first name, last name, and year-to-date sales.

SELECT ROW_NUMBER() OVER (ORDER BY salesytd DESC) AS row, firstname, lastname, salesytd
FROM Sales.vSalesPerson;



--QUESTION 122
--From the following table write a query in SQL to calculate row numbers for all rows between 50 to 60 inclusive. Sort the result set on orderdate.

WITH ordered AS 
	(SELECT SalesOrderID, OrderDate, ROW_NUMBER() OVER (ORDER BY salesorderid) AS rownumber
	FROM Sales.SalesOrderHeader)

SELECT SalesOrderID, OrderDate, rownumber
FROM ordered
WHERE rownumber BETWEEN 50 AND 60;



--QUESTION 123
--From the following table write a query in SQL to return first name, last name, territoryname, salesytd, and row number. Partition the query result set by the TerritoryName. 
--Orders the rows in each partition by SalesYTD. Sort the result set on territoryname in ascending order.

SELECT FirstName, LastName, TerritoryName, SalesYTD, ROW_NUMBER() OVER (PARTITION BY Territoryname ORDER BY salesytd) AS row 
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL;



--QUESTION 124
--From the following table write a query in SQL to order the result set by the column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows. 
--Return BusinessEntityID, LastName, TerritoryName, CountryRegionName.

SELECT BusinessEntityID, LastName, TerritoryName, CountryRegionName
FROM Sales.vSalesPerson
ORDER BY CASE
	WHEN CountryRegionName = 'United States' THEN TerritoryName 
	ELSE CountryRegionName END;



--QUESTION 125
--From the following tables write a query in SQL to return the highest hourly wage for each job title. 
--Restricts the titles to those that are held by men with a maximum pay rate greater than 40 dollars or women with a maximum pay rate greater than 42 dollars.

SELECT e.JobTitle, MAX(h.rate) AS maximumrate
FROM HumanResources.Employee e
INNER JOIN HumanResources.EmployeePayHistory h
	ON h.BusinessEntityID = e.BusinessEntityID 
GROUP BY E.JobTitle
HAVING MAX(CASE WHEN e.Gender = 'M'
	THEN h.rate 
	ELSE NULL END) > 40
OR MAX(CASE WHEN e.gender = 'F'
	THEN h.rate
	ELSE NULL END) > 42;



--QUESTION 126
--From the following table write a query in SQL to sort the BusinessEntityID in descending order for those employees that have the SalariedFlag set to 'true' and in ascending order that have the SalariedFlag set to 'false'. 
--Return BusinessEntityID, and SalariedFlag.

SELECT BusinessEntityID, SalariedFlag
FROM HumanResources.Employee
ORDER BY 
CASE WHEN SalariedFlag = 'true'
	THEN BusinessEntityID END
DESC,
	CASE WHEN SalariedFlag = 'false'
	THEN BusinessEntityID END;



--QUESTION 127
--From the following table write a query in SQL to display the list price as a text comment based on the price range for a product. 
--Return ProductNumber, Name, and listprice. Sort the result set on ProductNumber in ascending order.

SELECT ProductNumber, Name, ListPrice,

CASE 
	WHEN listprice = 0 THEN 'Mfg item - not for resale'
	WHEN listprice < 50 THEN 'Under $50 '
	WHEN listprice >=50 AND  listprice < 250 THEN 'Under $250'
	WHEN listprice >=250 AND  listprice < 1000 THEN 'Under $1000' END AS 'Price Range'

FROM Production.Product
ORDER BY productnumber;



--QUESTION 128
--From the following table write a query in SQL to change the display of product line categories to make them more understandable. 
--Return ProductNumber, category, and name of the product. Sort the result set in ascending order on ProductNumber.

SELECT ProductNumber, 
CASE 
	WHEN listprice = 0 THEN 'Not for sale'
	WHEN name LIKE '%Mountain%' THEN 'Mountain'
	WHEN name LIKE '%Road%' THEN 'Road' END AS 'category',
	Name
FROM Production.Product
ORDER BY productnumber;



--QUESTION 129
--From the following table write a query in SQL to evaluate whether the values in the MakeFlag and FinishedGoodsFlag columns are the same.

SELECT ProductID, MakeFlag, FinishedGoodsFlag,
CASE
	WHEN MakeFlag = FinishedGoodsFlag THEN NULL
	ELSE MakeFlag
	END AS makeflag
FROM Production.Product;



--QUESTION 130
--From the following table write a query in SQL to select the data from the first column that has a nonnull value. Retrun Name, Class, Color, ProductNumber, and FirstNotNull.

SELECT Name, Class, Color, ProductNumber, 
COALESCE(Class, Color, ProductNumber) AS FirstNonNullValue

FROM Production.Product;



--QUESTION 131
--From the following table write a query in SQL to check the values of MakeFlag and FinishedGoodsFlag columns and return whether they are same or not. 
--Return ProductID, MakeFlag, FinishedGoodsFlag, and the column that are null or not null.

SELECT ProductID, MakeFlag, FinishedGoodsFlag, 
CASE
	WHEN MakeFlag <> FinishedGoodsFlag THEN 1
	ELSE NULL END AS 'Null if  equal'
FROM Production.Product;

--OR

SELECT ProductID, MakeFlag, FinishedGoodsFlag,   
   NULLIF(MakeFlag,FinishedGoodsFlag) AS 'Null if Equal'
FROM Production.Product;



--QUESTION 132
--From the following tables write a query in SQL to return any distinct values that are returned by both the query.

SELECT ProductID
FROM Production.Product
INTERSECT
SELECT ProductID
FROM production.workorder;



--QUESTION 133
--From the following tables write a query in SQL to return any distinct values from first query that aren't also found on the 2nd query.

SELECT ProductID
FROM Production.Product
EXCEPT
SELECT ProductID
FROM production.workorder;



--QUESTION 134
--From the following tables write a query in SQL to fetch any distinct values from the left query that aren't also present in the query to the right.

SELECT ProductID   
FROM Production.WorkOrder  
EXCEPT  
SELECT ProductID   
FROM Production.Product;



--QUESTION 135
--From the following tables write a query in SQL to fetch distinct businessentityid that are returned by both the specified query. 
--Sort the result set by ascending order on businessentityid.

SELECT businessentityid   
FROM person.businessentity    
INTERSECT   
SELECT businessentityid   
FROM person.person
ORDER BY businessentityid;



--QUESTION 136
--From the following table write a query which is the combination of two queries. 
--Return any distinct businessentityid from the 1st query that aren't also found in the 2nd query. 
--Sort the result set in ascending order on businessentityid.

SELECT businessentityid
FROM Person.BusinessEntity
EXCEPT
SELECT businessentityid
FROM Person.Person
ORDER BY businessentityid;



--QUESTION 137
--From the following tables write a query in SQL to combine the ProductModelID and Name columns. 
--A result set includes columns for productid 3 and 4. Sort the results by name ascending.

SELECT ProductModelID, name
FROM Production.ProductModel  
UNION   
SELECT productid, name  
FROM Production.Product
WHERE productid IN (3,4)
ORDER BY name;



--QUESTION 138
--From the following table write a query in SQL to find a total number of hours away from work can be calculated by adding vacation time and sick leave. 
--Sort results ascending by Total Hours Away.

SELECT p.FirstName, p.LastName, h.VacationHours, h.SickLeaveHours, h.VacationHours + h.SickLeaveHours AS 'Total Hours Away'
FROM HumanResources.Employee h
INNER JOIN Person.Person p
	ON p.BusinessEntityID = h.BusinessEntityID
ORDER BY 'Total Hours Away';



--QUESTION 139
--From the following table write a query in SQL to calculate the tax difference between the highest and lowest tax-rate state or province.

SELECT MAX(taxrate) - MIN(taxrate) AS 'Tax Rate Difference'
FROM Sales.SalesTaxRate;



--QUESTION 140
--From the following tables write a query in SQL to calculate sales targets per month for salespeople.

SELECT p.BusinessEntityID, p.FirstName, p.LastName, s.SalesQuota, s.SalesQuota/12 AS 'Sales Target Per Month'
FROM Sales.SalesPerson s
INNER JOIN HumanResources.Employee e 
	ON s.BusinessEntityID = e.BusinessEntityID
INNER JOIN Person.Person p
	ON p.BusinessEntityID = e.BusinessEntityID;



--QUESTION 141
--From the following table write a query in SQL to return the ID number, unit price, and the modulus (remainder) of dividing product prices. Convert the modulo to an integer value.

SELECT ProductID, UnitPrice, OrderQty, CAST(unitprice AS INT) % OrderQty AS modulo
FROM  Sales.SalesOrderDetail;



--QUESTION 142
--From the following table write a query in SQL to select employees who have the title of Marketing Assistant and more than 41 vacation hours.

SELECT BusinessEntityID, LoginID, JobTitle, VacationHours
FROM HumanResources.Employee
WHERE JobTitle = 'Marketing Assistant' AND VacationHours > 41;



--QUESTION 143
--From the following tables write a query in SQL to find all rows outside a specified range of rate between 27 and 30. Sort the result in ascending order on rate.

SELECT e.FirstName, e.LastName, p.rate
FROM HumanResources.vEmployee e
INNER JOIN HumanResources.EmployeePayHistory p
	ON e.BusinessEntityID = p.BusinessEntityID
WHERE p.Rate NOT BETWEEN 27 AND 30
ORDER BY p.Rate;



--QUESTION 144
--From the follwing table write a query in SQL to retrieve rows whose datetime values are between '20111212' and '20120105'.

SELECT BusinessEntityID, RateChangeDate
FROM HumanResources.EmployeePayHistory
WHERE RateChangeDate BETWEEN '2011-12-12' AND '2012-01-05';



--QUESTION 145
--From the following table write a query in SQL to return TRUE even if NULL is specified in the subquery. 
--Return DepartmentID, Name and sort the result set in ascending order.

SELECT DepartmentID, Name
FROM HumanResources.Department
WHERE EXISTS (SELECT NULL)
ORDER BY name;



--QUESTION 146
--From the following tables write a query in SQL to get employees with Johnson last names. Return first name and last name.

SELECT FirstName, LastName
FROM Person.Person p
INNER JOIN HumanResources.Employee e
	ON p.BusinessEntityID = e.BusinessEntityID
WHERE LastName = 'Johnson';



--QUESTION 147
--From the following tables write a query in SQL to find stores whose name is the same name as a vendor.

SELECT s.name
FROM Sales.Store s
INNER JOIN Purchasing.Vendor v
	ON s.name = v.name;



--QUESTION 148
--From the following tables write a query in SQL to find employees of departments that start with P. Return first name, last name, job title.

SELECT p.FirstName, p.LastName, h.JobTitle
FROM Person.Person p
INNER JOIN HumanResources.Employee h
	ON h.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory e
	ON e.BusinessEntityID = h.BusinessEntityID
INNER JOIN HumanResources.Department d
	ON d.DepartmentID = e.DepartmentID
WHERE d.Name LIKE 'P%';



--QUESTION 149
--From the following tables write a query in SQL to find all employees that do not belong to departments whose names begin with P.

SELECT p.FirstName, p.LastName, h.JobTitle
FROM Person.Person p 
INNER JOIN HumanResources.Employee h
	ON h.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory e
	ON e.BusinessEntityID = h.BusinessEntityID
INNER JOIN HumanResources.Department d
	ON d.DepartmentID = e.DepartmentID
WHERE d.Name NOT LIKE 'P%'
ORDER BY p.LastName;



--QUESTION 150
--From the following table write a query in SQL to select employees who work as design engineers, tool designers, or marketing assistants.

SELECT p.FirstName, p.LastName, h.JobTitle
FROM Person.Person p 
INNER JOIN HumanResources.Employee h
	ON h.BusinessEntityID = p.BusinessEntityID
WHERE h.JobTitle IN ('Design Engineer', 'Tool Designer', 'Marketing Assistant');



--QUESTION 151
--From the following tables write a query in SQL to identify all SalesPerson IDs for employees with sales quotas over $250,000. 
--Return first name, last name of the sales persons.

SELECT p.FirstName, p.LastName
FROM Person.Person p 
INNER JOIN Sales.SalesPerson s 
	ON s.BusinessEntityID = p.BusinessEntityID
WHERE s.SalesQuota > 250000;



--QUESTION 152
--From the following tables write a query in SQL to find the salespersons who do not have a quota greater than $250,000. Return first name and last name.

SELECT p.firstname, p.LastName
FROM Person.Person p
JOIN Sales.SalesPerson s
	ON p.BusinessEntityID = s.BusinessEntityID
WHERE s.SalesQuota <= 250000;



--QUESTION 153
--From the following tables write a query in SQL to identify salesorderheadersalesreason and SalesReason tables with the same salesreasonid.

SELECT * FROM sales.salesorderheadersalesreason  
WHERE salesreasonid   
IN (SELECT salesreasonid  FROM sales.SalesReason);



--QUESTION 154
--From the following table write a query in SQL to find all telephone numbers that have area code 415. 
--Returns the first name, last name, and phonenumber. Sort the result set in ascending order by lastname.

SELECT pe.FirstName, pe.LastName, ph.PhoneNumber
FROM Person.Person pe
INNER JOIN Person.PersonPhone ph
	ON pe.BusinessEntityID = ph.BusinessEntityID
WHERE ph.PhoneNumber LIKE '415%'
ORDER BY pe.LastName;



--QUESTION 155
--From the following tables write a query in SQL to identify all people with the first name 'Gail' with area codes other than 415. 
--Return first name, last name, telephone number. Sort the result set in ascending order on lastname.

SELECT pe.FirstName, pe.LastName, ph.PhoneNumber
FROM Person.Person pe
INNER JOIN Person.PersonPhone ph
	ON pe.BusinessEntityID = ph.BusinessEntityID
WHERE ph.PhoneNumber NOT LIKE '415%' AND pe.FirstName = 'Gail'
ORDER BY pe.LastName;



--QUESTION 156
--From the following tables write a query in SQL to find all Silver colored bicycles with a standard price under $400. Return ProductID, Name, Color, StandardCost.

SELECT ProductID, name, color, StandardCost
FROM Production.Product
WHERE ProductNumber LIKE 'BK-%' AND color = 'Silver' AND StandardCost < 400; 



--QUESTION 157
--From the following table write a query in SQL to retrieve the names of Quality Assurance personnel working the evening or night shifts. 
--Return first name, last name, shift.

SELECT FirstName, LastName, Shift
FROM HumanResources.vEmployeeDepartmentHistory 
WHERE Shift NOT IN ('Day')  AND Department = 'Quality Assurance';



--QUESTION 158
--From the following table write a query in SQL to list all people with three-letter first names ending in 'an'. 
--Sort the result set in ascending order on first name. Return first name and last name.

SELECT FirstName, LastName
FROM Person.Person
WHERE FirstName LIKE '_an';



--QUESTION 159
--From the following table write a query in SQL to convert the order date in the 'America/Denver' time zone. 
--Return salesorderid, order date, and orderdate_timezoneade.

SELECT SalesOrderID, OrderDate, OrderDate AT TIME ZONE 'Mountain Standard Time' AS orderdate_timezoneade
FROM Sales.SalesOrderHeader;



--QUESTION 160
--From the following table write a query in SQL to convert order date in the 'America/Denver' time zone and also convert from 'America/Denver' time zone to 'America/Chicago' time zone.

SELECT SalesOrderID, OrderDate, 
OrderDate AT TIME ZONE 'Mountain Standard Time' AS orderdate_timezoneamden , 
OrderDate AT TIME ZONE 'Mountain Standard Time' AT TIME ZONE 'Central Standard Time' AS orderdate_timezoneamchi
FROM Sales.SalesOrderHeader;



--QUESTION 161
--From the following table wirte a query in SQL to search for rows with the 'green_' character in the LargePhotoFileName column. Return all columns.

SELECT *
FROM Production.ProductPhoto
WHERE ThumbnailPhotoFileName LIKE '%greena_%' ESCAPE 'a';



--QUESTION 162
--From the following tables write a query in SQL to obtain mailing addresses for companies in cities that begin with PA, outside the United States (US). 
--Return AddressLine1, AddressLine2, City, PostalCode, CountryRegionCode.

SELECT a.AddressLine1, a.AddressLine2, a.City, a.PostalCode, s.CountryRegionCode
FROM Person.Address a
JOIN Person.StateProvince s
ON s.stateprovinceid = a.stateprovinceid
WHERE a.City LIKE 'Pa%' AND s.CountryRegionCode NOT LIKE 'US';



--QUESTION 163
--From the following table write a query in SQL to specify that a JOIN clause can join multiple values. Return ProductID, product Name, and Color.

SELECT ProductID, a.Name, Color  
FROM Production.Product AS a  
INNER JOIN (VALUES ('Blade'), ('Crown Race'), ('AWC Logo Cap')) AS b(Name)   
ON a.Name = b.Name;



--QUESTION 164
--From the following table write a query in SQL to find the SalesPersonID, salesyear, totalsales, salesquotayear, salesquota, and amt_above_or_below_quota columns. 
--Sort the result set in ascending order on SalesPersonID, and SalesYear columns.

WITH Sales_CTE (SalesPersonID, TotalSales, SalesYear)
AS
(SELECT SalesPersonID, SUM(TotalDue) AS TotalSales, YEAR(OrderDate) AS SalesYear
 FROM Sales.SalesOrderHeader
 WHERE SalesPersonID IS NOT NULL
 GROUP BY SalesPersonID, YEAR(OrderDate)
),
Sales_Quota_CTE (BusinessEntityID, SalesQuota, SalesQuotaYear)
AS
(
       SELECT BusinessEntityID, SUM(SalesQuota)AS SalesQuota, YEAR(SalesYear) AS SalesQuotaYear
       FROM Sales.SalesPersonQuotaHistory
       GROUP BY BusinessEntityID, YEAR(SalesYear)
)
SELECT SalesPersonID
  , SalesYear
  , CAST(TotalSales as VARCHAR(10)) AS TotalSales
  , SalesQuotaYear
  , CAST(TotalSales as VARCHAR(10)) AS SalesQuota
  , CAST (TotalSales -SalesQuota as VARCHAR(10)) AS Amt_Above_or_Below_Quota
FROM Sales_CTE
JOIN Sales_Quota_CTE ON Sales_Quota_CTE.BusinessEntityID = Sales_CTE.SalesPersonID
                    AND Sales_CTE.SalesYear = Sales_Quota_CTE.SalesQuotaYear
ORDER BY SalesPersonID, SalesYear;



--QUESTION 165
--From the following tables write a query in SQL to return the cross product of BusinessEntityID and Department columns.
--The following example returns the cross product of the two tables Employee and Department in the AdventureWorks2019 database. 
--A list of all possible combinations of BusinessEntityID rows and all Department name rows are returned.

SELECT BusinessEntityID, Name
FROM HumanResources.Employee
CROSS JOIN HumanResources.Department
ORDER BY BusinessEntityID, Name;



--QUESTION 166
--From the following tables write a query in SQL to return the SalesOrderNumber, ProductKey, and EnglishProductName columns.

SELECT s.SalesOrderID, p.ProductID, p.name 
FROM Sales.SalesOrderDetail s
JOIN Production.Product p
	ON s.ProductID = p.ProductID;



--QUESTION 167
--From the following tables write a query in SQL to return all orders with IDs greater than 60000.

SELECT S.SalesOrderID, s.ProductID, p.name
FROM Sales.SalesOrderDetail s
JOIN Production.Product p
	ON s.ProductID = p.ProductID
WHERE salesorderid > 60000
ORDER BY SalesOrderID;



--QUESTION 168
--From the following tables write a query in SQL to retrieve the SalesOrderid. A NULL is returned if no orders exist for a particular Territoryid. 
--Return territoryid, countryregioncode, and salesorderid. Results are sorted by SalesOrderid, so that NULLs appear at the top.

SELECT st.territoryid, st.countryregioncode, so.SalesOrderID
FROM sales.salesterritory st
LEFT OUTER JOIN sales.salesorderheader so
	ON  st.territoryid = so.territoryid;



--QUESTION 169
--From the following table write a query in SQL to return all rows from both joined tables but returns NULL for values that do not match from the other table. 
--Return territoryid, countryregioncode, and salesorderid. Results are sorted by SalesOrderid.

SELECT st.territoryid, st.countryregioncode, so.SalesOrderID
FROM sales.salesterritory st
FULL OUTER JOIN sales.salesorderheader so
	ON  st.territoryid = so.territoryid;



--QUESTION 170
--From the following tables write a query in SQL to return a cross-product. Order the result set by SalesOrderid.

SELECT st.territoryid, so.SalesOrderID
FROM sales.salesterritory st
CROSS JOIN sales.salesorderheader so
ORDER BY so.SalesOrderID;



--QUESTION 171
--From the following table write a query in SQL to return all customers with BirthDate values after January 1, 1970 and the last name 'Smith'. 
--Return businessentityid, jobtitle, and birthdate. Sort the result set in ascending order on birthday.

SELECT e.BusinessEntityID, e.JobTitle, e.BirthDate
FROM HumanResources.Employee e
JOIN Person.Person p
	ON e.BusinessEntityID = p.BusinessEntityID
WHERE BirthDate > '1970-01-01' AND p.LastName = 'Smith'
ORDER BY BirthDate ASC;



--QUESTION 172
--From the following table write a query in SQL to return the rows with different firstname values from Adam. 
--Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.

SELECT BusinessEntityID, PersonType, FirstName, MiddleName, LastName
FROM Person.Person 
WHERE FirstName != 'Adam'
ORDER BY FirstName;

--OR

SELECT BusinessEntityID, PersonType, FirstName, MiddleName, LastName
FROM Person.Person 
WHERE FirstName IS DISTINCT FROM 'Adam'
ORDER BY FirstName;



--QUESTION 173
--From the following table write a query in SQL to find the rows where firstname doesn't differ from Adam's firstname. 
--Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.


SELECT BusinessEntityID, PersonType, FirstName, MiddleName, LastName
FROM Person.Person
WHERE FirstName = 'Adam'
ORDER BY FirstName;

--OR

SELECT BusinessEntityID, PersonType, FirstName, MiddleName, LastName
FROM Person.Person
WHERE Firstname IS NOT DISTINCT FROM 'Adam'
ORDER BY FirstName;



--QUESTION 174
--From the following table write a query in SQL to find the rows where middlename differs from NULL. 
--Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.

SELECT BusinessEntityID, PersonType, FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName IS NOT NULL
ORDER BY FirstName;

--OR

SELECT BusinessEntityID, PersonType, FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName IS DISTINCT FROM NULL
ORDER BY FirstName;



--QUESTION 175
--From the following table write a query in SQL to identify the rows with a middlename that is not NULL. 
--Return businessentityid, persontype, firstname, middlename,and lastname. Sort the result set in ascending order on firstname.

SELECT BusinessEntityID, PersonType, FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName IS  NULL
ORDER BY FirstName;

--OR

SELECT BusinessEntityID, PersonType, FirstName, MiddleName, LastName
FROM Person.Person
WHERE MiddleName IS NOT DISTINCT FROM NULL
ORDER BY FirstName;



--QUESTION 176
--From the following table write a query in SQL to fetch all products with a weight of less than 10 pounds or unknown color. 
--Return the name, weight, and color for the product. Sort the result set in ascending order on name.

SELECT Name, Weight, Color
FROM Production.Product
WHERE Weight < 10 OR COLOR IS NULL
ORDER BY name;



--QUESTION 177
--From the following table write a query in SQL to list the salesperson whose salesytd begins with 1. Convert SalesYTD and current date in text format.

SELECT BusinessEntityID, SalesYTD, 
	CONVERT(VARCHAR, salesYTD) AS moneydisplaystyle1, 
	CURRENT_TIMESTAMP AS currenttime, 
	CONVERT(VARCHAR, CURRENT_TIMESTAMP) AS datedisplaystyle3
FROM Sales.SalesPerson
WHERE CONVERT(VARCHAR, salesYTD) LIKE '1%';



--QUESTION 178
--From the following table write a query in SQL to return the count of employees by Name and Title, Name, and company total. 
--Filter the results by department ID 12 or 14. For each row, identify its aggregation level in the Title column.

SELECT D.Name,
	CASE   
    WHEN GROUPING(D.Name, E.JobTitle) = 0 THEN E.JobTitle  
    WHEN GROUPING(D.Name, E.JobTitle) = 1 THEN concat('Total :',d.name) 
    WHEN GROUPING(D.Name, E.JobTitle) = 3 THEN 'Company Total:'  
        ELSE 'Unknown'  
    END AS "Job Title" , 
    COUNT(E.BusinessEntityID) AS "Employee Count"  
FROM HumanResources.Employee E  
INNER JOIN HumanResources.EmployeeDepartmentHistory DH  
    ON E.BusinessEntityID = DH.BusinessEntityID  
INNER JOIN HumanResources.Department D  
    ON D.DepartmentID = DH.DepartmentID       
WHERE DH.EndDate IS NULL AND D.DepartmentID IN (12,14)  
GROUP BY ROLLUP(D.Name, E.JobTitle);



--QUESTION 179
--From the following tables write a query in SQL to return only rows with a count of employees by department. 
--Filter the results by department ID 12 or 14. Return name, jobtitle, grouping level and employee count.

SELECT D.Name  
    ,E.JobTitle  
    ,GROUPING(D.Name, E.JobTitle) AS "Grouping Level"  
    ,COUNT(E.BusinessEntityID) AS "Employee Count"  
FROM HumanResources.Employee AS E  
    INNER JOIN HumanResources.EmployeeDepartmentHistory AS DH  
        ON E.BusinessEntityID = DH.BusinessEntityID  
    INNER JOIN HumanResources.Department AS D  
        ON D.DepartmentID = DH.DepartmentID       
WHERE DH.EndDate IS NULL  
    AND D.DepartmentID IN (12,14)  
GROUP BY ROLLUP(D.Name, E.JobTitle)
HAVING GROUPING(D.Name, E.JobTitle) = 1;



--QUESTION 180
-- From the following tables write a query in SQL to return only the rows that have a count of employees by title. 
--Filter the results by department ID 12 or 14. Return name, jobtitle, grouping level and employee count.

SELECT D.Name,
    E.JobTitle,
    GROUPING(D.Name, E.JobTitle) AS "Grouping Level",
    COUNT(E.BusinessEntityID) AS "Employee Count"  
FROM HumanResources.Employee AS E  
INNER JOIN HumanResources.EmployeeDepartmentHistory AS DH  
    ON E.BusinessEntityID = DH.BusinessEntityID  
INNER JOIN HumanResources.Department AS D  
    ON D.DepartmentID = DH.DepartmentID       
WHERE DH.EndDate IS NULL  
    AND D.DepartmentID IN (12,14)  
GROUP BY ROLLUP(D.Name, E.JobTitle)
HAVING GROUPING(D.Name, E.JobTitle) = 0;



--QUESTION 181
--From the following table write a query in SQL to return the difference in sales quotas for a specific employee over previous calendar quarters. 
--Sort the results by salesperson with businessentity id 277 and quotadate year 2012 or 2013.

SELECT quotadate AS year, 
datepart(QUARTER, quotadate) AS quarter, 
SalesQuota, 
LAG(salesquota) OVER (ORDER BY  YEAR(quotadate),datepart(QUARTER, quotadate)) AS previousquota, 
SalesQuota - LAG(salesquota) OVER (ORDER BY  YEAR(quotadate),datepart(QUARTER, quotadate)) AS diff
FROM Sales.SalesPersonQuotaHistory
WHERE YEAR(salesquota) IN (2012, 2013) AND BusinessEntityID = 277;



--QUESTION 182
--From the following table write a query in SQL to return a truncated date with 4 months added to the orderdate.

SELECT orderdate, DATEADD(MONTH, 4, orderdate) AS year
FROM Sales.SalesOrderHeader;



--QUESTION 183
--From the following table write a query in SQL to return the orders that have sales on or after December 2011. 
--Return salesorderid, MonthOrderOccurred, salespersonid, customerid, subtotal, Running Total, and actual order date.

SELECT salesorderid,  DATEPART(MONTH, orderdate) AS MonthOrderOccurred, salespersonid, customerid, subtotal, 
SUM(subtotal) OVER (PARTITION BY customerid ORDER BY orderdate,
salesorderid ROWS UNBOUNDED PRECEDING) AS RunningTotal,
orderdate AS actualorderDate
FROM Sales.SalesOrderHeader
WHERE salespersonid IS NOT NULL;



--QUESTION 184
--From the following table write a query in SQL to repeat the 0 character four times before productnumber. 
--Return name, productnumber and newly created productnumber.

SELECT name, ProductNumber, CONCAT('000', ProductNumber) AS fullproductnumber
FROM Production.Product



--QUESTION 185
--From the following table write a query in SQL to find all special offers. 
--When the maximum quantity for a special offer is NULL, return MaxQty as zero.

SELECT Description, DiscountPct, minqty, ISNULL(MAXQTY, 0) AS 'Max qty'
FROM Sales.SpecialOffer;



--QUESTION 186
--From the following table write a query in SQL to find all products that have NULL in the weight column. Return name and weight.

SELECT name, weight
FROM Production.Product
WHERE weight IS NULL;



--QUESTION 187
--From the following table write a query in SQL to find the data from the first column that has a non-null value. 
--Return name, color, productnumber, and firstnotnull column.

SELECT name, color, ProductNumber, 
	CASE
		WHEN color IS NOT NULL THEN color
		WHEN ProductNumber IS NOT NULL THEN ProductNumber
		ELSE NULL
	END AS firstnotnull
FROM Production.Product;



--QUESTION 188
--From the following tables write a query in SQL to return rows only when both the productid and startdate values in the two tables matches.

SELECT a.productid, a.startdate 
FROM production.workorder AS a  
WHERE EXISTS  
(SELECT * FROM production.workorderrouting  AS b  
    WHERE (a.productid = b.productid and a.startdate=b.actualstartdate));



--QUESTION 189
--From the following tables write a query in SQL to return rows except both the productid and startdate values in the two tables matches.

SELECT ProductID, StartDate
FROM Production.WorkOrder o
WHERE NOT EXISTS 
(SELECT * FROM production.workorderrouting r
	WHERE (o.productid = R.productid and O.startdate = R.actualstartdate));



--QUESTION 190
--From the following table write a query in SQL to find all creditcardapprovalcodes starting with 1 and the third digit is 6. 
--Sort the result set in ascending order on orderdate.

SELECT SalesOrderID, OrderDate, CreditCardApprovalCode
FROM Sales.SalesOrderHeader
WHERE CreditCardApprovalCode LIKE '1_6%'
ORDER BY OrderDate;



--QUESTION 191
--From the following table write a query in SQL to concatenate character and date data types for the order ID 50001.

SELECT CONCAT('The order is due on ', CAST(DueDate AS VARCHAR(12))) AS concat
FROM Sales.SalesOrderHeader
WHERE SalesOrderID = 50001;



--QUESTION 192
--From the following table write a query in SQL to form one long string to display the last name and the first initial of the vice presidents. 
--Sort the result set in ascending order on lastname.

SELECT CONCAT(p.LastName, ', ', LEFT(p.firstname, 1), '.') AS name, e.jobtitle 
FROM HumanResources.Employee E
INNER JOIN person.person P
ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.JobTitle LIKE 'Vice%'
ORDER BY p.LastName ASC;



--QUESTION 193
--From the following table write a query in SQL to return only the rows for Product that have a product line of R and that have days to manufacture that is less than 4. 
--Sort the result set in ascending order on name.

SELECT name, ProductNumber, ListPrice
FROM Production.Product
WHERE ProductLine = 'R'
	AND daystomanufacture < 4
ORDER BY name;



--QUESTION 194
--From the following tables write a query in SQL to return total sales and the discounts for each product. 
--Sort the result set in descending order on productname.

SELECT name AS productname, 
s.OrderQty*s.UnitPrice AS nondiscountsales, 
s.OrderQty*s.UnitPrice*s.UnitPriceDiscount AS discounts
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail s
ON p.ProductID = s.ProductID
ORDER BY productname DESC;



--QUESTION 195
--From the following tables write a query in SQL to calculate the revenue for each product in each sales order. 
--Sort the result set in ascending order on productname.

SELECT 'Total income is', s.unitprice*s.orderqty, 'for', p.name
FROM Production.Product p
INNER JOIN sales.SalesOrderDetail s
ON s.ProductID =p.ProductID
ORDER BY p.Name;



--QUESTION 196
--From the following tables write a query in SQL to retrieve one instance of each product name whose product model is a long sleeve logo jersey, 
--and the ProductModelID numbers match between the tables.

SELECT p.name
FROM Production.Product p
INNER JOIN Production.ProductModel m
ON m.ProductModelID = p.ProductModelID
WHERE p.name LIKE 'Long-Sleeve Logo Jersey%';



--QUESTION 197
--From the following tables write a query in SQL to retrieve the first and last name of each employee whose bonus in the SalesPerson table is 5000.

SELECT p.FirstName, p.LastName
FROM Person.Person p
INNER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID
INNER JOIN Sales.SalesPerson s
ON s.BusinessEntityID = p.BusinessEntityID
WHERE s.bonus = 5000;



--QUESTION 198
--From the following table write a query in SQL to find product models where the maximum list price is more than twice the average.

SELECT ProductModelID
FROM Production.Product
GROUP BY ProductModelID
HAVING MAX(listprice) > AVG(ListPrice)*2;



--QUESTION 199
--From the following table write a query in SQL to find the names of employees who have sold a particular product.

SELECT DISTINCT p.LastName, p.FirstName
FROM Person.Person p
INNER JOIN sales.SalesOrderHeader h
	ON p.BusinessEntityID = h.SalesPersonID
INNER JOIN Sales.SalesOrderDetail d
	ON h.SalesOrderID = d.SalesOrderID
INNER JOIN Production.Product pr
	ON pr.ProductID = d.ProductID
WHERE ProductNumber = 'BK-M68B-42';

