/*-------------------------------------
 Poblado de prueba - UEFA Champions League
 Requiere haber ejecutado antes createDB_script.sql
 Los nombres de personas son ficticios.
--------------------------------------*/

USE UEFA_DB;

-- Orden de inserción respetando las llaves foráneas:
-- pais -> director_tecnico -> equipo -> jugador -> estadio -> partido
-- -> arbitro -> asignacion_arbitral -> evento

/*-------------------------------------
 1. PAIS
--------------------------------------*/
INSERT INTO pais (id_pais, nombre, dir_bandera) VALUES
  ('ESP', 'España',          'img/banderas/ESP.png'),
  ('ENG', 'Inglaterra',      'img/banderas/ENG.png'),
  ('GER', 'Alemania',        'img/banderas/GER.png'),
  ('ITA', 'Italia',          'img/banderas/ITA.png'),
  ('FRA', 'Francia',         'img/banderas/FRA.png'),
  ('POR', 'Portugal',        'img/banderas/POR.png'),
  ('ARG', 'Argentina',       'img/banderas/ARG.png'),
  ('BRA', 'Brasil',          'img/banderas/BRA.png'),
  ('COL', 'Colombia',        'img/banderas/COL.png'),
  ('NED', 'Países Bajos',    'img/banderas/NED.png');

/*-------------------------------------
 2. DIRECTOR_TECNICO
--------------------------------------*/
INSERT INTO director_tecnico (id_tecnico, nombre, id_pais) VALUES
  ('10001', 'Carlos Mendizábal',   'ESP'),
  ('10002', 'Joan Ferrer',         'ESP'),
  ('10003', 'Peter Hallworth',     'ENG'),
  ('10004', 'Arne Kessler',        'NED'),
  ('10005', 'Lukas Brandt',        'GER'),
  ('10006', 'Marco Valentini',     'ITA'),
  ('10007', 'Julien Marchand',     'FRA'),
  ('10008', 'Rui Cardoso',         'POR');

/*-------------------------------------
 3. EQUIPO  (id_tecnico es UNIQUE: un DT por equipo)
--------------------------------------*/
INSERT INTO equipo (id_equipo, nombre, dir_escudo, en_competencia, id_pais, id_tecnico) VALUES
  ('RMA', 'Real Madrid',        'img/escudos/RMA.png', TRUE, 'ESP', '10001'),
  ('BAR', 'FC Barcelona',       'img/escudos/BAR.png', TRUE, 'ESP', '10002'),
  ('MCI', 'Manchester City',    'img/escudos/MCI.png', TRUE, 'ENG', '10003'),
  ('LIV', 'Liverpool',          'img/escudos/LIV.png', TRUE, 'ENG', '10004'),
  ('BAY', 'Bayern München',     'img/escudos/BAY.png', TRUE, 'GER', '10005'),
  ('INT', 'Inter de Milán',     'img/escudos/INT.png', TRUE, 'ITA', '10006'),
  ('PSG', 'Paris Saint-Germain','img/escudos/PSG.png', TRUE, 'FRA', '10007'),
  ('BEN', 'SL Benfica',         'img/escudos/BEN.png', TRUE, 'POR', '10008');

