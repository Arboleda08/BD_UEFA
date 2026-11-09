/*-------------------------------------
 Data Base UEFA Champions League
--------------------------------------*/
-- Ordenado por referencias

CREATE DATABASE IF NOT EXISTS UEFA_DB; USE UEFA_DB;

CREATE TABLE IF NOT EXISTS pais 
  ( id_pais CHAR(3) PRIMARY KEY, CHECK(id_pais REGEXP '^[A-Z]+$'),
  nombre VARCHAR(80) NOT NULL, 
  dir_bandera VARCHAR(100) NOT NULL) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS director_tecnico 
  ( id_tecnico CHAR(5) PRIMARY KEY, CHECK(id_tecnico REGEXP '^[0-9]+$'), 
  nombre VARCHAR(100) NOT NULL, 
-- Foreign Keys
  id_pais CHAR(3), FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS equipo 
  ( id_equipo CHAR(3) PRIMARY KEY, CHECK(id_equipo REGEXP '^[A-Z]+$'),
  nombre VARCHAR(80) NOT NULL, 
  dir_escudo VARCHAR(100), 
  en_competencia BOOLEAN DEFAULT TRUE, 
  -- Foreign Keys
  id_pais CHAR(3), FOREIGN KEY (id_pais) REFERENCES pais(id_pais), 
  id_tecnico CHAR(5) UNIQUE, FOREIGN KEY (id_tecnico) REFERENCES director_tecnico(id_tecnico) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS jugador 
  ( id_jugador VARCHAR(7) PRIMARY KEY, CHECK(id_jugador REGEXP '^[0-9]+$'),
  nombre VARCHAR(100) NOT NULL, 
  numero TINYINT UNSIGNED NOT NULL,
  descalificado BOOLEAN DEFAULT FALSE, 
  -- Foreign Keys
  id_equipo CHAR(3), FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo), 
  id_pais CHAR(3), FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS estadio 
  ( id_estadio CHAR(5) PRIMARY KEY, CHECK(id_estadio REGEXP '^[0-9]+$'), 
  nombre VARCHAR(100) NOT NULL, 
  ciudad VARCHAR(100) NOT NULL,  
  -- Foreign Keys
  id_pais CHAR(3), FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS partido 
  ( num_partido  SMALLINT UNSIGNED PRIMARY KEY, 
  fecha_hora TIMESTAMP NOT NULL, 
  goles_local TINYINT UNSIGNED DEFAULT 0, 
  goles_visitante TINYINT UNSIGNED DEFAULT 0, 
  es_eliminatoria BOOLEAN DEFAULT FALSE, 
  hubo_tanda_penales BOOLEAN DEFAULT FALSE, 
  penales_local TINYINT UNSIGNED DEFAULT 0, 
  penales_visitante TINYINT UNSIGNED DEFAULT 0, temporada INT NOT NULL, 
  -- Foreign Keys
  id_estadio CHAR(5), FOREIGN KEY (id_estadio) REFERENCES estadio(id_estadio), 
  id_equipo_local CHAR(3), FOREIGN KEY (id_equipo_local) REFERENCES equipo(id_equipo), 
  id_equipo_visitante CHAR(3), FOREIGN KEY (id_equipo_visitante) REFERENCES equipo(id_equipo),
  -- Extra verifications
  CHECK (id_equipo_local <> id_equipo_visitante) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS arbitro 
  ( id_arbitro CHAR(5) PRIMARY KEY, CHECK(id_arbitro REGEXP '^[0,9]+$'), 
  nombre VARCHAR(100) NOT NULL,
  -- Foreign Keys
  id_pais CHAR(3), FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS asignacion_arbitral 
  ( rol VARCHAR(24) NOT NULL, 
  PRIMARY KEY (num_partido, id_arbitro),
  -- Foreign Keys
  num_partido SMALLINT UNSIGNED, FOREIGN KEY (num_partido) REFERENCES partido(num_partido),
  id_arbitro CHAR(5), FOREIGN KEY (id_arbitro) REFERENCES arbitro(id_arbitro),
  -- Extra verifications
  CONSTRAINT uk_partido_rol UNIQUE (num_partido, rol) ) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS evento 
  ( num_evento SMALLINT UNSIGNED PRIMARY KEY, 
  tipo_evento VARCHAR(24) NOT NULL, 
  periodo VARCHAR(8) NOT NULL, 
  minuto TINYINT UNSIGNED NOT NULL,
  resultado VARCHAR(24), 
  observaciones VARCHAR(100), 
  -- Foreign Keys
  num_partido SMALLINT UNSIGNED, FOREIGN KEY (num_partido) REFERENCES partido(num_partido) ) ENGINE=InnoDB;
