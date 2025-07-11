--🟢 BLOQUE 1 – Warm-up (Agregaciones, GROUP BY, HAVING, JOIN)
--🔹 EJERCICIO 1 – GROUP BY + SUM
--Consigna:
--Mostrá el total de ventas (SUM(LineTotal)) por producto (ProductID), ordenado de mayor a menor.
--📌 Tabla: Sales.SalesOrderDetail
SELECT TOP 1 * FROM Sales.SalesOrderDetail;

SELECT ProductID, CAST(SUM(LineTotal) AS DECIMAL (10,2)) AS TotalVentas
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY SUM(LineTotal) DESC;

--🔹 EJERCICIO 2 – JOIN con producto
--Consigna:
--Mostrá el nombre del producto y el total vendido, agrupado por nombre.
--📌 Tablas:
--Sales.SalesOrderDetail
--Production.Product

SELECT TOP 1 * FROM Sales.SalesOrderDetail;
SELECT TOP 1 * FROM Production.Product;

SELECT P.ProductID, P.Name, CAST(SUM(LineTotal) AS DECIMAL (10,2)) AS TotalVentas
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P ON P.ProductID = SOD.ProductID
GROUP BY P.ProductID, P.Name
ORDER BY P.Name;

--✅ Regla de SQL Server:
--Cuando hacés un GROUP BY, todas las columnas del SELECT que no son funciones agregadas deben estar en el GROUP BY.
--❓¿Pueden las funciones agregadas estar en el GROUP BY?
--🛑 No. Nunca.

--✅ EJERCICIO 3 – Agregar HAVING a la consulta anterior
--Mostrá solo los productos cuyo total vendido supera los 100,000.

SELECT P.ProductID, P.Name, CAST(SUM(LineTotal) AS DECIMAL (10,2)) AS TotalVentas
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P ON P.ProductID = SOD.ProductID
GROUP BY P.ProductID, P.Name
HAVING SUM(LineTotal) > 100000
ORDER BY P.Name;

--🧠 Recordá:
--WHERE → filtra antes de agrupar
--HAVING → filtra después de agrupar, sobre funciones agregadas


--🧪 EJERCICIO 4 – CASE
--Clasificá los productos vendidos en:
--'Alto' si el total vendido supera 150.000
--'Medio' si supera 50.000
--'Bajo' en el resto de los casos
--📌 Usá los mismos datos del ejercicio anterior:
--Sales.SalesOrderDetail
--Production.Product

SELECT TOP 1 * FROM Sales.SalesOrderDetail;
SELECT TOP 1 * FROM Production.Product;

SELECT 
	P.ProductID, 
	P.Name, CAST(SUM(LineTotal) AS DECIMAL (10,2)) AS TotalVentas,
	CASE
		WHEN SUM(LineTotal) > 150000 THEN 'Alto'
		WHEN SUM(LineTotal) > 50000 THEN 'Medio'
		ELSE 'Bajo'
	END AS CategoríaVenta
FROM Production.Product P 
JOIN Sales.SalesOrderDetail SOD ON P.ProductID = SOD.ProductID
GROUP BY P.ProductID, P.Name;


--🎯 Consigna:
--Queremos clasificar a los clientes según el total gastado (TotalDue) en sus órdenes.
--📊 Categorías:
--'Cliente Premium' si gastó más de 100.000
--'Cliente Regular' si gastó entre 50.000 y 100.000
--'Cliente Básico' si gastó menos
--🗂️ Tablas:
--Usamos Sales.SalesOrderHeader

SELECT TOP 1 * FROM Sales.SalesOrderHeader

SELECT 
	CustomerID, 
	CAST(SUM(TotalDue) AS DECIMAL (10,2)) AS TotalVentas,
	CASE
		WHEN SUM(TotalDue) > 100000 THEN 'Premium'
		WHEN SUM(TotalDue) > 50000 THEN 'Regular'
		ELSE 'Basic'
	END AS Category
FROM Sales.SalesOrderHeader
GROUP BY CustomerID