/*Data Base UEFA Champions League*/

CREATE DATABASE IF NOT EXISTS UEFA_DB; USE UEFA_DB;

CREATE TABLE IF NOT EXISTS pais ( id_pais CHAR(3) PRIMARY KEY, nombre VARCHAR(80) NOT NULL, dir_bandera VARCHAR(100) NOT NULL) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS director_tecnico ( id_tecnico INT PRIMARY KEY, nombre VARCHAR(100) NOT NULL, id_pais CHAR(3), FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS equipo ( id_equipo INT PRIMARY KEY, nombre VARCHAR(80) NOT NULL, id_pais CHAR(3), id_tecnico INT UNIQUE, dir_escudo VARCHAR(100), en_competencia BOOLEAN DEFAULT TRUE, FOREIGN KEY (id_pais) REFERENCES pais(id_pais), FOREIGN KEY (id_tecnico) REFERENCES director_tecnico(id_tecnico) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS jugador ( id_jugador VARCHAR(7) PRIMARY KEY, nombre VARCHAR(100) NOT NULL, numero TINYINT UNSIGNED NOT NULL, id_equipo INT, id_pais CHAR(3), descalificado BOOLEAN DEFAULT FALSE, CHECK(id_jugador = '^[0-9]+$'), FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo), FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS estadio ( id_estadio INT PRIMARY KEY, nombre VARCHAR(100) NOT NULL, ciudad VARCHAR(100) NOT NULL, id_pais CHAR(3), FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS partido ( id_partido INT PRIMARY KEY, fecha_hora TIMESTAMP NOT NULL, id_estadio INT, id_equipo_local INT, id_equipo_visitante INT, goles_local TINYINT UNSIGNED DEFAULT 0, goles_visitante TINYINT UNSIGNED DEFAULT 0, es_eliminatoria BOOLEAN DEFAULT FALSE, hubo_tanda_penales BOOLEAN DEFAULT FALSE, penales_local TINYINT UNSIGNED DEFAULT 0, penales_visitante TINYINT UNSIGNED DEFAULT 0, CHECK (id_equipo_local <> id_equipo_visitante), temporada INT NOT NULL, FOREIGN KEY (id_estadio) REFERENCES estadio(id_estadio), FOREIGN KEY (id_equipo_local) REFERENCES equipo(id_equipo), FOREIGN KEY (id_equipo_visitante) REFERENCES equipo(id_equipo) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS arbitro ( id_arbitro INT PRIMARY KEY, nombre VARCHAR(100) NOT NULL, id_pais CHAR(3), FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS asignacion_arbitral ( id_partido INT NOT NULL, id_arbitro INT NOT NULL, rol VARCHAR(24) NOT NULL, PRIMARY KEY (id_partido, id_arbitro), CONSTRAINT uk_partido_rol UNIQUE (id_partido, rol), FOREIGN KEY (id_partido) REFERENCES partido(id_partido), FOREIGN KEY (id_arbitro) REFERENCES arbitro(id_arbitro) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS evento ( id_evento INT PRIMARY KEY, id_partido INT NOT NULL, tipo_evento VARCHAR(24) NOT NULL, periodo VARCHAR(8) NOT NULL, minuto TINYINT UNSIGNED, minuto_adicional TINYINT UNSIGNED, orden SMALLINT UNSIGNED, resultado VARCHAR(16), observaciones TEXT, CONSTRAINT uk_partido_orden UNIQUE (id_partido, orden), FOREIGN KEY (id_partido) REFERENCES partido(id_partido) ) ENGINE=InnoDB;