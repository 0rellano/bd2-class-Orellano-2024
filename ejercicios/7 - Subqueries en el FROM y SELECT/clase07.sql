USE sakila;
# CLASE 7

# 1 - Find the films with less duration, show the title and rating.
UPDATE film 
SET `length` = 46
WHERE film_id = 15


SELECT f.film_id, f.title, f.rating, f.`length` 
FROM film f
WHERE NOT f.`length` > ANY (
	SELECT f2.`length`
	FROM film f2 
);


# 2 - Write a query that returns the tiltle of the film which duration is the lowest. If there are more than one film with the lowest durtation, the query returns an empty resultset.
UPDATE film 
SET `length` = 45
WHERE film_id = 15

SELECT f.film_id, f.title, f.rating, f.`length` 
FROM film f
WHERE f.`length` < ALL (
	SELECT f2.`length`
	FROM film f2
	WHERE f2.film_id <> f.film_id
);


# 3 - Generate a report with list of customers showing the lowest payments done by each of them. 
# Show customer information, the address and the lowest amount, provide both solution using ALL and/or 
# ANY MIN.

# Report of customers with ANY lowest amount
SELECT c.customer_id,  c.last_name, c.first_name, a.address, (
	SELECT MIN(p.amount) 
	FROM payment p
	WHERE c.customer_id = p.customer_id
	GROUP BY p.customer_id 
) AS min_payment
FROM customer c
JOIN address a ON c.address_id = a.address_id 

# Report of customers with REAL lowest amount
SELECT c.customer_id,  c.last_name, c.first_name, a.address, (
	SELECT p.amount
	FROM payment p
	WHERE c.customer_id = p.customer_id
	AND p.amount < ALL (
		SELECT p2.amount
		FROM payment p2
		WHERE c.customer_id = p2.customer_id 
		AND p.payment_id != p2.payment_id
		
	)

) AS min_payment 
FROM customer c
JOIN address a ON c.address_id = a.address_id 


# 4 - Generate a report that shows the customer's information with the highest
#  payment and the lowest payment in the same row.

SELECT c.customer_id,  c.last_name, c.first_name, (
		SELECT MIN(p.amount) 
		FROM payment p
		WHERE c.customer_id = p.customer_id
		GROUP BY p.customer_id 
	) AS min_payment,
(
	SELECT MAX(p.amount) 
	FROM payment p
	WHERE c.customer_id = p.customer_id
	GROUP BY p.customer_id
) AS max_payment
FROM customer c
JOIN address a ON c.address_id = a.address_id 
















