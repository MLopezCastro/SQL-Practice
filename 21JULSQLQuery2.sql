--🧩 Ejercicios con tablas incluidas
--1Total vendido por cada producto
--🔸 Tablas: Sales.SalesOrderDetail, Production.Product

--2Clasificación de clientes según cuánto gastaron (Premium, Regular, Básico)
--🔸 Tabla: Sales.SalesOrderHeader

--3Promedio de descuento aplicado por producto
--🔸 Tabla: Sales.SalesOrderDetail

--4Top 10 productos con mayor cantidad vendida
--🔸 Tablas: Sales.SalesOrderDetail, Production.Product

--5Ventas totales por mes durante el año 2008
--🔸 Tabla: Sales.SalesOrderHeader

--6Clientes que realizaron más de 5 compras
--🔸 Tabla: Sales.SalesOrderHeader

--7Productos que no se han vendido nunca
--🔸 Tablas: Production.Product, Sales.SalesOrderDetail

--8Cantidad total de productos en stock por categoría
--🔸 Tablas: Production.Product, Production.ProductSubcategory, Production.ProductInventory

--9-Encontrá el producto con mayor cantidad total vendida.
--📂 Tablas necesarias:
--Sales.SalesOrderDetail
--Production.Product

--10Pedidos cuyo envío tardó más de 10 días
--🔸 Tabla: Sales.SalesOrderHeader

--11Promedio de días entre la fecha de pedido y la de envío
--🔸 Tabla: Sales.SalesOrderHeader

--12Comparar ventas entre 2007 y 2008 por mes
--🔸 Tabla: Sales.SalesOrderHeader

--Nombre del cliente que más gastó en total
--🔸 Tablas: Sales.SalesOrderHeader, Sales.Customer, Person.Person

--Órdenes que contienen más de 3 productos distintos
--🔸 Tabla: Sales.SalesOrderDetail

--Promedio y total vendido por territorio de ventas
--🔸 Tabla: Sales.SalesOrderHeader


--

--1Total vendido por cada producto
--🔸 Tablas: Sales.SalesOrderDetail, Production.Product

SELECT TOP 1 * FROM Sales.SalesOrderDetail;
SELECT TOP 1 * FROM Production.Product;

SELECT SOD.ProductID, P.Name, CAST(SUM(LineTotal) AS DECIMAL (10,2)) AS TotalSales
FROM Sales.SalesOrderDetail AS SOD
JOIN Production.Product AS P ON SOD.ProductID = P.ProductID
GROUP BY SOD.ProductID, P.Name
ORDER BY TotalSales DESC;

--
--2Clasificación de clientes según cuánto gastaron (Premium, Regular, Básico)
--🔸 Tabla: Sales.SalesOrderHeader

SELECT TOP 10 * FROM Sales.SalesOrderHeader;

SELECT 
	CustomerID, 
	CAST(SUM(TotalDue) AS DECIMAL (10,2)) AS TotalSales,
	CASE 
		WHEN SUM(TotalDue) > 5000 THEN 'Premium'
		WHEN SUM(TotalDue) > 2000 THEN 'Regular'
		ELSE 'Basic'
	END AS 'Category'
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;


---
--6Clientes que realizaron más de 5 compras
--🔸 Tabla: Sales.SalesOrderHeader

SELECT TOP 1 * FROM Sales.SalesOrderHeader;

SELECT CustomerID, COUNT(SalesOrderID) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) >= 5;

--
--3Promedio de descuento aplicado por producto
--🔸 Tabla: Sales.SalesOrderDetail

SELECT TOP 1 * FROM Sales.SalesOrderDetail;

SELECT ProductID, CAST(AVG(UnitPriceDiscount) AS DECIMAL (10,2)) AS PromedioDesc 
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY PromedioDesc DESC;

--
--4Top 10 productos con mayor cantidad vendida
--🔸 Tablas: Sales.SalesOrderDetail, Production.Product

SELECT TOP 1 * FROM Sales.SalesOrderDetail;
SELECT TOP 1 * FROM Production.Product;

SELECT 
	TOP 10 
	SOD.ProductID, 
	P.Name,
	SUM(OrderQty) TotalQuantity
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P
ON SOD.ProductID = P.ProductID
GROUP BY SOD.ProductID, P.Name
ORDER BY TotalQuantity DESC;

--
--5Ventas totales por mes durante el año 2008
--🔸 Tabla: Sales.SalesOrderHeader

SELECT TOP 100 * FROM Sales.SalesOrderHeader;

SELECT 
	MONTH(OrderDate) AS Mes,
	CAST(SUM(TotalDue) AS DECIMAL (10,2)) AS Ventas 
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2012
GROUP BY MONTH(OrderDate)
ORDER BY Mes;


--
--7Productos que no se han vendido nunca
--🔸 Tablas: Production.Product, Sales.SalesOrderDetail

SELECT TOP 1 * FROM Production.Product;
SELECT TOP 1 * FROM Sales.SalesOrderDetail;

SELECT 
	P.ProductID, 
	P.Name 
