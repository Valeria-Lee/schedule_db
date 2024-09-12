-- Insertaremos primero los datos base. Por ejemplo, los tipos de maestros,
-- materias, carreras, grupos, etc.
-- Trabajaremos solo en base a 2 carreras: ITS e ISC.

INSERT INTO tipos_maestro (descripcion)
values
("inglés"),
("asignatura"),
("tiempo completo"),
("vinculación"),
("contrato");

INSERT INTO materia (nombre)
values
("Progamación avanzada"),
("Concurrencia y paralelismo"),
("Bases de datos II"),
("Redes"),
("Sistemas embebidos"),
("Inglés V"),
("Arquitectura computacional"),
("Estructura de datos II"),
("Graficación"),
("Investigación de operaciones I"),
("Telecomunicaciones"),
("Administración de archivos");

INSERT INTO carrera (nombre)
values
("ITS"),
("ISC");

-- Separación: ejecute hasta acá

INSERT INTO grupo (semestre, clase, id_carrera)
values
(5, "A", 1),
(5, "A", 2),
(5, "B", 2);


