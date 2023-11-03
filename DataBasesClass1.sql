-- Creando la base de datos con sus respectivas tablas :D
create database workShop6;
use workshop6;
CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    nombre_usuario VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Publicaciones (
    id INT AUTO_INCREMENT,
    id_usuario INT,
    titulo varchar(50) NOT NULL,
    imagen varchar(50) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

CREATE TABLE Amistad (
    id_usuario1 INT,
    id_usuario2 INT,
    peticion VARCHAR(20) NOT NULL,
    fecha_amigos DATETIME NOT NULL,
    PRIMARY KEY (id_usuario1, id_usuario2),
    FOREIGN KEY (id_usuario1) REFERENCES Usuarios(id),
    FOREIGN KEY (id_usuario2) REFERENCES Usuarios(id)
);
-- Editando la tabla cambiando el valor de un atributo (Tipo de dato)
ALTER TABLE amistad MODIFY COLUMN fecha_amigos DATE;

CREATE TABLE Comentarios (
    id INT AUTO_INCREMENT,
    id_publicacion INT,
    id_usuario INT,
    contenido TEXT NOT NULL,
    fecha_comentario DATETIME NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_publicacion) REFERENCES Publicaciones(id),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);
-- Editando la tabla cambiando el valor de un atributo (Tipo de dato)
ALTER TABLE Comentarios MODIFY COLUMN fecha_comentario DATE;
ALTER TABLE Comentarios MODIFY COLUMN contenido varchar(150);

CREATE TABLE Mensajes (
    id INT AUTO_INCREMENT,
    id_emisor INT,
    id_receptor INT,
    contenido varchar(100) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_emisor) REFERENCES Usuarios(id),
    FOREIGN KEY (id_receptor) REFERENCES Usuarios(id)
);

-- Registrar 5 usuarios
INSERT INTO Usuarios (nombre, apellido, nombre_usuario, correo_electronico) 
VALUES 
('David', 'Useche', 'JacktheRipper0911', 'daviduseche123@gmail.com'),
('Paulina', 'Ocampo', 'Paulioca', 'paulioca@gmail.com'),
('Mateo', 'Espinosa', 'MathewET', 'mathewET@gmail.com'),
('Lugel', 'Franco', 'lugelelCrack', 'lugelFrancoPapi@gmail.com'),
('Viviana', 'Guzman', 'cuteVivi32', 'cuteVivis32@gmail.com');
select * from Usuarios;

-- Registrar 5 relaciones de amistad 
INSERT INTO Amistad (id_usuario1, id_usuario2, peticion, fecha_amigos) 
VALUES 
(1, 2, 'aceptada', '2023-10-28'),
(1, 3, 'pendiente', '2021-11-25'),
(2, 4, 'aceptada', '2022-06-02'),
(3, 5, 'rechazada', '2022-12-18'),
(4, 5, 'aceptada', '2023-10-14');


-- Agregar por lo menos 2 mensajes por cada usuario con amigos diferentes
INSERT INTO Mensajes (id_emisor, id_receptor, contenido) 
VALUES 
(1, 2, 'Hey Paulina, ¿Que mas pueh??'),
(1, 3, 'Que pasa mi bro todo melo o k?'),
(2, 4, 'Profe subame la nota jajaj'),
(3, 5, 'La quiero mucho profe, subame puntos <3'),
(4, 5, 'La gente de backend4 es una chimba');


-- Crear una publicación por cada usuario al menos
INSERT INTO Publicaciones (id_usuario, titulo, imagen, fecha_publicacion) 
VALUES 
(1, 'En un dia soleado con los panas', 'imagenSolecito.jpg','2023-07-09'),
(2, 'El mejor viaje de mi vida!!', 'TorreEiffel.png','2022-11-09'),
(3, 'La vida es bella!', 'this_is_fine_meme.jgp','2023-02-28'),
(4, 'Saliendo de la U', 'universidad_de_medellin.png','2021-12-29'),
(5, 'Me gustan los gatitos con trajecito :3', 'gatito_arcoiris.png','2023-01-22');

