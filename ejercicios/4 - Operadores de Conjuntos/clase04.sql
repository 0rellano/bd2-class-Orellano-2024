USE sakila;

# 1
SELECT f.title, f.special_features
FROM film f
WHERE f.rating LIKE 'PG-13';

# 2
SELECT DISTINCT f.`length` 
FROM film f;

# 3
SELECT f.title, f.rental_rate, f.replacement_cost 
FROM film f
WHERE f.replacement_cost BETWEEN 20 AND 24;

# 4
SELECT f.title, c.name , f.rating , f.special_features 
FROM film f 
JOIN film_category fc ON fc.film_id = f.film_id 
JOIN category c  ON c.category_id = fc.category_id
WHERE f.special_features LIKE '%Behind the Scenes%'

# 5
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id 
JOIN film f on f.film_id = fa.film_id
WHERE  f.title LIKE 'ZOOLANDER FICTION'

# 6
SELECT a.address, ci.city, co.country
FROM store s 
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON ci.city_id = a.city_id 
JOIN country co ON co.country_id = ci.country_id
WHERE s.store_id = 1

# 7
SELECT f1.title AS titulo1, f2.title AS titulo2, f1.rating
FROM film f1
JOIN film f2 ON f1.rating = f2.rating 
AND f1.film_id < f2.film_id;

# 8
SELECT DISTINCT f.title, st.first_name, st.last_name 
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON s.store_id = i.store_id
join staff st ON st.staff_id = s.manager_staff_id  
WHERE s.store_id = 2;