/*-------------------------------------
 4. JUGADOR  (3 por equipo)
--------------------------------------*/
INSERT INTO jugador (id_jugador, nombre, numero, descalificado, id_equipo, id_pais) VALUES
  -- Real Madrid
  ('1000001', 'Álvaro Domínguez',   9, FALSE, 'RMA', 'ESP'),
  ('1000002', 'Thiago Almeida',    10, FALSE, 'RMA', 'BRA'),
  ('1000003', 'Sergio Quiroga',     4, FALSE, 'RMA', 'ESP'),
  -- Barcelona
  ('1000004', 'Pau Ribera',        10, FALSE, 'BAR', 'ESP'),
  ('1000005', 'Nicolás Paredes',    9, FALSE, 'BAR', 'ARG'),
  ('1000006', 'Gerard Solà',        3, TRUE,  'BAR', 'ESP'),   -- descalificado
  -- Manchester City
  ('1000007', 'Jack Wetherby',      7, FALSE, 'MCI', 'ENG'),
  ('1000008', 'Erik Lindqvist',     9, FALSE, 'MCI', 'NED'),
  ('1000009', 'Daniel Ospina',      8, FALSE, 'MCI', 'COL'),
  -- Liverpool
  ('1000010', 'Tom Ashcroft',      11, FALSE, 'LIV', 'ENG'),
  ('1000011', 'Virgil Maas',        4, FALSE, 'LIV', 'NED'),
  ('1000012', 'Felipe Barros',     20, FALSE, 'LIV', 'BRA'),
  -- Bayern
  ('1000013', 'Max Hoffmann',       9, FALSE, 'BAY', 'GER'),
  ('1000014', 'Jonas Reuter',      10, FALSE, 'BAY', 'GER'),
  ('1000015', 'Luis Cardona',      17, FALSE, 'BAY', 'COL'),
  -- Inter
  ('1000016', 'Matteo Ricci',      10, FALSE, 'INT', 'ITA'),
  ('1000017', 'Lautaro Benítez',    9, FALSE, 'INT', 'ARG'),
  ('1000018', 'Stefano Moretti',    1, FALSE, 'INT', 'ITA'),
  -- PSG
  ('1000019', 'Kylian Duval',       7, FALSE, 'PSG', 'FRA'),
  ('1000020', 'Antoine Girard',    10, FALSE, 'PSG', 'FRA'),
  ('1000021', 'Rafael Teixeira',   21, FALSE, 'PSG', 'POR'),
  -- Benfica
  ('1000022', 'João Menezes',       9, FALSE, 'BEN', 'POR'),
  ('1000023', 'Diogo Salvador',    10, FALSE, 'BEN', 'POR'),
  ('1000024', 'Gabriel Oliveira',   5, FALSE, 'BEN', 'BRA');

/*-------------------------------------
 5. ESTADIO
--------------------------------------*/
INSERT INTO estadio (id_estadio, nombre, ciudad, id_pais) VALUES
  ('20001', 'Estadio Santiago Bernabéu', 'Madrid',    'ESP'),
  ('20002', 'Camp Nou',                  'Barcelona', 'ESP'),
  ('20003', 'Etihad Stadium',            'Mánchester','ENG'),
  ('20004', 'Anfield',                   'Liverpool', 'ENG'),
  ('20005', 'Allianz Arena',             'Múnich',    'GER'),
  ('20006', 'San Siro',                  'Milán',     'ITA'),
  ('20007', 'Parc des Princes',          'París',     'FRA'),
  ('20008', 'Estádio da Luz',            'Lisboa',    'POR');

/*-------------------------------------
 6. PARTIDO
 Columnas: num_partido, fecha_hora, goles_local, goles_visitante,
           es_eliminatoria, hubo_tanda_penales, penales_local, penales_visitante,
           temporada, id_estadio, id_equipo_local, id_equipo_visitante
--------------------------------------*/
INSERT INTO partido
  (num_partido, fecha_hora, goles_local, goles_visitante, es_eliminatoria,
   hubo_tanda_penales, penales_local, penales_visitante, temporada,
   id_estadio, id_equipo_local, id_equipo_visitante) VALUES
  -- Fase de liga
  (1,  '2025-09-16 21:00:00', 2, 1, FALSE, FALSE, 0, 0, 2025, '20001', 'RMA', 'BAR'),
  (2,  '2025-09-16 21:00:00', 3, 0, FALSE, FALSE, 0, 0, 2025, '20003', 'MCI', 'LIV'),
  (3,  '2025-09-17 21:00:00', 1, 1, FALSE, FALSE, 0, 0, 2025, '20005', 'BAY', 'INT'),
  (4,  '2025-09-17 21:00:00', 2, 2, FALSE, FALSE, 0, 0, 2025, '20007', 'PSG', 'BEN'),
  (5,  '2025-10-01 21:00:00', 0, 1, FALSE, FALSE, 0, 0, 2025, '20002', 'BAR', 'MCI'),
  (6,  '2025-10-01 21:00:00', 2, 0, FALSE, FALSE, 0, 0, 2025, '20004', 'LIV', 'BAY'),
  (7,  '2025-10-02 21:00:00', 1, 3, FALSE, FALSE, 0, 0, 2025, '20006', 'INT', 'PSG'),
  (8,  '2025-10-02 21:00:00', 0, 2, FALSE, FALSE, 0, 0, 2025, '20008', 'BEN', 'RMA'),
  -- Eliminatorias
  (9,  '2026-03-10 21:00:00', 1, 1, TRUE,  TRUE,  4, 3, 2025, '20001', 'RMA', 'MCI'),
  (10, '2026-03-11 21:00:00', 2, 1, TRUE,  FALSE, 0, 0, 2025, '20005', 'BAY', 'PSG');

