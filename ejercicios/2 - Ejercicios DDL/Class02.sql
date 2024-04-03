-- Creacion de base de datos imdb
CREATE DATABASE IF NOT EXISTS imdb;

-- Creacion de tablas film, actor y film_actor
USE imdb;

CREATE TABLE IF NOT EXISTS film(
    film_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255),
    description TEXT,
    release_year YEAR,
    PRIMARY KEY (film_id)
);

CREATE TABLE IF NOT EXISTS actor (
    actor_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    PRIMARY KEY (actor_id)
);

CREATE TABLE IF NOT EXISTS film_actor (
    actor_id INT NOT NULL,
    film_id INT NOT NULL,
    PRIMARY KEY (actor_id, film_id)
);

-- Modificacion de tablas "last_update"
ALTER TABLE film
ADD COLUMN last_update DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE actor
ADD COLUMN last_update DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Modificacion agregar fks a film_actor
ALTER TABLE film_actor
ADD CONSTRAINT fk_film_actor_actor_id FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
ADD CONSTRAINT fk_film_actor_film_id FOREIGN KEY (film_id) REFERENCES film(film_id);

# Agregado de datos
INSERT INTO actor (first_name, last_name) VALUES
('Tom', 'Hanks'),
('Leonardo', 'DiCaprio'),
('Scarlett', 'Johansson'),
('Robert', 'Downey Jr.'),
('Meryl', 'Streep');

INSERT INTO film (title, description, release_year) VALUES
('Forrest Gump', 'La vida de un hombre simple desde los años 50 hasta los 90.', 1994),
('Titanic', 'Una historia de amor épica en medio del desastre del Titanic.', 1997),
('Lost in Translation', 'Dos extraños se encuentran en Tokio y forman un vínculo inesperado.', 2003),
('Iron Man', 'Un genio, multimillonario, filántropo se convierte en un superhéroe.', 2008),
('The Devil Wears Prada', 'Una joven recién graduada trabaja para una editora de moda exigente.', 2006);

INSERT INTO film_actor (actor_id, film_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(2, 1),
(3, 2),
(4, 3),
(5, 4);

