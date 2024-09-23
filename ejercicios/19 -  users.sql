# 1. Create a user data_analyst
CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'esunsecreto';

# 2. Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';

# 3. Login with this user and try to create a table. Show the result of that operation.

# Resultados:
# SQL Error [1142] [42000]: CREATE command denied to user 'data_analyst'@'localhost' for table 'prueba'

# 4. Try to update a title of a film. Write the update script.

# Con user data_analyst
UPDATE film 
SET title = "Titulo de pelicula"
WHERE film_id = 1;
# Resultados: Updated Rows 1

# 5. With root or any admin user revoke the UPDATE permission. Write the command

REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';
FLUSH PRIVILEGES;

# 6. Login again with data_analyst and try again the update done in step 4. Show the result.

# SQL Error [1142] [42000]: UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'



