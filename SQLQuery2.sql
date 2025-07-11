SELECT TOP 100 * FROM Sales.SalesOrderDetail

SELECT SalesOrderID, AVG(OrderQty) AS Promedio_Cantidad
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY Promedio_Cantidad DESC

SELECT COUNT(DISTINCT SalesOrderID) AS Cantidad_ID
FROM Sales.SalesOrderDetail

SELECT TOP 10 * FROM Sales.Store

SELECT DISTINCT UnitPrice FROM Sales.SalesOrderDetail

SELECT DISTINCT UnitPriceDiscount FROM Sales.SalesOrderDetail
GROUP BY UnitPriceDiscount 
ORDER BY UnitPriceDiscount  DESC

--En SQL Server, todos los campos que aparecen en el SELECT deben cumplir una de estas dos condiciones:
--Están en la cláusula GROUP BY, o
--Se agregan con funciones como SUM(), AVG(), MAX(), etc.:

SELECT 
  SalesOrderID, 
  AVG(UnitPrice * UnitPriceDiscount) AS Avg_Final_Price
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0
GROUP BY SalesOrderID
ORDER BY Avg_Final_Price DESC; --puedo usar alias en GROUP BY

--🧠 ¿Se puede usar un alias en ORDER BY?
--✅ Sí, en SQL Server se puede usar el alias en ORDER BY
--Aunque no podés usar un alias en el GROUP BY, sí está permitido usarlo en ORDER BY.


SELECT SalesOrderID, (UnitPrice*UnitPriceDiscount) AS Final_Price, ProductID, CarrierTrackingNumber
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0 

--Ejercicio 1: Precio promedio por orden
--Mostrá el precio final promedio (UnitPrice * UnitPriceDiscount) por SalesOrderID, solo para filas donde haya descuento, y ordená de mayor a menor.

SELECT SalesOrderID, (UnitPrice * UnitPriceDiscount) AS AVG_Price
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount >0
GROUP BY (UnitPrice * UnitPriceDiscount), SalesOrderID
ORDER BY AVG_Price DESC

--Ejercicio 2: Precio total por orden
--Calculá el total de precio con descuento por SalesOrderID, y ordená del menor al mayor.

SELECT TOP 10 * FROM Sales.SalesOrderDetail

SELECT SalesOrderID, SUM(UnitPrice * UnitPriceDiscount) AS Total_Price
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0
GROUP BY SalesOrderID --SalesOrderID → está en el GROUP BY --SUM(UnitPrice * UnitPriceDiscount) → es una función de agregación, por lo tanto no necesita ir en el GROUP BY
ORDER BY Total_Price DESC 

--Ejercicio 3: Órdenes sin descuento
--Listá 10 órdenes (SalesOrderID) donde no hubo descuento, y mostrales el precio promedio sin aplicar UnitPriceDiscount.

SELECT TOP 10 * FROM Sales.SalesOrderDetail

SELECT TOP 10 SalesOrderID, AVG(UnitPrice) AS AVG_Price_NoDiscount
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount >0
GROUP BY SalesOrderID
ORDER BY AVG_Price_NoDiscount DESC

--Ejercicio 4: Promedio por producto
--Calculá el precio promedio con descuento para cada ProductID, solo si el producto aparece más de 10 veces.

SELECT TOP 10 * FROM Sales.SalesOrderDetail

SELECT 
  ProductID,
  COUNT(*) AS Cantidad, --👉 Entonces ese COUNT(*) siempre cuenta “dentro del grupo”, aunque vos lo escribas antes o después en el SELECT, o también en HAVING.
  AVG(UnitPrice * UnitPriceDiscount) AS Avg_Final_Price
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0
GROUP BY ProductID
HAVING COUNT(*) > 10
ORDER BY Avg_Final_Price DESC;

--Reglas clave:
--El GROUP BY se procesa antes que el SELECT
--Por eso, cuando el SELECT se evalúa, ya existen los grupos
--Entonces cualquier COUNT(*), AVG(), SUM() que pongas opera sobre cada grupo, aunque vos no lo “declares” explícitamente

--Ejercicio 5: Detectar descuentos fuertes
--Listá las líneas donde el descuento es mayor al 30% del precio unitario, y mostrales el precio original, el precio con descuento, y el porcentaje de descuento real.

SELECT TOP 10 * FROM Sales.SalesOrderDetail

SELECT ProductID, UnitPriceDiscount, UnitPrice, UnitPrice*UnitPriceDiscount AS PrecioFinal, 100*UnitPriceDiscount AS PorcentajeDescuento
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0.30
GROUP BY ProductID, UnitPrice, UnitPriceDiscount
ORDER BY PorcentajeDescuento DESC

--Cláusula	¿Permite usar solo una parte del SELECT?	¿Permite usar alias?	Detalles clave
--GROUP BY	❌ NO (debe incluir todas las columnas del SELECT que no son funciones agregadas)	❌ NO	No podés agrupar por un alias como PrecioFinal
--ORDER BY	✅ SÍ (podés ordenar por una sola columna)	✅ SÍ	Sí podés usar alias como PorcentajeDescuento