/*-------------------------------------
 7. ARBITRO
 NOTA: el CHECK original de arbitro es '^[0,9]+$', que solo acepta los
 caracteres 0, 9 y coma. Por eso estos IDs usan únicamente 0 y 9, de modo
 que el script funciona tanto con el CHECK actual como con '^[0-9]+$'.
--------------------------------------*/
INSERT INTO arbitro (id_arbitro, nombre, id_pais) VALUES
  ('00000', 'Davide Conti',      'ITA'),
  ('00009', 'Felix Baumann',     'GER'),
  ('00090', 'Javier Olmedo',     'ESP'),
  ('00099', 'Stuart Pemberton',  'ENG'),
  ('00900', 'Clément Roussel',   'FRA');

/*-------------------------------------
 8. ASIGNACION_ARBITRAL
 Restricciones: PK (num_partido, id_arbitro) y UNIQUE (num_partido, rol)
--------------------------------------*/
INSERT INTO asignacion_arbitral (num_partido, id_arbitro, rol) VALUES
  -- Partido 1
  (1, '00000', 'Principal'),
  (1, '00009', 'Asistente 1'),
  (1, '00090', 'Asistente 2'),
  (1, '00099', 'Cuarto árbitro'),
  (1, '00900', 'VAR'),
  -- Partido 2
  (2, '00009', 'Principal'),
  (2, '00090', 'Asistente 1'),
  (2, '00099', 'Asistente 2'),
  (2, '00900', 'Cuarto árbitro'),
  (2, '00000', 'VAR'),
  -- Partido 3
  (3, '00090', 'Principal'),
  (3, '00099', 'Asistente 1'),
  (3, '00900', 'Asistente 2'),
  -- Partido 4
  (4, '00099', 'Principal'),
  (4, '00900', 'Asistente 1'),
  (4, '00000', 'Asistente 2'),
  -- Partido 9 (eliminatoria con penales)
  (9, '00900', 'Principal'),
  (9, '00000', 'Asistente 1'),
  (9, '00009', 'Asistente 2'),
  (9, '00090', 'Cuarto árbitro'),
  (9, '00099', 'VAR'),
  -- Partido 10
  (10, '00000', 'Principal'),
  (10, '00099', 'Asistente 1'),
  (10, '00090', 'Asistente 2');

/*-------------------------------------
 9. EVENTO
 periodo: '1T', '2T', 'PEN' (tanda de penales)
--------------------------------------*/
INSERT INTO evento (num_evento, tipo_evento, periodo, minuto, resultado, observaciones, num_partido) VALUES
  -- Partido 1: RMA 2-1 BAR
  (1,  'Gol',              '1T', 15, 'Anotado', 'Gol de Álvaro Domínguez (RMA)',           1),
  (2,  'Tarjeta amarilla', '1T', 27, NULL,      'Gerard Solà (BAR) por falta táctica',      1),
  (3,  'Gol',              '1T', 38, 'Anotado', 'Gol de Pau Ribera (BAR)',                  1),
  (4,  'Sustitución',      '2T', 60, NULL,      'Entra Thiago Almeida por Sergio Quiroga',  1),
  (5,  'Gol',              '2T', 67, 'Anotado', 'Gol de Thiago Almeida (RMA)',              1),
  -- Partido 2: MCI 3-0 LIV
  (6,  'Gol',              '1T', 10, 'Anotado', 'Gol de Jack Wetherby (MCI)',               2),
  (7,  'Gol',              '1T', 44, 'Anotado', 'Gol de Erik Lindqvist (MCI)',              2),
  (8,  'Tarjeta roja',     '2T', 55, NULL,      'Virgil Maas (LIV) por falta grave',        2),
  (9,  'Gol',              '2T', 78, 'Anotado', 'Gol de Daniel Ospina (MCI)',               2),
  -- Partido 3: BAY 1-1 INT
  (10, 'Gol',              '1T', 22, 'Anotado', 'Gol de Max Hoffmann (BAY)',                3),
  (11, 'Gol',              '2T', 81, 'Anotado', 'Gol de Lautaro Benítez (INT)',             3),
  -- Partido 9: RMA 1-1 MCI (penales 4-3)
  (12, 'Gol',              '1T', 33, 'Anotado', 'Gol de Álvaro Domínguez (RMA)',            9),
  (13, 'Gol',              '2T', 72, 'Anotado', 'Gol de Jack Wetherby (MCI)',               9),
  (14, 'Penal',            'PEN', 0, 'Anotado', 'Thiago Almeida (RMA)',                     9),
  (15, 'Penal',            'PEN', 0, 'Anotado', 'Erik Lindqvist (MCI)',                     9),
  (16, 'Penal',            'PEN', 0, 'Fallado', 'Daniel Ospina (MCI) - atajado',            9),
  (17, 'Penal',            'PEN', 0, 'Anotado', 'Sergio Quiroga (RMA)',                     9),
  -- Partido 10: BAY 2-1 PSG
  (18, 'Gol',              '1T',  8, 'Anotado', 'Gol de Kylian Duval (PSG)',               10),
  (19, 'Gol',              '2T', 52, 'Anotado', 'Gol de Jonas Reuter (BAY)',               10),
  (20, 'Gol',              '2T', 88, 'Anotado', 'Gol de Max Hoffmann (BAY)',               10);

