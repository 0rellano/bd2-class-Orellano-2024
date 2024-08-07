
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


# 4

UPDATE rental
SET return_date = NOW()
WHERE rental_id = (
	SELECT rental_id 
	WHERE return_date IS NULL
	ORDER BY rental_date DESC
	LIMIT 1
);


# 5

DELETE FROM film WHERE film_id = 1;
# SQL Error [1451] [23000]: Cannot delete or update a parent row: a foreign key 
# constraint fails (`sakila`.`film_actor`, CONSTRAINT `fk_film_actor_film` FOREIGN 
# KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE RESTRICT ON UPDATE CASCADE)
DELETE FROM film_actor WHERE film_id = 1;
DELETE FROM film_category WHERE film_id = 1;
DELETE FROM rental WHERE inventory_id IN (
	SELECT inventory_id
	FROM inventory
	WHERE film_id = 1
);
DELETE FROM inventory WHERE film_id = 1;
# you can delete the film
DELETE FROM film WHERE film_id = 1;


# 6

SELECT i.inventory_id 
FROM inventory i 
WHERE  i.inventory_id NOT IN (
	SELECT r.inventory_id 
	FROM rental r
	WHERE r.return_date IS NUll
)
LIMIT 1;
# inventory id = 9

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (
	NOW(), 
	9,
	(SELECT MIN(c.customer_id) FROM customer c),
	(SELECT MIN(s.staff_id)
		FROM staff s 
		WHERE store_id = (
			SELECT i.store_id 
			FROM inventory i
			WHERE inventory_id = 9
		)
		LIMIT 1
	)
);

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (
	(SELECT MIN(c.customer_id) FROM customer c),
	(SELECT MIN(s.staff_id)
		FROM staff s 
		WHERE store_id = (
			SELECT i.store_id 
			FROM inventory i
			WHERE inventory_id = 9
		)
		LIMIT 1
	),
	(SELECT rental_id 
		FROM rental 
		WHERE inventory_id  = 9 
		AND customer_id = (SELECT MIN(c.customer_id) FROM customer c
	),
	666,
	NOW()
)
























