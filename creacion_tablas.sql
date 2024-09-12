-- La base de datos modela un sistema escolar, con maestros, materias, grupos, asignación
-- de maestros a materias, etc. 

CREATE TABLE tipos_maestro (
	id_tipo_maestro INTEGER PRIMARY KEY AUTOINCREMENT,
	descripcion TEXT NOT NULL
);

CREATE TABLE maestro (
	id_maestro INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	tipo_maestro INTEGER NOT NULL,
	FOREIGN KEY (tipo_maestro) REFERENCES tipos_maestro(id_tipo_maestro)
);

CREATE TABLE materia (
	id_materia INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL
);

CREATE TABLE carrera (
	id_carrera INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL
);

-- Un grupo puede ser, por ejemplo, 5to. semestre "A" de ITS

CREATE TABLE grupo (
	id_grupo INTEGER PRIMARY KEY AUTOINCREMENT,
	semestre INTEGER NOT NULL CHECK (semestre >= 1 and semestre <= 12),
	-- "A" o "B", por ejemplo
	clase TEXT NOT NULL,
	id_carrera INTEGER NOT NULL,
	FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera)
);

-- La tabla representa la relación entre un grupo y una materia (a un grupo se le asignan varias materias y
-- una materia puede ser llevada por varios grupos)
-- No usamos id_grupo porque, por ejemplo, dos registros de grupo pueden llevar las mismas materias (los grupos
-- 1 "A" y 1 "B" de ISC llevan las mismas materias, por ejemplo)

CREATE TABLE grupo_materia (
	semestre INTEGER NOT NULL,
	id_carrera INTEGER NOT NULL,
	id_materia INTEGER NOT NULL,
	horas_semanales INTEGER NOT NULL,
	-- claves foráneas: id_carrera y id_materia
	FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera),
	FOREIGN KEY (id_materia) REFERENCES materia(id_materia),
	-- La combinación debe ser única, para asegurar la integridad de los datos 
	UNIQUE (semestre, id_carrera, id_materia)
);

-- La tabla representa la relación entre un profesor y la materia que da, con la información de a qué 
-- grupo le imparte la materia (esto puede ser null al principio, cuando aún no tiene asignado los grupos)

CREATE TABLE maestro_materia (
	id_maestro INTEGER NOT NULL, 
	id_materia INTEGER NOT NULL,
	id_grupo INTEGER DEFAULT NULL,
	-- todas las columnas son claves foráneas
	FOREIGN KEY (id_maestro) REFERENCES maestro(id_maestro),
	FOREIGN KEY (id_materia) REFERENCES materia(id_materia),
	FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo),
	UNIQUE (id_maestro, id_materia, id_grupo)
);

-- La tabla representa el horario disponible de maestros de tiempo completo (o de otro tipo de maestro,
-- conforme la marcha)

CREATE TABLE horario_disponible_maestro (
	id_maestro INTEGER NOT NULL PRIMARY KEY, 
	hora_inicio INTEGER NOT NULL,
	hora_fin INTEGER NOT NULL,
	-- id_maestro es una clave foránea a la tabla maestro
	FOREIGN KEY (id_maestro) REFERENCES maestro(id_maestro)
);