/*-------------------------------------
 CONSULTAS DE VERIFICACIÓN
--------------------------------------*/

-- Conteo de filas por tabla
SELECT 'pais' AS tabla, COUNT(*) AS filas FROM pais
UNION ALL SELECT 'director_tecnico', COUNT(*) FROM director_tecnico
UNION ALL SELECT 'equipo', COUNT(*) FROM equipo
UNION ALL SELECT 'jugador', COUNT(*) FROM jugador
UNION ALL SELECT 'estadio', COUNT(*) FROM estadio
UNION ALL SELECT 'partido', COUNT(*) FROM partido
UNION ALL SELECT 'arbitro', COUNT(*) FROM arbitro
UNION ALL SELECT 'asignacion_arbitral', COUNT(*) FROM asignacion_arbitral
UNION ALL SELECT 'evento', COUNT(*) FROM evento;

-- Partidos con nombres de equipos, estadio y árbitro principal
SELECT p.num_partido, p.fecha_hora,
       el.nombre AS local, p.goles_local, p.goles_visitante, ev.nombre AS visitante,
       es.nombre AS estadio, a.nombre AS arbitro_principal
FROM partido p
JOIN equipo el  ON el.id_equipo = p.id_equipo_local
JOIN equipo ev  ON ev.id_equipo = p.id_equipo_visitante
JOIN estadio es ON es.id_estadio = p.id_estadio
LEFT JOIN asignacion_arbitral aa ON aa.num_partido = p.num_partido AND aa.rol = 'Principal'
LEFT JOIN arbitro a ON a.id_arbitro = aa.id_arbitro
ORDER BY p.num_partido;

-- Consistencia: goles registrados como evento vs. marcador (no debe devolver filas)
SELECT p.num_partido, p.goles_local + p.goles_visitante AS goles_marcador,
       COUNT(e.num_evento) AS goles_eventos
FROM partido p
JOIN evento e ON e.num_partido = p.num_partido AND e.tipo_evento = 'Gol'
GROUP BY p.num_partido, p.goles_local, p.goles_visitante
HAVING goles_marcador <> goles_eventos;

/*-------------------------------------
 PRUEBAS NEGATIVAS (descomentar de a una; todas deben FALLAR)
--------------------------------------*/
-- Equipo local = visitante (viola CHECK):
-- INSERT INTO partido (num_partido, fecha_hora, temporada, id_estadio, id_equipo_local, id_equipo_visitante)
--   VALUES (99, '2026-01-01 20:00:00', 2025, '20001', 'RMA', 'RMA');

-- Dos DT para el mismo equipo / DT repetido (viola UNIQUE):
-- INSERT INTO equipo (id_equipo, nombre, id_pais, id_tecnico) VALUES ('XXX', 'Prueba', 'ESP', '10001');

-- Mismo rol dos veces en un partido (viola uk_partido_rol):
-- INSERT INTO asignacion_arbitral (num_partido, id_arbitro, rol) VALUES (1, '00000', 'Principal');

-- País con código en minúsculas (viola CHECK):
-- INSERT INTO pais (id_pais, nombre, dir_bandera) VALUES ('abc', 'Prueba', 'x.png');

-- Equipo inexistente (viola FOREIGN KEY):
-- INSERT INTO jugador (id_jugador, nombre, numero, id_equipo, id_pais) VALUES ('1000099', 'Test', 1, 'ZZZ', 'ESP');
