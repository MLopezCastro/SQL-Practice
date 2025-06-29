--📘 PLAN DE PRÁCTICA DE JOINS (AdventureWorks2022)

--🟢 Nivel 1 – JOIN entre 2 tablas
--1. Detalle de órdenes con fecha

SELECT TOP 1 * FROM Sales.SalesOrderDetail

SELECT TOP 1 * FROM Sales.SalesOrderHeader

SELECT SOD.ProductID, SOD.LineTotal, SOH.OrderDate, SOH.DueDate, SOH.ShipDate
FROM Sales.SalesOrderDetail SOD
INNER JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID

--2. Producto + precio unitario + nombre

SELECT TOP 1 * FROM Production.Product
SELECT TOP 1 * FROM Sales.SalesOrderDetail

SELECT TOP 10 P.ProductID, P.Name, SOD.UnitPrice  
FROM Production.Product P
INNER JOIN Sales.SalesOrderDetail SOD ON P.ProductID = SOD.ProductID
 

--🎯 EJERCICIO CLÁSICO DE 3 TABLAS: Clientes + Órdenes + Nombres
--Querés saber:
--Qué clientes hicieron compras
--Cuánto gastaron
--Y ver su nombre completo

--🧩 ¿QUÉ TABLAS NECESITÁS?
--1. Sales.SalesOrderHeader
--2. Sales.Customer
--3. Person.Person

SELECT TOP 1 * FROM Sales.SalesOrderHeader

SELECT TOP 1 * FROM Sales.Customer
SELECT TOP 1 * FROM Person.Person

--primero uno Sales.Customer y Person.Person (porque hay nulls en Sales.Customer.PersonID:

SELECT C.CustomerID, P.FirstName, P.LastName
FROM Sales.Customer C
INNER JOIN Person.Person P ON C.PersonID = P.BusinessEntityID
WHERE c.PersonID IS NOT NULL

--luego, hago el join con Sales.SalesOrderHeader

SELECT C.CustomerID, P.FirstName, P.LastName, SUM(SOH.TotalDue) AS TotalSpent
FROM Sales.Customer C
JOIN Person.Person P ON C.PersonID = P.BusinessEntityID
JOIN Sales.SalesOrderHeader SOH ON SOH.CustomerID = C.CustomerID
WHERE c.PersonID IS NOT NULL
GROUP BY C.CustomerID, P.FirstName, P.LastName
ORDER BY TotalSpent DESC;

--IMPORTANTE: Cuando usás SUM() en SELECT, tenés que agrupar (GROUP BY) todas las columnas que no están dentro de funciones agregadas.

---
--🧠 ¿Qué queremos saber?
--"¿Cuáles son los productos más vendidos por cantidad total?

SELECT TOP 1 * FROM Production.Product
SELECT TOP 1 * FROM Sales.SalesOrderDetail

SELECT P.Name, SUM(S.OrderQty) AS QuantitySold, SUM(S.LineTotal) AS Total$
FROM Production.Product P 
JOIN Sales.SalesOrderDetail S ON P.ProductID = S.ProductID
GROUP BY P.Name
ORDER BY [Total$] DESC;

----
SELECT TOP 1 * FROM Sales.SalesOrderDetail
--Podés analizar cantidades vendidas, precio total, descuentos promedio, etc.:

SELECT SalesOrderID, SUM(OrderQty) AS Cantidad, CAST(SUM(LineTotal) AS DECIMAL(10,2)) AS Revenue, AVG(UnitPriceDiscount) AS AVGDesc
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING AVG(UnitPriceDiscount) > 0
ORDER BY Cantidad DESC;