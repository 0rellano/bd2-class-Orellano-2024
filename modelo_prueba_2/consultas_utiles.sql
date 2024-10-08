# TODOS LOS CLIENTES POR NOMBRE LOCALIDAD
SELECT c.COD_CLIENTE, c.NOMBRE, c.APELLIDO, l.NOMBRE 
FROM CLIENTES c
JOIN LOCALIDADES l ON c.COD_LOCALIDAD = l.COD_LOCALIDAD
WHERE l.NOMBRE = "CORDOBA"

# TODOS LOS CLIENTES CON COMPRAS POR LOCALIDAD
# zzz hacerlo

# DA LAS CATEGORIAS COMPRADAS POR CLIENTES

SELECT tp.NOMBRE , SUM(df.CANTIDAD) AS CANTIDAD
FROM TIPOS_PLANTAS tp 
JOIN PLANTAS p ON tp.COD_TIPO_PLANTA = p.COD_TIPO_PLANTA 
JOIN DETALLES_FACTURAS df ON p.COD_PLANTA = df.COD_PLANTA
JOIN FACTURAS f ON df.NRO_FACTURA = f.NRO_FACTURA
WHERE f.COD_CLIENTE = 11 	
GROUP BY tp.COD_TIPO_PLANTA

# OBTIENE EL O LOS NOMBRES DE LOS MAXIMOS COMPRADOS TIPO PLANTAS (CLIENTE ID 10). 
# ES UN PROBLEMA PARA LA SUBQUERY

SELECT tp2.NOMBRE
FROM TIPOS_PLANTAS tp2 
JOIN PLANTAS p2 ON tp2.COD_TIPO_PLANTA = p2.COD_TIPO_PLANTA 
JOIN DETALLES_FACTURAS df2 ON p2.COD_PLANTA = df2.COD_PLANTA
JOIN FACTURAS f2 ON df2.NRO_FACTURA = f2.NRO_FACTURA
WHERE f2.COD_CLIENTE = 10
GROUP BY tp2.COD_TIPO_PLANTA
HAVING SUM(df2.CANTIDAD) = (
	SELECT MAX(CP.TOTALES)
	FROM (
		SELECT SUM(df3.CANTIDAD) AS TOTALES
		FROM TIPOS_PLANTAS tp3
		JOIN PLANTAS p3 ON tp3.COD_TIPO_PLANTA = p3.COD_TIPO_PLANTA 
		JOIN DETALLES_FACTURAS df3 ON p3.COD_PLANTA = df3.COD_PLANTA
		JOIN FACTURAS f3 ON df3.NRO_FACTURA = f3.NRO_FACTURA
		WHERE f3.COD_CLIENTE = 10
		GROUP BY tp3.COD_TIPO_PLANTA
	) AS CP
)	
		
		
# OBTENER EL MAXIMO O NULO DE LA CATEOGRIA DE PLATNA MAS COMRPADA
SELECT tp2.NOMBRE
FROM TIPOS_PLANTAS tp2 
JOIN PLANTAS p2 ON tp2.COD_TIPO_PLANTA = p2.COD_TIPO_PLANTA 
JOIN DETALLES_FACTURAS df2 ON p2.COD_PLANTA = df2.COD_PLANTA
JOIN FACTURAS f2 ON df2.NRO_FACTURA = f2.NRO_FACTURA
WHERE f2.COD_CLIENTE = 1
GROUP BY tp2.COD_TIPO_PLANTA
HAVING SUM(df2.CANTIDAD) > ALL (
	SELECT SUM(df3.CANTIDAD)
	FROM TIPOS_PLANTAS tp3
	JOIN PLANTAS p3 ON tp3.COD_TIPO_PLANTA = p3.COD_TIPO_PLANTA 
	JOIN DETALLES_FACTURAS df3 ON p3.COD_PLANTA = df3.COD_PLANTA
	JOIN FACTURAS f3 ON df3.NRO_FACTURA = f3.NRO_FACTURA
	WHERE f3.COD_CLIENTE = 1
	AND tp3.COD_TIPO_PLANTA != tp2.COD_TIPO_PLANTA 
	GROUP BY tp3.COD_TIPO_PLANTA
)	













