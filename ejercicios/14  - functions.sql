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







