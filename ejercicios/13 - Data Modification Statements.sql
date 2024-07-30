
# 1
 
INSERT INTO customer(first_name, last_name, create_date, store_id, address_id)
VALUES(
	"Joaquin", 
	"Orellano", 
	NOW(), 
	1, 
	(
		SELECT MAX(a.address_id)
		FROM address a 
		JOIN city c ON c.city_id = a.city_id
		JOIN country c2 on c2.country_id = c.country_id 
		WHERE c2.country = "United States"
	)
);

# 2
INSERT INTO rental(rental_date, customer_id, staff_id, inventory_id)
VALUES (
	NOW(), 
	1, # que customer pongo
	1, # cualquier staff hard?
	(
		SELECT f.film_id
		FROM film f 
		WHERE f.title = "ACADEMY DINOSAUR"
	)
);

# 3

UPDATE film
SET release_year = 2001
WHERE rating = 'G' 
LIMIT 1

UPDATE film
SET release_year = 2002
WHERE rating = 'PG';

UPDATE film
SET release_year = 2003
WHERE rating = 'NC-17';

UPDATE film
SET release_year = 2004
WHERE rating = 'PG-13';

UPDATE film
SET release_year = 2005
WHERE rating = 'R';













