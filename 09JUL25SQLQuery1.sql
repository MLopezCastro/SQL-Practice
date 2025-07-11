--🧪 BLOQUE 1 – REPASO GUIADO (AGGREGATE, GROUP BY, HAVING, JOIN)
--🔹 EJERCICIO 1 – GROUP BY + agregación
--Consigna:
--Mostrá el total de ventas (SUM(LineTotal)) por producto (ProductID).
--📌 Tabla: Sales.SalesOrderDetail

SELECT TOP 1 * FROM Sales.SalesOrderDetail;

SELECT ProductID, CAST(SUM(Linetotal) AS DECIMAL (10,2)) AS TotalVentas
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY TotalVentas DESC;

--🔹 EJERCICIO 2 – JOIN + agregación
--Consigna:
--Uní Sales.SalesOrderDetail con Production.Product para mostrar:
--ProductID,
--Name (nombre del producto),
--SUM(LineTotal)
--Agrupá por producto y ordená de mayor a menor.

SELECT TOP 1 * FROM Sales.SalesOrderDetail;
SELECT TOP 1 * FROM Production.Product;

SELECT SOD.ProductID, P.Name, CAST(SUM(LineTotal) AS DECIMAL (10,2)) AS TotalVentas
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P ON SOD.ProductID = P.ProductID
GROUP BY SOD.ProductID, P.Name

--🔹 EJERCICIO 3 – HAVING
--Consigna:
--Mostrá los productos cuya suma total de ventas (LineTotal) supera los $100,000.
--📌 Podés usar la misma estructura del ejercicio 2 y agregar HAVING.

SELECT TOP 10 SOD.ProductID, P.Name, CAST(SUM(LineTotal) AS DECIMAL (10,2)) AS TotalVentas
FROM Sales.SalesOrderDetail SOD
JOIN Production.Product P ON SOD.ProductID = P.ProductID
GROUP BY SOD.ProductID, P.Name
HAVING SUM(LineTotal) > 100000
ORDER BY TotalVentas DESC;


--🧠 ¿Qué es CASE en SQL?
--CASE es como un "IF": te permite crear columnas personalizadas según condiciones.
--🧪 EJEMPLO PRÁCTICO (AdventureWorks)
--🔹 Consigna:
--Clasificá las órdenes en 3 categorías:

--'Alta' si TotalDue > 5000
--'Media' si está entre 1000 y 5000
--'Baja' si es menor o igual a 1000

--📌 Tabla: Sales.SalesOrderHeader
--📌 Campos: SalesOrderID, CustomerID, TotalDue

SELECT TOP 1 * FROM Sales.SalesOrderHeader

SELECT SalesOrderID, CustomerID, TotalDue,
CASE 
	WHEN TotalDue > 5000 THEN 'Alta'
	WHEN TotaLDue > 1000 THEN 'Media'
	ELSE 'Baja'
END AS Categoría                   --agrega columna Categoría
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;

--con GROUP BY:

SELECT 
  CASE
    WHEN TotalDue > 5000 THEN 'Alta'
    WHEN TotalDue > 1000 THEN 'Media'
    ELSE 'Baja'
  END AS Categoria,
  COUNT(*) AS CantidadOrdenes
FROM Sales.SalesOrderHeader
GROUP BY 
  CASE
    WHEN TotalDue > 5000 THEN 'Alta'
    WHEN TotalDue > 1000 THEN 'Media'
    ELSE 'Baja'
  END
ORDER BY CantidadOrdenes DESC;

--otra forma:
SELECT 
  CASE
    WHEN TotalDue > 5000 THEN 'Alta'
    WHEN TotalDue > 1000 THEN 'Media'
    ELSE 'Baja'
  END AS Categoria,
  COUNT(*) AS CantidadOrdenes,
  CAST(SUM(TotalDue) AS DECIMAL (10,2)) AS TotalVendido
FROM Sales.SalesOrderHeader
GROUP BY 
  CASE
    WHEN TotalDue > 5000 THEN 'Alta'
    WHEN TotalDue > 1000 THEN 'Media'
    ELSE 'Baja'
  END
ORDER BY TotalVendido DESC;

--✅ ¿Qué es OVER()?
--OVER() se usa para aplicar funciones agregadas sin agrupar, permitiéndote mantener el detalle fila por fila 
--pero ver también totales, promedios, etc.

--🧪 EJERCICIO – SUM(...) OVER(PARTITION BY ...)
--🔹 Consigna:
--Mostrá las órdenes con:
--SalesOrderID
--CustomerID
--TotalDue
--Total de ventas por cliente (sin agrupar)
--📌 Tabla: Sales.SalesOrderHeader

SELECT TOP 1 * FROM Sales.SalesOrderHeader

SELECT SalesOrderID, CustomerID, TotalDue
FROM Sales.SalesOrderHeader


SELECT SalesOrderID, CustomerID, CAST(TotalDue AS DECIMAL (10,2)) AS SubtotalOrden, CAST(SUM(TotalDue) OVER(PARTITION BY CustomerID) AS DECIMAL (10,2)) AS TotalCliente
FROM Sales.SalesOrderHeader
ORDER BY CustomerID
