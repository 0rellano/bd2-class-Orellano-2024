# 1
SELECT c.customer_id, CONCAT(c.first_name, c.last_name), a.address, c2.city
FROM customer c 
JOIN address a ON c.address_id = a.address_id 
JOIN city c2  ON a.city_id = c2.city_id 
JOIN country c3 ON c2.country_id = c3.country_id
AND c3.country = "Argentina"

# 2
SELECT f.film_id, f.title, l.name, CASE f.rating
        WHEN 'G' THEN 'G (General Audiences) – All ages admitted.'
        WHEN 'PG' THEN 'PG (Parental Guidance Suggested) – Some material may not be suitable for children.'
        WHEN 'PG-13' THEN 'PG-13 (Parents Strongly Cautioned) – Some material may be inappropriate for children under 13.'
        WHEN 'R' THEN 'R (Restricted) – Under 17 requires accompanying parent or adult guardian.'
        WHEN 'NC-17' THEN 'NC-17 (Adults Only) – No one 17 and under admitted.'
        else 'Not Rated'
    END AS rating
FROM film f
JOIN `language` l ON l.language_id = f.language_id

# 3
SELECT f.title, f.release_year 
FROM film f
WHERE f.film_id IN (
	SELECT fa.film_id 
	FROM film_actor fa
	JOIN actor a ON a.actor_id = fa.actor_id
	AND CONCAT(a.first_name, " ", a.last_name) LIKE "%PENELOPE G%"
);

# 4
SELECT 
	f.title, 
	CONCAT(c.first_name, " ", c.last_name),
	CASE 
		WHEN r.return_date IS NOT NULL THEN "Yes"
		ELSE "No"
	END AS "Devuelot"
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id 
WHERE MONTH(r.rental_date) IN (5, 6)

# 5
# - CAST(rental_id AS CHAR): Convierte el rental_id (que es un número entero) en una cadena de texto 
# (string). CAST es una función estándar de SQL que se usa para conversiones simples entre
# tipos de datos.
# - CONVERT(rental_date, DATE): Convierte rental_date a un tipo de dato DATE. CONVERT es una función 
# que, además de convertir tipos de datos, puede ofrecer opciones adicionales, dependiendo del
# sistema de base de datos (por ejemplo, para formatear fechas).
SELECT 
    rental_id, 
    CAST(rental_id AS CHAR) AS rental_id_string, 
    CONVERT(rental_date, DATE) AS rental_date_converted
FROM 
    rental
LIMIT 5;

# 6
-- COALESCE: Devuelve el primer valor no nulo de una lista de expresiones. 
SELECT 
    rental_id, 
    COALESCE(return_date, '2024-01-01') AS return_date_or_default 
FROM 
    rental
LIMIT 5;

-- IFNULL: Devuelve el segundo argumento si el primero es NULL. 
SELECT 
    rental_id, 
    IFNULL(return_date, '2024-01-01') AS return_date_or_default 
FROM 
    rental
LIMIT 5;

-- ISNULL: Similar a IFNULL pero con un solo argumento. Devuelve 1 si el valor es NULL, de lo contrario devuelve 0.
-- Está disponible en MySQL.
SELECT 
    rental_id, 
    ISNULL(return_date) AS is_return_date_null 
FROM 
    rental
LIMIT 5;

-- NVL: Función específica de Oracle. 
-- Hace lo mismo que IFNULL, devuelve el segundo argumento si el primero es NULL.
-- Aquí está cómo sería en Oracle:
-- Como NVL no está disponible en MySQL, puedes usar COALESCE o IFNULL en su lugar.
SELECT 
    rental_id, 
    COALESCE(return_date, '2024-01-01') AS return_date_or_default_using_coalesce,
    IFNULL(return_date, '2024-01-01') AS return_date_or_default_using_ifnull
FROM 
    rental
LIMIT 5;