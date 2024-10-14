# Simulacro de examen

# 1
# Obtener los pares de apellidos de actores que comparten nombres, considerando
# solo los actores cuyo nombre comienza con una vocal. Mostrar el nombre, los 2
# apellidos y las películas que comparten.
SELECT
	a1.last_name AS actor_1,
	a2.last_name AS actor_2,
	(
		SELECT GROUP_CONCAT(f.title SEPARATOR "; ") 
		FROM film f
		WHERE f.film_id IN (
			SELECT fa.film_id
			FROM film_actor fa 
			WHERE fa.actor_id = a1.actor_id
		)
		AND f.film_id IN (
			SELECT fa.film_id
			FROM film_actor fa 
			WHERE fa.actor_id = a2.actor_id
		)
	) AS peliculas_compartidas
FROM actor a1
JOIN actor a2 
	ON a1.actor_id > a2.actor_id
	AND a1.first_name = a2.first_name
WHERE a1.first_name LIKE "A%"
	OR a1.first_name LIKE "E%"
	OR a1.first_name LIKE "I%"
	OR a1.first_name LIKE "O%"
	OR a1.first_name LIKE "U%";

# 2
# Mostrar aquellas películas cuya cantidad de actores sea mayor al promedio de
# actores por películas. Además, mostrar su cantidad de actores y una lista de los
# nombres de esos actores.

SELECT 
	f.film_id, 
	f.title , 
	COUNT(fa.actor_id) AS cant_actores,
	GROUP_CONCAT(a.first_name, " ", a.last_name SEPARATOR "; " ) 
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id 
GROUP BY f.film_id
HAVING cant_actores > (
	SELECT AVG(ca.cant_actores)
	FROM (
		SELECT
		COUNT(fa.actor_id) AS cant_actores
		FROM film f
		JOIN film_actor fa ON f.film_id = fa.film_id 
		GROUP BY f.film_id
	) ca
);

# Promedio de actores en las peliculas
SELECT AVG(ca.cant_actores)
FROM (
	SELECT
	COUNT(fa.actor_id) AS cant_actores
	FROM film f
	JOIN film_actor fa ON f.film_id = fa.film_id 
	GROUP BY f.film_id
) ca;

# Cantidad de actores por peliculas
SELECT
	COUNT(fa.actor_id) AS cant_actores
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id 
GROUP BY f.film_id;


# 3
# Generar un informe por empleado mostrando el local, la cantidad y sumatoria de sus
# ventas, su venta máxima, mínima, cuantas veces se repite la venta máxima y la
# mínima, además mostrar en una columna una concatenación de todos los alquileres
# mostrando el título de la película alquilada y el monto pagado. Considerar sólo los
# datos del año actual.

# Falta cant veces del max y min

SELECT 
	s.staff_id, s.first_name, s.last_name, s.store_id, 
	COUNT(r.rental_id) AS cant_rentas,
	SUM(f.rental_rate) AS total_ventas,
	(
		SELECT MAX(p.amount)
		FROM payment p
		WHERE p.staff_id = s.staff_id
	) AS max_venta,
	(
		SELECT MIN(p.amount)
		FROM payment p
		WHERE p.staff_id = s.staff_id
	) AS min_venta
FROM staff s
JOIN rental r 
	ON s.staff_id = r.staff_id 
JOIN inventory i 
	ON r.inventory_id = i.inventory_id 
JOIN film f 
	ON i.film_id = f.film_id 
WHERE YEAR(r.rental_date) = 2006 # pero tendria que ser asi -> YEAR(NOW())
GROUP BY s.staff_id; 



