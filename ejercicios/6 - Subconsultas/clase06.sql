USE sakila;

# 1
SELECT a1.first_name AS "Nombre 1", a1.last_name AS "Apellido 1", a2.first_name AS "Nombre 2", a2.last_name AS "Apellido 2"
FROM actor a1
JOIN actor a2 ON a2.last_name = a1.last_name
WHERE a1.actor_id < a2.actor_id;

# 2
SELECT a.first_name, a.last_name 
FROM actor a
WHERE a.actor_id IN (SELECT fa.actor_id FROM film_actor fa);

# 3
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) = 1
);

# 4
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > 1
);

# 5
SELECT a.first_name, a.last_name 
FROM actor a
WHERE a.actor_id = ANY (
	SELECT fa.actor_id
	FROM film_actor fa
	JOIN film f  ON fa.film_id = f.film_id
	WHERE f.title LIKE "BETRAYED REAR"
	OR f.title LIKE "CATCH AMISTAD"
);

# 6
SELECT a.first_name, a.last_name 
FROM actor a
WHERE a.actor_id IN (
	SELECT fa.actor_id
	FROM film_actor fa
	JOIN film f  ON fa.film_id = f.film_id
	WHERE f.title LIKE "BETRAYED REAR"
)
AND a.actor_id NOT IN (
	SELECT fa.actor_id
	FROM film_actor fa
	JOIN film f  ON fa.film_id = f.film_id
	WHERE f.title LIKE "CATCH AMISTAD"
);

# 7 
SELECT a.first_name, a.last_name awdadadw
FROM actor a
WHERE a.actor_id IN (
	SELECT fa.actor_id
	FROM film_actor fa
	JOIN film f  ON fa.film_id = f.film_id
	WHERE f.title LIKE "BETRAYED REAR"
)
AND a.actor_id IN (
	SELECT fa.actor_id
	FROM film_actor fa
	JOIN film f  ON fa.film_id = f.film_id
	WHERE f.title LIKE "CATCH AMISTAD"
);

# 8
SELECT a.first_name, a.last_name 
FROM actor a
WHERE a.actor_id NOT IN (
	SELECT fa.actor_id
	FROM film_actor fa
	JOIN film f  ON fa.film_id = f.film_id
	WHERE f.title LIKE "BETRAYED REAR"
)
AND a.actor_id NOT IN(
	SELECT fa.actor_id
	FROM film_actor fa
	JOIN film f  ON fa.film_id = f.film_id
	WHERE f.title LIKE "CATCH AMISTAD"
);










