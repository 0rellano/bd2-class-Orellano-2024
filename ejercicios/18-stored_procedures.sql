# 1
DROP FUNCTION get_amount_of_copies_of_film_in_store;
DELIMITER //
CREATE FUNCTION 
	get_amount_of_copies_of_film_in_store(p_film_id INT, p_store_id INT) 
	RETURNS INT
	NOT DETERMINISTIC
	BEGIN
		DECLARE amount_copies INT;
	
		SELECT count(inventory_id) INTO amount_copies
		FROM inventory
		WHERE film_id = p_film_id
		AND store_id = p_store_id;
		
		return (amount_copies);
		
	END//
	
DELIMITER ;

SELECT get_amount_of_copies_of_film_in_store(2,2);

# 2

DELIMITER //
CREATE PROCEDURE 
	get_list_customers_by_country_id(
		IN p_country_id INT, 
		OUT p_list_customer VARCHAR(4000)
	)
	BEGIN
		DECLARE v_first_name VARCHAR(100);
		DECLARE v_last_name VARCHAR(100);
		DECLARE v_finished BOOL DEFAULT FALSE;
		DECLARE v_is_first BOOL DEFAULT TRUE;
		
		DECLARE cursor_customers CURSOR FOR
			SELECT c.first_name, c.last_name
			FROM customer c
			JOIN address a ON c.address_id = a.address_id 
			JOIN city ci ON a.city_id = ci.city_id 
			JOIN country co ON ci.country_id = co.country_id
			WHERE co.country_id = p_country_id;
		
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = TRUE;
		
		SET p_list_customer = "";
		
		OPEN cursor_customers;
		
		WHILE v_finished = FALSE DO
			FETCH cursor_customers INTO v_first_name, v_last_name;
		
			IF v_is_first THEN
				SET v_is_first = FALSE;
				SET p_list_customer = CONCAT(v_first_name, " ", v_last_name);
			ELSE
				SET p_list_customer = CONCAT(p_list_customer, ";", CONCAT(v_first_name, " ", v_last_name));
			END IF;
		END WHILE;
	
		CLOSE cursor_customers;
				
	END//
DELIMITER ;

CALL get_list_customers_by_country_id(1, @lista);
SELECT @lista as lista;


# 3
# FUNCION COPIADA de Inventory_in_stock
CREATE DEFINER=`user`@`localhost` FUNCTION `sakila`.`inventory_in_stock`(p_inventory_id INT) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
    DECLARE v_rentals INT;
    DECLARE v_out     INT;

    SELECT COUNT(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;

    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;

    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;

    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END

# Crea la funcion con permisos para usuarios para el host LOCAL. Declara la funcion
# para sakila con el nombre de  inventory_in_stock. Recibe el el id de inventario. 
# Aunque retorna un tint, en realidad devolveria un Booleano(1 TRUE y 0 False)

# Declara dos variables intiger que son rentals y out,
# Guarda en rentals la cantidad de rentas de un inventario(copia pelicula).

# Si la cantidad de rentas es igual a cero retorna TRUE

# Guarda en OUT la cantidad de rentas de un inventario que NO fueron devueltos.
# Si dicha variable OUT es mayor a cero retorna TRUE porque significa que hay rentas sin devolver
# De lo contrario retorna FALSE


# PROCEDURE Copiado Film_IN_Stock

CREATE DEFINER=`user`@`localhost` PROCEDURE `sakila`.`film_in_stock`(
IN p_film_id INT, IN p_store_id INT, OUT p_film_count INT)
    READS SQL DATA
BEGIN
     SELECT inventory_id
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id);

     SELECT COUNT(*)
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id)
     INTO p_film_count;
END

# Crea la el store procedure con permisos para usuarios para el host LOCAL.
# Recibe  parametros de entrada: film_id y store_id y retorna la cantidad de peliculas

# Simplemente selecciona el inventario id  del id de la pelicula pasada por parametro
# y del id de la tienda y, por ultimo, verifica que dicha inventory_id este en stock
# con la funcion de inventory_in_stock. Simplemente es una consulta y NO tiene
# impacto

# Despues dentro de p_film_count guarda la cantidad de inventarios 
disponibles (verificado con la funcion inventory_in_stock) de la 
3 pelicula y tienda pasada.





