CREATE DATABASE Pintagram;
\c Pintagram
CREATE TABLE Users(
  id SERIAL,
  first_name varchar,
  last_name varchar,
  email varchar,
  PRIMARY KEY (id)
);

CREATE TABLE Images(
  id SERIAL,
  img_name varchar,
  owner_id INTEGER,
  PRIMARY KEY (id),
  FOREIGN KEY (owner_id) REFERENCES Users(id)
);

CREATE TABLE EvaluatedImages(
  id SERIAL,
  terrible_like BOOLEAN,
  user_id INTEGER,
  img_id INTEGER,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (img_id) REFERENCES Images(id)
);

CREATE TABLE Tags(
  id SERIAL,
  tag_name varchar,
  PRIMARY KEY (id)
);

CREATE TABLE Tagging(
  id SERIAL,
  tag_id INTEGER,
  img_id INTEGER,
  PRIMARY KEY (id),
  FOREIGN KEY (img_id) REFERENCES Images(id),
  FOREIGN KEY (tag_id) REFERENCES Tags(id)
);

INSERT INTO Users(first_name, last_name, email) VALUES 
('Daniel', 'Hidalgo', 'daniel@gmail.com'),
('Ignacio', 'Garces', 'ignacio@gmail.com'),
('Valentina', 'Gutierrez', 'vale@gmail.com'),
('Viviana', 'Fajardo', 'vivi@gmail.com');
-- Ingresar 2 imágenes por usuario.
INSERT INTO Images(img_name, owner_id) VALUES 
('imagen_de_daniel1.jpg', '1'), 
('imagen_de_daniel2.jpg', '1'),
('imagen_de_ignacio1.jpg', '2'),
('imagen_de_ignacio2.jpg', '2');
('imagen_de_vale1.jpg', '3'), 
('imagen_de_vale2.jpg', '3'),
('imagen_de_vivi1.jpg', '4'),
('imagen_de_vivi2.jpg', '4');
-- Ingresar 3 likes por cada imagen.
INSERT INTO EvaluatedImages(terrible_like, user_id, img_id) VALUES 
(true, 2, 1), (true, 3, 1), (true, 4, 1),
(true, 2, 2), (true, 3, 2), (true, 4, 2),
(true, 1, 3), (true, 3, 3), (true, 4, 3),
(true, 1, 4), (true, 3, 4), (true, 4, 4),
(true, 1, 5), (true, 2, 5), (true, 4, 5),
(true, 1, 6), (true, 2, 6), (true, 4, 6),
(true, 1, 7), (true, 2, 7), (true, 3, 7),
(true, 1, 8), (true, 2, 8), (true, 3, 8);

-- Ingresar 8 tags.
INSERT INTO Tags(tag_name) VALUES
('Dog'), ('Cat'), ('Nature'), ('Art'), ('Movie'), ('Games'), ('Tech'), ('Vape');
-- Ingresar 3 tags por imagen.
INSERT INTO Tagging(tag_id, img_id) VALUES
(1,1),(3,1),(4,1),
(2,2),(6,2),(7,2),
(4,3),(7,3),(8,3); 
-- Crear una consulta que muestre el nombre de la imagen y la cantidad de likes que tiene esa imagen.
SELECT img_name, COUNT(EvaluatedImages) FROM Images FULL JOIN EvaluatedImages ON (Images.id = img_id) GROUP BY img_name;
-- Crear una consulta que muestre el nombre del usuario y los nombres de las fotos que le pertenecen.
SELECT first_name, last_name, img_name FROM Users INNER JOIN Images ON (Users.id = owner_id) GROUP BY first_name;
-- Crear una consulta que muestre el nombre del tag y la cantidad de imagenes asociadas a ese tag.
SELECT tag_name, COUNT(Images) 
FROM ((Tags INNER JOIN Taggging ON Tags.id = tag_id) INNER JOIN Images ON img_id = Images.id);