-- Añadiendo otra publicacion (Probando cositas)
INSERT INTO Publicaciones (id_usuario, titulo, imagen, fecha_publicacion) 
VALUES (1,'Nueva publicacion numero 2', 'imagen2.png', '2023-10-10');

-- Agregar 2 comentarios en cada publicación creada
INSERT INTO Comentarios (id_publicacion, id_usuario, contenido, fecha_comentario) 
VALUES 
(1, 2, 'Que bueno verte feliz!!', '2023-07-09'),
(1, 3, 'Compartan pola muchachos jaja', '2023-07-09'),
(2, 4, 'Uy invite pueh', '2022-11-09'),
(2, 5, 'Ya fui y es muy lindo :D!', '2022-11-09'),
(3, 1, 'So easy (soy ese)', '2023-02-28'),
(3, 2, 'Confirmo :(', '2023-02-28'),
(4, 3, 'Profe paseme el parcial', '2021-12-29'),
(4, 1, 'Cuidado se le olvidan las llaves esta vez!!', '2021-12-29'),
(5, 4, 'Me gusta los gatitos asi como tu 7u7', '2023-01-22'),
(5, 3, 'Menos los negros', '2023-01-22');
-- Usuario (Lugel) Comentandose a si mismo:
INSERT INTO Comentarios (id_publicacion, id_usuario, contenido, fecha_comentario) 
VALUES (4, 4, "Que fachero te ves Lugel", "2021-12-29");

-- Mostrar todos los usuarios con sus publicaciones y los detalles de las mismas:
SELECT u.nombre, u.apellido, p.titulo 'Publicacion', p.imagen, p.fecha_publicacion from Publicaciones p
inner join Usuarios u on u.id = p.id_usuario;


-- CONSULTAS: 
-- Punto 1 (Hecho):
-- Mostrar publicaciones de un usuario en especifico:
SELECT u.nombre, u.apellido, p.titulo 'Publicacion', p.imagen, p.fecha_publicacion from Publicaciones p
inner join Usuarios u on u.id = p.id_usuario where u.id = 1;

-- Punto 2 (Hecho):
-- Buscar publicaciones con cierta palabra clave:
SELECT u.nombre, u.apellido, p.titulo 'Publicacion', p.imagen, p.fecha_publicacion FROM usuarios u
INNER JOIN publicaciones p ON u.id = p.id_usuario WHERE p.titulo LIKE '%con%';

-- Punto 3 (Hecho): 
-- Mostrar los comentarios de una publicacion de un usuario en especifico:
SELECT u.nombre AS nombre_usuario, u.apellido AS apellido_usuario, p.titulo, c.id AS id_comentario, c.contenido AS contenido_comentario, com.nombre AS nombre_comentador
FROM usuarios u
INNER JOIN publicaciones p ON u.id = p.id_usuario
INNER JOIN comentarios c ON p.id = c.id_publicacion
INNER JOIN usuarios com ON c.id_usuario = com.id
WHERE id_publicacion = 2;

-- Punto 4 (Hecho):
-- Encontrar los amigos de un usuario en especifico:
SELECT u.nombre 'nombre_amigo', u.apellido
FROM Usuarios u
INNER JOIN Amistad a ON (u.id = a.id_usuario1 OR u.id = a.id_usuario2)
WHERE u.id <> 2
AND a.peticion = 'aceptada'
AND (a.id_usuario1 = 2 OR a.id_usuario2 = 2);
-- Nota: Aqui se busca los amigos del usuario, por lo cual se debe poner el mismo ID que se busca 
-- En los dos usuarios (a.id_usuario1 / a.id_usuario2)

-- Punto 5 (Hecho): 
-- Contar la cantidad de amigos de un usuario:
SELECT COUNT(*) AS cantidad_amigos
FROM Amistad a
WHERE (a.id_usuario1 = 1 OR a.id_usuario2 = 1)
AND a.peticion = 'aceptada';

-- Punto 6 (Hecho):
-- Mostrar las publicaciones de los amigos de un usuario:
SELECT u.nombre 'Nombre del amigo', u.apellido,  p.*
FROM Publicaciones p
INNER JOIN Usuarios u ON u.id = p.id_usuario
INNER JOIN Amistad a ON p.id_usuario = a.id_usuario2
WHERE a.id_usuario1 = 1
AND a.peticion = 'aceptada';

