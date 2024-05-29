# CLASE 11

# 4. Find all the film titles that are not in the inventory.
SELECT f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.film_id IS NULL;

# 5. Find all the films that are in the inventory but were never rented.
SELECT f.title, i.inventory_id
FROM inventory i
LEFT JOIN film f ON i.film_id = f.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

# 6. Generate a report with:
# 		- customer (first, last) name, store id, film title,
# 		- when the film was rented and returned for each of these customers
# 		- order by store_id, customer last_name
SELECT 
	CONCAT(c.first_name, " ", c.last_name) AS customer_name,
    s.store_id,
    f.title,
    r.rental_date,
    r.return_date
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id
JOIN store s ON c.store_id = s.store_id
ORDER BY s.store_id, customer_name;

# 7. Show sales per store (money of rented films)
#		- show store's city, country, manager info and total sales (money)
#		- (optional) Use concat to show city and country and manager first and last name
SELECT 
    CONCAT(c.city, " ", co.country) AS store_location,
    CONCAT(st.first_name, " ", st.last_name) AS manager_name,
    s.store_id,
    SUM(p.amount) AS total_sales
FROM store s
JOIN staff st ON s.manager_staff_id = st.staff_id
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
JOIN customer cu ON s.store_id = cu.store_id
JOIN rental r ON cu.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id, store_location, manager_name;




SELECT *
FROM store s;

