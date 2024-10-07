# 1
CREATE VIEW list_of_customers AS
	SELECT 
		c.customer_id,
		CONCAT(c.first_name, ' ', c.last_name) as full_name,
		a.address,
		a.phone,
		c2.city,
		c3.country,
		CASE 
			WHEN c.active = 1 THEN 'active'
			ELSE 'inactive'
		END AS 'status',
		c.store_id 
	FROM customer c
	JOIN address a ON c.address_id = a.address_id
	JOIN city c2 ON a.city_id = c2.city_id 
	JOIN country c3 ON c2.country_id = c3.country_id; 

# 2
DROP VIEW IF EXISTS film_details ;
CREATE VIEW film_details AS
	SELECT 
		f.film_id,
		f.title,
		f.description,
		cty.name AS 'category',
		f.rental_rate AS 'price',
		f.`length`,
		f.rating,
		GROUP_CONCAT(CONCAT(a.first_name) SEPARATOR ' ') as actors
	FROM film f
	JOIN film_category fc ON f.film_id = fc.film_id
	JOIN category cty ON fc.category_id = cty.category_id
	JOIN film_actor fa ON f.film_id = fa.film_id 
	JOIN actor a ON fa.actor_id = a.actor_id
	GROUP BY f.film_id, f.title, f.description, category, price, f.`length`, f.rating;

# 3
DROP VIEW IF EXISTS sales_by_film_category;
CREATE VIEW sales_by_film_category AS
	SELECT
		c.category_id,
		c.name AS category,
		COUNT(r.rental_id) AS total_rental
	FROM category c 
	LEFT JOIN film_category fc ON c.category_id = fc.category_id 
	LEFT JOIN film f ON fc.film_id = f.film_id
	LEFT JOIN inventory i ON f.film_id = i.film_id 
	LEFT JOIN rental r ON i.inventory_id = r.inventory_id
	GROUP BY c.category_id;

# 4 
CREATE VIEW actor_information AS
	SELECT
		a.actor_id,
		a.first_name,
		a.last_name,
		COUNT(fa.film_id) AS amount_films
	FROM actor a 
	LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id 
	GROUP BY a.actor_id;

# 5

# Creamos la view con el nombre 'actor_information' Y declaramos que lo 
# proximo sera la consulta a guardar en dicha view

# CREATE VIEW actor_information AS

# Selecionamos las columnas, de la tabla actor, actor id, nombre y apellido. 
# Ademas contamos las filas agrupadas (despues explicado) film_id de la tabla 
# de relacion entre peliculas y actores film_actor

# SELECT
#	a.actor_id,
#	a.first_name,
#	a.last_name,
#	COUNT(fa.film_id) AS amount_films

# Seleccionamos como tabla principal a la tabla actor y le ponemos un alias 'a'

# FROM actor a 

# Unimos nuestra tabla principal con la tabla film_actor, incluyendo todos los registros 
# de la tabla principal o tabla izquierda. Los unimos con el actor_id de ambas tablas

# LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id 

# Agrupamos por el id de cada actor para obtener la cantidad de peliculas que cada uno
# participo.

# GROUP BY a.actor_id;


# 6
# DESCRIPCION
# Son objetos de base de datos que almacenan físicamente los resultados de una consulta, 
# permitiendo un acceso más rápido a los datos sin necesidad de recalcular la consulta cada vez.

# PORQUE SON USADAS
# Se utilizan para mejorar el rendimiento de consultas complejas, 
# reduciendo la carga de una consulta compleja en el sistema

# Alternativas:
# - Vistas normales: Consultas que se recalculan en tiempo real
# - Indices: Mejoran el rendimiento de acceso a datos, pero no almacenan resultados de consultas

# DBMS donde existen:
# - Oracle Database
# - PostgreSQL
# - Microsoft SQL Server




















