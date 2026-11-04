-- =========================================
-- DATOS DE PRUEBA
-- =========================================

-- 1) PAIS
INSERT INTO pais (id_pais, nombre, dir_bandera) VALUES
('COL', 'Colombia',  '/img/banderas/col.png'),
('ARG', 'Argentina', '/img/banderas/arg.png'),
('BRA', 'Brasil',    '/img/banderas/bra.png'),
('URU', 'Uruguay',   '/img/banderas/uru.png'),
('ESP', 'España',    '/img/banderas/esp.png'),
('ITA', 'Italia',    '/img/banderas/ita.png'),
('MEX', 'México',    '/img/banderas/mex.png'),
('ECU', 'Ecuador',   '/img/banderas/ecu.png');

-- 2) DIRECTOR_TECNICO
INSERT INTO director_tecnico (id_tecnico, nombre, id_pais) VALUES
(1, 'Néstor Lorenzo',   'ARG'),
(2, 'Lionel Scaloni',   'ARG'),
(3, 'Dorival Júnior',   'BRA'),
(4, 'Marcelo Bielsa',   'ARG');

-- 3) EQUIPO (id_tecnico es UNIQUE: uno distinto por equipo)
INSERT INTO equipo (id_equipo, nombre, id_pais, id_tecnico, dir_escudo, en_competencia) VALUES
(1, 'Selección Colombia',   'COL', 1, '/img/escudos/col.png', TRUE),
(2, 'Selección Argentina',  'ARG', 2, '/img/escudos/arg.png', TRUE),
(3, 'Selección Brasil',     'BRA', 3, '/img/escudos/bra.png', TRUE),
(4, 'Selección Uruguay',    'URU', 4, '/img/escudos/uru.png', TRUE);

-- 4) JUGADOR (id_jugador solo dígitos, máx. 7 caracteres)
INSERT INTO jugador (id_jugador, nombre, numero, id_equipo, id_pais, descalificado) VALUES
('1000001', 'David Ospina',        1, 1, 'COL', FALSE),
('1000002', 'Luis Díaz',          7, 1, 'COL', FALSE),
('1000003', 'James Rodríguez',   10, 1, 'COL', FALSE),
('2000001', 'Emiliano Martínez',  23, 2, 'ARG', FALSE),
('2000002', 'Lionel Messi',       10, 2, 'ARG', FALSE),
('2000003', 'Julián Álvarez',      9, 2, 'ARG', TRUE),
('3000001', 'Alisson Becker',      1, 3, 'BRA', FALSE),
('3000002', 'Vinícius Júnior',     7, 3, 'BRA', FALSE),
('3000003', 'Rodrygo Goes',       11, 3, 'BRA', FALSE),
('4000001', 'Sergio Rochet',       1, 4, 'URU', FALSE),
('4000002', 'Federico Valverde',   8, 4, 'URU', FALSE),
('4000003', 'Darwin Núñez',        9, 4, 'URU', FALSE);

-- 5) ESTADIO
INSERT INTO estadio (id_estadio, nombre, ciudad, id_pais) VALUES
(1, 'Estadio Metropolitano Roberto Meléndez', 'Barranquilla',   'COL'),
(2, 'Estadio Monumental',                     'Buenos Aires',   'ARG'),
(3, 'Estadio Maracanã',                       'Río de Janeiro', 'BRA');

-- 6) PARTIDO
INSERT INTO partido (id_partido, fecha_hora, id_estadio, id_equipo_local, id_equipo_visitante,
                     goles_local, goles_visitante, es_eliminatoria, hubo_tanda_penales,
                     penales_local, penales_visitante, temporada) VALUES
-- Fase de grupos: Colombia 2-1 Argentina
(1, '2026-06-11 20:00:00', 1, 1, 2, 2, 1, FALSE, FALSE, 0, 0, 2026),
-- Eliminatoria: Brasil 1-1 Uruguay (4-3 en penales)
(2, '2026-06-15 18:00:00', 3, 3, 4, 1, 1, TRUE,  TRUE,  4, 3, 2026),
-- Fase de grupos: Uruguay 0-2 Colombia
(3, '2026-06-20 16:00:00', 2, 4, 1, 0, 2, FALSE, FALSE, 0, 0, 2026);

