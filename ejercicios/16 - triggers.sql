# 1
insert  into 
	`employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) 
values
	(1076,'Firrelli','Jeff','x9273', null,'1',1002,'VP Marketing');
# No se puede crear porque la columna email tiene una constraint NOT NULL. 


# 2
# a
UPDATE employees SET employeeNumber = employeeNumber - 20;
# Actualiza los numeros de empleados y registra los valores antiguos en la tabla employees_audit por el trigger
UPDATE employees SET employeeNumber = employeeNumber + 20;
# Intenta actualizar  los numeros de empleados, sin embargo, no puede porque se repite la pk

# 3
ALTER TABLE employees
ADD COLUMN edad INT;

ALTER TABLE employees
ADD CONSTRAINT chk_edad CHECK (edad BETWEEN 16 AND 70);
# intento de empleados
insert  into 
	`employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`, edad) 
values
	(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President', 15);
insert  into 
	`employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`, edad) 
values
	(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President', 71);
# En ambos casos tira error 3819. Constraint violada

# 4
# La tabla film_actor actúa como una tabla de unión que conecta film y actor (la relación de muchos a muchos 
# entre películas y actores) La integridad referencial se mantiene porque las claves foráneas en 
# film_actor (que son film_id y actor_id) están vinculadas a las claves primarias de las tablas film 
# y actor.

# 5
ALTER TABLE employees
ADD COLUMN lastUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

delimiter $$
create trigger before_update_employees
before update on employees
for each row
begin
	set new.lastUpdate=now();
end$$
delimiter ;

delimiter $$
create trigger before_insert_employees
before insert on employees
for each row
begin
	set new.lastUpdate=now();
end$$
delimiter ;

# 6
# Trigger 1  
DELIMITER ;;
CREATE TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END;;
 # Despues de que se inserte la pelicula, se añade en fiml text el id, title y description

 # Trigger 2
CREATE TRIGGER `upd_film` AFTER UPDATE ON `film` FOR EACH ROW BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END;;
 # Despues de que se actualiza la tabla film, Si el titulo o la descripcion o el id es distinto. 
 # Actualiza la tabla film_text con la nueva informacion


CREATE TRIGGER `del_film` AFTER DELETE ON `film` FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END;;
 # Despues de que se elimine una tabla, tambien se elimina en la tabla film_text

DELIMITER ;









