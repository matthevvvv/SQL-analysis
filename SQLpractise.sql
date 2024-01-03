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