-- 7) ARBITRO
INSERT INTO arbitro (id_arbitro, nombre, id_pais) VALUES
(1, 'Carlos del Cerro Grande', 'ESP'),
(2, 'Daniele Orsato',          'ITA'),
(3, 'César Ramos',             'MEX'),
(4, 'Augusto Aragón',          'ECU'),
(5, 'Antonio Mateu Lahoz',     'ESP'),
(6, 'Maurizio Mariani',        'ITA');

-- 8) ASIGNACION_ARBITRAL (rol único por partido)
INSERT INTO asignacion_arbitral (id_partido, id_arbitro, rol) VALUES
(1, 1, 'CENTRAL'),
(1, 3, 'ASISTENTE_1'),
(1, 4, 'ASISTENTE_2'),
(2, 2, 'CENTRAL'),
(2, 6, 'ASISTENTE_1'),
(2, 5, 'ASISTENTE_2'),
(3, 5, 'CENTRAL'),
(3, 1, 'ASISTENTE_1'),
(3, 3, 'ASISTENTE_2');

-- 9) EVENTO (orden único por partido)
INSERT INTO evento (id_evento, id_partido, tipo_evento, periodo, minuto, minuto_adicional, orden, resultado, observaciones) VALUES
-- Partido 1: Colombia 2-1 Argentina
(1,  1, 'GOL',              '1T', 23, 0, 1, 'ANOTADO',  'Gol de Luis Díaz (COL) tras centro desde la derecha'),
(2,  1, 'TARJETA_AMARILLA', '1T', 38, 0, 2, 'AMARILLA', 'Falta táctica de Lionel Messi (ARG)'),
(3,  1, 'GOL',              '2T', 55, 0, 3, 'ANOTADO',  'Gol de Lionel Messi (ARG) de tiro libre'),
(4,  1, 'SUSTITUCION',      '2T', 70, 0, 4, 'CAMBIO',   'Sale Julián Álvarez, entra reemplazo (ARG)'),
(5,  1, 'GOL',              '2T', 90, 3, 5, 'ANOTADO',  'Gol de James Rodríguez (COL) de penal en tiempo añadido'),

-- Partido 2: Brasil 1-1 Uruguay (penales 4-3)
(6,  2, 'GOL',              '1T', 30, 0, 1, 'ANOTADO',  'Gol de Vinícius Júnior (BRA)'),
(7,  2, 'TARJETA_ROJA',     '2T', 65, 0, 2, 'ROJA',     'Expulsión de Federico Valverde (URU) por falta violenta'),
(8,  2, 'GOL',              '2T', 78, 0, 3, 'ANOTADO',  'Gol de Darwin Núñez (URU)'),
-- Tanda de penales
(9,  2, 'PENAL_TANDA',      'TP', 120, 0, 4,  'ANOTADO', 'Penal 1 BRA: Vinícius Júnior'),
(10, 2, 'PENAL_TANDA',      'TP', 120, 0, 5,  'ANOTADO', 'Penal 1 URU: Darwin Núñez'),
(11, 2, 'PENAL_TANDA',      'TP', 120, 0, 6,  'ANOTADO', 'Penal 2 BRA: Rodrygo Goes'),
(12, 2, 'PENAL_TANDA',      'TP', 120, 0, 7,  'ANOTADO', 'Penal 2 URU: Federico Valverde'),
(13, 2, 'PENAL_TANDA',      'TP', 120, 0, 8,  'ANOTADO', 'Penal 3 BRA: jugador de Brasil'),
(14, 2, 'PENAL_TANDA',      'TP', 120, 0, 9,  'FALLADO', 'Penal 3 URU: atajado por Alisson Becker'),
(15, 2, 'PENAL_TANDA',      'TP', 120, 0, 10, 'ANOTADO', 'Penal 4 BRA: jugador de Brasil'),
(16, 2, 'PENAL_TANDA',      'TP', 120, 0, 11, 'ANOTADO', 'Penal 4 URU: jugador de Uruguay'),

-- Partido 3: Uruguay 0-2 Colombia
(17, 3, 'GOL',              '1T', 12, 0, 1, 'ANOTADO',  'Gol de James Rodríguez (COL)'),
(18, 3, 'TARJETA_AMARILLA', '1T', 41, 0, 2, 'AMARILLA', 'Falta de Darwin Núñez (URU)'),
(19, 3, 'SUSTITUCION',      '2T', 60, 0, 3, 'CAMBIO',   'Sale James Rodríguez, entra reemplazo (COL)'),
(20, 3, 'GOL',              '2T', 85, 0, 4, 'ANOTADO',  'Gol de Luis Díaz (COL) en contraataque');
