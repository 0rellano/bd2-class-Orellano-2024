# 1
# Sin Joins 0.004s
SELECT a.address_id, a.address, postal_code, a.phone, a.district
FROM address a
WHERE a.postal_code NOT IN ('35200', "17886", "83579", "53561", "42399", "18743");


# CON JOIN 0.012s
SELECT a.address_id, a.address, postal_code, a.phone, a.district, ci.city, co.country 
FROM address a
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE a.postal_code NOT IN ('35200', "17886", "83579", "53561", "42399", "18743");

# Crear indice
CREATE INDEX ind_postal_code ON address(postal_code);

# De nuevo con indice Sin Joins 0.002s
SELECT a.address_id, a.address, postal_code, a.phone, a.district
FROM address a
WHERE a.postal_code NOT IN ('35200', "17886", "83579", "53561", "42399", "18743");


# De nuevo con indice CON JOIN 0.005s
SELECT a.address_id, a.address, postal_code, a.phone, a.district, ci.city, co.country 
FROM address a
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE a.postal_code NOT IN ('35200', "17886", "83579", "53561", "42399", "18743");


# 2
SELECT a.first_name FROM actor a;
SELECT a.last_name  FROM actor a ;

# Haciendo varias pruebas en las consultas. La consulta del nombre dura 0.002s mientras que 
# la del apellido 0.001s. Esto se debe a que sakila tiene un indice en la columna de apellido
# de la tabla actor, optimizando la consulta de la misma.


# 3
ALTER TABLE film_text 
ADD FULLTEXT(description);

SELECT film_id, title, description 
FROM film 
WHERE description LIKE '%action%';
# Generalmente da entre 0.008s a 0.005s

SELECT film_id, title, description 
FROM film_text 
WHERE MATCH(description) AGAINST('action');
# Generalmente da entre 0.003s a 0.001s

# En la consulta del like, en cada fila busca la palabra accion.
# En cambio con match utiliza el indice de texto completo, lo que significaria en mas 
# mas rendimiento 
 














