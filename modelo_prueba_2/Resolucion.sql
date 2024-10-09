# 1 RESUELTO COMPRADO TODO
SELECT 
	c.COD_CLIENTE AS COD_CLIENTE,
	c.APELLIDO,
	COUNT(f.NRO_FACTURA) AS CANTIDAD_COMPRAS,
	(
		SELECT SUM(df.CANTIDAD * p.PRECIO)
		FROM DETALLES_FACTURAS df
		LEFT JOIN FACTURAS f ON df.NRO_FACTURA = f.NRO_FACTURA 
		LEFT JOIN CLIENTES c1 ON c1.COD_CLIENTE = f.COD_CLIENTE 
		LEFT JOIN PLANTAS p ON p.COD_PLANTA = df.COD_PLANTA 
		WHERE c1.COD_CLIENTE = c.COD_CLIENTE 
		GROUP BY c1.COD_CLIENTE
	) AS TOTAL_GASTADO,
	(
		SELECT tp2.NOMBRE
		FROM TIPOS_PLANTAS tp2 
		JOIN PLANTAS p2 ON tp2.COD_TIPO_PLANTA = p2.COD_TIPO_PLANTA 
		JOIN DETALLES_FACTURAS df2 ON p2.COD_PLANTA = df2.COD_PLANTA
		JOIN FACTURAS f2 ON df2.NRO_FACTURA = f2.NRO_FACTURA
		WHERE f2.COD_CLIENTE = c.COD_CLIENTE
		GROUP BY tp2.COD_TIPO_PLANTA
		HAVING SUM(df2.CANTIDAD) > ALL (
			SELECT SUM(df3.CANTIDAD)
			FROM TIPOS_PLANTAS tp3
			JOIN PLANTAS p3 ON tp3.COD_TIPO_PLANTA = p3.COD_TIPO_PLANTA 
			JOIN DETALLES_FACTURAS df3 ON p3.COD_PLANTA = df3.COD_PLANTA
			JOIN FACTURAS f3 ON df3.NRO_FACTURA = f3.NRO_FACTURA
			WHERE f3.COD_CLIENTE = c.COD_CLIENTE
			AND tp3.COD_TIPO_PLANTA != tp2.COD_TIPO_PLANTA 
			GROUP BY tp3.COD_TIPO_PLANTA
		)	
	) AS CATEGORIA_PLANTA_MAS_COMPRADO,
	(
		SELECT GROUP_CONCAT(PC.NOMBRE, ": ", PC.CANTIDAD SEPARATOR "; ") 
		FROM (
			SELECT tp.NOMBRE , SUM(df.CANTIDAD) AS CANTIDAD
			FROM TIPOS_PLANTAS tp 
			JOIN PLANTAS p ON tp.COD_TIPO_PLANTA = p.COD_TIPO_PLANTA 
			JOIN DETALLES_FACTURAS df ON p.COD_PLANTA = df.COD_PLANTA
			JOIN FACTURAS f ON df.NRO_FACTURA = f.NRO_FACTURA
			WHERE f.COD_CLIENTE = c.COD_CLIENTE
			GROUP BY tp.COD_TIPO_PLANTA 
		) AS PC
	) AS CANTIDAD_PLANTAS_COMPRADAS_POR_CATEGORIAS
FROM CLIENTES c
LEFT JOIN FACTURAS f ON c.COD_CLIENTE = f.COD_CLIENTE
GROUP BY c.COD_CLIENTE;

	
# 2. DOS FORMAS DE HACERLO dos posibles casos: 
# 	- todos los clientes son activos
#   - todos los clientes con compras son activos

# Todos los Clientes Son Activos
DROP PROCEDURE IF EXISTS GET_CLIENTES_ACTIVOS_BY_LOCALIDAD;
DELIMITER //
CREATE PROCEDURE GET_CLIENTES_ACTIVOS_BY_LOCALIDAD(
	IN p_localidad VARCHAR(30),
	OUT p_lista VARCHAR (4000)
)
BEGIN
	DECLARE v_finished BOOL DEFAULT FALSE;
	DECLARE v_is_first BOOL DEFAULT TRUE;
	
	DECLARE v_first_name VARCHAR(30) ;
	DECLARE v_last_name VARCHAR(30);
	
	DECLARE cursor_clientes CURSOR FOR
		SELECT c.NOMBRE, c.APELLIDO
		FROM CLIENTES c
		JOIN LOCALIDADES l ON c.COD_LOCALIDAD = l.COD_LOCALIDAD
		WHERE l.NOMBRE = p_localidad;
		
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET v_finished = TRUE;
	
	OPEN cursor_clientes;
	
	while_clientes: WHILE v_finished = FALSE DO
		FETCH cursor_clientes INTO v_first_name, v_last_name;
		
		IF v_is_first THEN
			SET v_is_first = FALSE;
			SET p_lista = CONCAT(v_first_name, " ", v_last_name);
			ITERATE while_clientes;
		END IF;
	
		SET p_lista = CONCAT(p_lista, ";", v_first_name, " ", v_last_name);
	END WHILE;
	
	CLOSE cursor_clientes;
END//
DELIMITER ;

CALL GET_CLIENTES_ACTIVOS_BY_LOCALIDAD("CORDOBA", @lista);
SELECT @lista;


# 3 

ALTER TABLE PLANTAS
	ADD lastModification DATETIME DEFAULT NOW();

ALTER TABLE PLANTAS
	ADD lastModifierUser VARCHAR(50);

SELECT * FROM PLANTAS p;

DROP TRIGGER before_PLANTAS_update;

DELIMITER //
CREATE TRIGGER before_PLANTAS_update	
	BEFORE UPDATE ON PLANTAS
	FOR EACH ROW
BEGIN 
	SET NEW.lastModification = NOW();
	SET NEW.lastModifierUser = USER();
END //
DELIMITER ;

UPDATE PLANTAS 
SET PRECIO = 53.6
WHERE COD_PLANTA = 1;










