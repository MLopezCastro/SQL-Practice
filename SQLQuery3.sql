SELECT TOP 10 * FROM Sales.SalesOrderDetail

--1️⃣ Ventas totales por producto
--Mostrá el ProductID, la cantidad total vendida (OrderQty) y el total facturado (LineTotal) para cada producto.

SELECT ProductID, SUM(OrderQty) CantVendida, SUM(LineTotal) AS TotalVenta
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY TotalVenta DESC;

--2️⃣ Precio promedio con descuento (por orden)
--Calculá el promedio de (UnitPrice * UnitPriceDiscount) por SalesOrderID solo para los que tienen descuento.

SELECT AVG(UnitPrice + UnitPriceDiscount)
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0

--pero ésto pide:

SELECT SalesOrderID, AVG(UnitPrice + UnitPriceDiscount) AS PrecioFinalPromedio
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0
GROUP BY SalesOrderID
ORDER BY PrecioFinalPromedio DESC

--3️⃣ Órdenes grandes (más de $5000)
--Mostrá el SalesOrderID, el monto total (TotalDue) y la fecha para las órdenes de más de $5000.

SELECT TOP 10 * FROM Sales.SalesOrderDetail

SELECT SalesOrderID, LineTotal, ModifiedDate
FROM Sales.SalesOrderDetail
WHERE LineTotal > 5000

--Pero la tabla es ésta:

SELECT TOP 10 * FROM Sales.SalesOrderHeader

SELECT SalesOrderID, TotalDue, OrderDate
FROM Sales.SalesOrderHeader
WHERE TotalDue > 5000
ORDER BY TotalDue DESC;

--4🔹 EJERCICIO: Total facturado por orden con JOIN entre SalesOrderDetail y SalesOrderHeader
--Queremos ver el total de cada orden (SalesOrderID), su fecha (OrderDate) y el total facturado, sumando los LineTotal desde la tabla de detalle.

SELECT TOP 1 * FROM Sales.SalesOrderDetail

SELECT SOD.SalesOrderID, SOH.OrderDate, SOH.TotalDue
FROM Sales.SalesOrderDetail SOD
JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY SOD.SalesOrderID, SOH.OrderDate, SOH.TotalDue
ORDER BY SOH.TotalDue DESC