-- Punto 7 (Hecho):
-- Listar los usuarios que han comentado:
SELECT u.nombre, u.apellido
FROM Usuarios u
INNER JOIN Comentarios c ON u.id = c.id_usuario
WHERE c.id_publicacion = 1;

-- Punto 8 (Hecho):
-- Buscar amigos que aún no han aceptado la solicitud de amistad
SELECT u.nombre, u.apellido FROM usuarios u
INNER JOIN Amistad a ON u.id = a.id_usuario1 OR u.id = a.id_usuario2
WHERE a.peticion = 'pendiente';
-- Aqui se muestra la relacion de los dos usuarios pendientes por aceptar su solicitud de amistad

-- Punto 9 (Hecho): 
-- Mostrar las publicaciones más recientes ordenadas por fecha:
SELECT u.nombre 'Usuario', p.titulo 'Publicacion', p.imagen, p.fecha_publicacion FROM Publicaciones p 
INNER JOIN Usuarios u ON u.id = p.id_usuario
ORDER BY fecha_publicacion DESC;

-- Punto 10 (Hecho): 
-- Mostrar la actividad reciente (publicaciones y comentarios) de un usuario:
SELECT id_usuario, titulo 'Actividad', fecha_publicacion 'fecha_actividad', 'publicacion' AS tipo
FROM Publicaciones
WHERE id_usuario = 1
UNION 
SELECT id_usuario, contenido, fecha_comentario 'fecha_actividad', 'comentario' AS tipo
FROM Comentarios
WHERE id_usuario = 1
ORDER BY fecha_actividad DESC;

-- Punto 11 (Hecho):
-- Encontrar las publicaciones de amigos en un rango de fechas:
SELECT u.nombre 'Nombre del amigo', u.apellido,  p.*
FROM Publicaciones p
INNER JOIN Usuarios u ON u.id = p.id_usuario
INNER JOIN Amistad a ON p.id_usuario = a.id_usuario2
WHERE a.id_usuario1 = 1
AND a.peticion = 'aceptada'
AND fecha_publicacion BETWEEN '2021-01-01' AND '2023-12-09';

-- Punto 12 (Hecho):
-- Obtener los usuarios que han enviado mensajes a otro usuario:
SELECT DISTINCT u.nombre, u.apellido
FROM Usuarios u
INNER JOIN Mensajes m ON u.id = m.id_emisor
WHERE m.id_receptor = 5;
-- Nota: Aqui se esta mostrando el nombre/apellido de las personas que le han escrito al usuario especifico usando su ID
 
-- Punto 13 (Hecho): 
-- Mostrar los mensajes entre dos usuarios:
SELECT *
FROM Mensajes
WHERE (id_emisor = 3 AND id_receptor = 5)
   OR (id_emisor = 2 AND id_receptor = 1)
ORDER BY id;

-- Punto 14 (Hecho):
-- Encontrar usuarios que no tienen amigos:
SELECT nombre, apellido
FROM Usuarios
WHERE id NOT IN (
    SELECT id_usuario1 FROM Amistad WHERE peticion = 'aceptada'
    UNION
    SELECT id_usuario2 FROM Amistad WHERE peticion = 'aceptada'
);

-- Punto 15 (Hecho):
-- Mostrar los usuarios que han comentado sus propias publicaciones:
SELECT u.nombre, u.apellido
FROM Usuarios u
INNER JOIN Publicaciones p ON u.id = p.id_usuario
INNER JOIN Comentarios c ON p.id = c.id_publicacion
WHERE c.id_usuario = p.id_usuario;

-- Punto 16 (Hecho):
-- Listar las 3 publicaciones más comentadas:
SELECT p.*, COUNT(c.id) AS cantidad_comentarios
FROM Publicaciones p
LEFT JOIN Comentarios c ON p.id = c.id_publicacion
GROUP BY p.id
ORDER BY cantidad_comentarios DESC
LIMIT 3;












