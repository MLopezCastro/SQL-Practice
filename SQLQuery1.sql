SELECT TOP 100 * FROM ConCubo
WHERE ID LIKE '%14620%';


SELECT ID, COUNT(*) AS cantidad
FROM ConCubo
WHERE ID LIKE '%14620%'
GROUP BY ID
ORDER BY cantidad DESC;


SELECT ID, COUNT(*) AS Cantidad
FROM ConCubo
GROUP BY ID
ORDER BY Cantidad DESC;


SELECT COUNT(*) AS Cantidad, ID
FROM ConCubo
GROUP BY ID
ORDER BY Cantidad DESC;

SELECT TOP 100 *
FROM ColoresPredeterminados

SELECT ColorFondo, COUNT (*) AS Cantidad
FROM ColoresPredeterminados
GROUP BY ColorFondo
ORDER BY Cantidad DESC;

SELECT COUNT(*) FROM Renglones

SELECT TOP 100 * FROM Renglones

SELECT TOP 100 * FROM ConCubo

SELECT Renglon, COUNT(*) AS Cantidad
FROM ConCubo
GROUP BY Renglon
HAVING COUNT(*) > 100000
ORDER BY Cantidad DESC
