# 1 - Get the amount of cities per country in the database. Sort them by country, country_id.
SELECT c.country_id, c.country, COUNT(c2.country_id) AS count_city
FROM country c 
JOIN city c2 ON c.country_id = c2.country_id 
GROUP BY c2.country_id;


# 2 - Get the amount of cities per country in the database. Show only the countries with more than 
# 10 cities, order from the highest amount of cities to the lowest

SELECT c.country_id, c.country, COUNT(c2.country_id) AS count_city
FROM country c 
JOIN city c2 ON c.country_id = c2.country_id 
GROUP BY c2.country_id
HAVING COUNT(*) > 10
ORDER BY COUNT(*) DESC;

# 3 - Generate a report with customer (first, last) name, address, total films rented and the
# total money spent renting films.
# 		*  Show the ones who spent more money first .

SELECT 
	CONCAT(c.first_name, " ", c.last_name) AS name, 
	a.address,
	COUNT(r.rental_id) AS total_film_rented,
	SUM(p.amount) AS total_money_spent
FROM customer c 
JOIN address a ON c.address_id = a.address_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p on r.rental_id = p.rental_id
GROUP BY c.customer_id
ORDER BY total_money_spent DESC;


# 4 - Which film categories have the larger film duration (comparing average)?
# 		* Order by average in descending order

SELECT c.category_id, c.name, AVG(f.`length`) as avg_length
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.category_id
ORDER BY avg_length;


# 5 - Show sales per film rating

SELECT f.rating, COUNT(*) AS sales
FROM film f
JOIN inventory i ON i.film_id  = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY f.rating 





