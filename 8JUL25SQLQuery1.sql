--✅ EJERCICIO 1 (Nivel 1)
--Consigna:
--Mostrá la cantidad de órdenes por cliente usando la tabla Sales.SalesOrderHeader.
--📌 Tabla: Sales.SalesOrderHeader
--📌 Campos útiles:
--CustomerID
--SalesOrderID (cada orden)
--📤 Tu tarea:
--Escribí una consulta que:
--Agrupe por CustomerID
--Cuente la cantidad de órdenes (SalesOrderID)
--Ordene de mayor a menor

SELECT TOP 1 * 
FROM sales.salesorderHeader;

SELECT CustomerID, COUNT(SalesOrderID) AS CantidadOrdenes
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CantidadOrdenes DESC;

--✅ EJERCICIO 2 (Nivel 1)
--Consigna:
--Sumá el total de ventas por producto usando la tabla Sales.SalesOrderDetail.
--📌 Tabla: Sales.SalesOrderDetail
--📌 Campos útiles:
--ProductID
--LineTotal (importe total por producto * cantidad)
--📤 Tu tarea:
--Escribí una consulta que:
--Agrupe por ProductID
--Sume los valores de LineTotal
--Ordene de mayor a menor

SELECT TOP 1 * 
FROM sales.SalesOrderDetail;

SELECT ProductID, CAST(SUM(LineTotal) AS DECIMAL (10,2)) AS TotalImporte
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY TotalImporte DESC;

--CON ROUND()
SELECT ProductID, ROUND(SUM(LineTotal),2) AS TotalImporte
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY TotalImporte DESC;

--✅ EJERCICIO 3 (Nivel 1 – JOIN)
--Consigna:
--Uní las tablas Production.Product y Production.ProductSubcategory para mostrar:
--ProductID
--nombre del producto
--nombre de la subcategoría
--📌 Tablas:
--Production.Product
--Production.ProductSubcategory
--🔑 Clave de unión:
--Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID
--📤 Tu tarea:
--Escribí una consulta que:
--Haga un JOIN entre esas 2 tablas
--Use alias si querés (ej: p, ps)
--Muestre los 3 campos pedidos
--Ordene alfabéticamente por nombre de subcategoría (opcional)

SELECT TOP 1 * FROM Production.Product;

SELECT TOP 1 * FROM Production.ProductSubcategory;

SELECT P.ProductID, P.Name AS Producto, PS.Name AS Subcategoría
FROM Production.Product AS P
JOIN Production.ProductSubcategory AS PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
ORDER BY PS.Name ASC;

--✅ EJERCICIO 4 (Nivel 1 – JOIN)
--Consigna:
--Uní las tablas Sales.SalesOrderHeader y Sales.SalesOrderDetail para mostrar:
--SalesOrderID
--OrderDate
--ProductID
--OrderQty
--LineTotal
--📌 Tablas:
--Sales.SalesOrderHeader (alias H)
--Sales.SalesOrderDetail (alias D)
--🔑 Clave de unión:
--H.SalesOrderID = D.SalesOrderID

SELECT TOP 1 * FROM Sales.SalesOrderHeader;

SELECT TOP 1 * FROM Sales.SalesOrderDetail;

SELECT OH.SalesOrderID, OH.OrderDate, OD.ProductID, OD.OrderQty, CAST(OD.LineTotal AS DECIMAL (10,2)) AS LineTotalRedondeado
FROM Sales.SalesOrderHeader OH
JOIN Sales.SalesOrderDetail OD
ON OH.SalesOrderID = OD.SalesOrderID
ORDER BY OD.LineTotal DESC; 

--✅ EJERCICIO 5 (Nivel 1 – GROUP BY + HAVING)
--Consigna:
--Mostrá los clientes que hicieron más de 10 órdenes.
--📌 Tabla:
--Sales.SalesOrderHeader (alias OH)
--📌 Campos útiles:
--CustomerID
--SalesOrderID

--📤 Tu tarea:
--Agrupá por CustomerID
--Contá cuántas órdenes tiene cada uno
--Mostrá solo los que tienen más de 10
--Ordená de mayor a menor

SELECT TOP 1 * FROM Sales.SalesOrderHeader;

SELECT CustomerID, COUNT(SalesOrderID) AS CantidadOrdenes
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) > 10
ORDER BY CantidadOrdenes DESC;

--✅ EJERCICIO 6 – UNION vs UNION ALL
--Consigna:
--Mostrá una lista única de todas las ciudades que aparecen en:
--Direcciones de facturación (BillToAddressID)
--Direcciones de envío (ShipToAddressID)
--📌 Tablas involucradas:
--Sales.SalesOrderHeader (alias OH)
--Person.Address (alias A)
--🧠 Claves de unión:
--OH.BillToAddressID = A.AddressID
--OH.ShipToAddressID = A.AddressID

SELECT TOP 1 * FROM Sales.SalesOrderHeader;

SELECT TOP 1 * FROM Person.Address;

SELECT A.City
FROM Sales.SalesOrderHeader AS OH
JOIN
Person.Address AS A ON OH.BillToAddressID = A.AddressID --facturación

UNION

SELECT A.City
FROM sALES.SalesOrderHeader AS OH
JOIN
Person.Address AS A ON OH.ShipToAddressID = A.AddressID--envío

ORDER BY City ASC;