FROM Production.Product AS P
LEFT JOIN Sales.SalesOrderDetail AS SOD
	ON SOD.ProductID = P.ProductID
WHERE SOD.ProductID IS NULL;

--
--8Cantidad total de productos en stock por categoría
--🔸 Tablas: Production.Product, Production.ProductSubcategory, Production.ProductInventory

SELECT TOP 1 * FROM Production.Product; --ProductID --Name
SELECT TOP 1 * FROM Production.ProductSubcategory; --ProductSubcategoryID --ProductCategoryID
SELECT TOP 1 * FROM Production.ProductInventory; --Quantity

SELECT 
    PC.Name AS Categoria,
    SUM(PI.Quantity) AS StockTotal
FROM Production.Product AS P
JOIN Production.ProductSubcategory AS PS 
    ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory AS PC 
    ON PS.ProductCategoryID = PC.ProductCategoryID
JOIN Production.ProductInventory AS PI 
    ON P.ProductID = PI.ProductID
GROUP BY PC.Name
ORDER BY StockTotal DESC;

--
SELECT TOP 2 * FROM Production.Product
ORDER BY ProductID DESC;
--para reemplazar limit

--ORDEN:
--1 FROM
--2 WHERE
--3 SELECT
--4 ORDER BY

---
--ROUND()

SELECT 
	MONTH(OrderDate) AS Mes,
	ROUND(SUM(TotalDue),2) AS Ventas 
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2012
GROUP BY MONTH(OrderDate)
ORDER BY Mes;

--CEIL()
SELECT 
	MONTH(OrderDate) AS Mes,
	CEILING(SUM(TotalDue)) AS Ventas 
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2012
GROUP BY MONTH(OrderDate)
ORDER BY Mes;

--UPPER() / LOWER()

SELECT TOP 2 * FROM Production.Product
SELECT 
	UPPER(Name), 
	ProductID
FROM Production.Product;

--
--CONCAT()

SELECT 
	CONCAT(ProductID, Name) AS experimento_raro, 
	ProductNumber
FROM Production.Product;

--
SELECT * FROM Sales.SalesOrderHeader;

SELECT 
	COUNT(SalesOrderID) AS cantidad_ventas,
	YEAR(OrderDate) AS Año
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate);

--
--CONCAT

SELECT TOP 2 * FROM Production.Product

SELECT CONCAT(Name, '-', ProductID) FROM Production.Product;

--
--9-Encontrá el producto con mayor cantidad total vendida.
--📂 Tablas necesarias:
--Sales.SalesOrderDetail
--Production.Product

SELECT TOP 1 * FROM Sales.SalesOrderDetail;
SELECT TOP 1 * FROM Production.Product;

SELECT TOP 1 SOD.ProductID,
		P.Name,
		SUM(OrderQty) AS cantidad_vendida
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P
ON SOD.ProductID = P.ProductID
GROUP BY SOD.ProductID, P.Name;

--
--10Pedidos cuyo envío tardó más de 10 días
--🔸 Tabla: Sales.SalesOrderHeader

SELECT TOP 1 * FROM Sales.SalesOrderHeader;

SELECT SalesOrderID,
		DATEDIFF(day, OrderDate, ShipDate) AS dias_envío
FROM Sales.SalesOrderHeader
WHERE DATEDIFF(day, OrderDate, ShipDate) > 7
GROUP BY SalesOrderID, OrderDate, ShipDate;


----11Promedio de días entre la fecha de pedido y la de envío
--🔸 Tabla: Sales.SalesOrderHeader

SELECT TOP 1 * FROM Sales.SalesOrderHeader;

SELECT AVG(DATEDIFF(day, OrderDate, ShipDate)) AS promedio_días,
		SalesOrderID
FROM Sales.SalesOrderHeader
GROUP BY SalesOrderID, OrderDate, Shipdate
ORDER BY promedio_días ASC;

--
----12Comparar ventas entre 2007 y 2008 por mes
--🔸 Tabla: Sales.SalesOrderHeader

SELECT TOP 100 * FROM Sales.SalesOrderHeader;

--difícil
SELECT 
    MONTH(OrderDate) AS Mes,
    SUM(CASE WHEN YEAR(OrderDate) = 2011 THEN TotalDue ELSE 0 END) AS Ventas_2011, --recorre todas las filas y solo suma si es 2011, si no, no suma nada
    SUM(CASE WHEN YEAR(OrderDate) = 2012 THEN TotalDue ELSE 0 END) AS Ventas_2012
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) IN (2011, 2012) --hace la query más rápida
GROUP BY MONTH(OrderDate) --hace que SUM se calcule por mes, no todo junto
ORDER BY Mes;

SELECT TOP 10 MONTH(ShipDate) FROM Sales.SalesOrderHeader;

--(sin case): horrible
SELECT 
    YEAR(OrderDate) AS Año,
    MONTH(OrderDate) AS Mes,
    SUM(TotalDue) AS Ventas
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) IN (2011, 2012)
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY MONTH(OrderDate);

