--EJERCICIO 1 (tabla: Sales.SalesOrderDetail)
--Objetivo: Para cada orden (SalesOrderID), calcular:
--el total de dinero generado (LineTotal)
--la cantidad total de productos (OrderQty)
--el descuento promedio (UnitPriceDiscount)
--Condiciones:
--Mostrar solo órdenes con total (LineTotal) mayor a 1000
--Ordenar de mayor a menor revenue
--Redondear el promedio de descuento a 2 decimales

SELECT TOP 1 * FROM Sales.SalesOrderDetail

SELECT SalesOrderID, CAST(SUM(LineTotal) AS DECIMAL (10,2)) AS Revenue, SUM(OrderQty) AS TotalQty, CAST(AVG(UnitPriceDiscount) AS DECIMAL(10,2)) AS DescPromedio
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(LineTotal) > 1000
ORDER BY Revenue DESC

---CAST(SUM(LinteTotal) AS DECIMAL (10,2))



--EJERCICIO 2 (tabla: Sales.SalesOrderDetail)
--Objetivo: Para cada producto (ProductID), mostrar:
--la cantidad de veces que fue vendido (cantidad de filas)
--su descuento promedio (UnitPriceDiscount)
--Condiciones:
--Solo mostrar los productos con descuento promedio mayor a 0.30
--Ordenar del más alto al más bajo descuento promedio
--Redondear el descuento promedio a 3 decimales

SELECT TOP 1 * FROM Sales.SalesOrderDetail

SELECT ProductID, COUNT(SalesOrderID) AS CantVentas, CAST(AVG(UnitPriceDiscount) AS DECIMAL (10,3)) AS PromDesc
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING (AVG(UnitPriceDiscount)) > 0.01 ---en HAVING no hace falta CAST, AS ... etc
ORDER BY PromDesc DESC

--Usando la tabla Sales.SalesOrderDetail, obtené una lista de ProductID que tenga:
--la cantidad de veces que aparece en las órdenes (ventas),
--el precio total promedio (LineTotal) redondeado a 2 decimales
--solo aquellos productos cuyo promedio de LineTotal sea mayor a 1000.
--Ordená el resultado de mayor a menor según ese promedio.

SELECT TOP 1 * FROM Sales.SalesOrderDetail

SELECT ProductID, COUNT(ProductID) AS Cantidad, CAST(AVG(LineTotal) AS DECIMAL (10,2)) AS PrecioTotalPromedio
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING AVG(LineTotal) > 1000
ORDER BY PrecioTotalPromedio DESC
