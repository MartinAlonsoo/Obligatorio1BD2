-- =======================
-- DATOS DE PRUEBA
-- =======================

-- Jugadores
INSERT INTO Jugador VALUES ('WuKong', TO_DATE('01/01/2024','DD/MM/YYYY'), 'wukong@monkey.com', 'pass123', 'China', 50, 'Este');
INSERT INTO Jugador VALUES ('Tripitaka', TO_DATE('15/03/2024','DD/MM/YYYY'), 'tripitaka@templo.com', 's123456', 'India', 20, 'Sur');

-- Personajes
INSERT INTO Personaje VALUES (1, 'wukong@monkey.com', 'Bestia', 90, 80, 60, 70, 65, 120, 5000);
INSERT INTO Personaje VALUES (1, 'tripitaka@templo.com', 'Humano', 40, 45, 85, 50, 60, 80, 300);

-- Habilidades
INSERT INTO Habilidades VALUES ('Bastón Extensible', 20, 'Energia', 'Ataque');
INSERT INTO Habilidades VALUES ('Escudo Espiritual', 15, 'Mana', 'Defensa');
INSERT INTO Habilidades VALUES ('Llamas Celestiales', 50, 'Mana', 'Magia');

-- Enemigos
INSERT INTO Enemigo VALUES ('Tigre Demonio', 60, 'Feral', 'Bosque de Bambú');
INSERT INTO Enemigo VALUES ('Mono Blanco', 30, 'Simio', 'Cueva del Viento');
INSERT INTO Enemigo VALUES ('Rey Toro', 150, 'Demonio', 'Volcán Ardiente');

-- Subtipos
INSERT INTO EnemigoNormal VALUES ('Mono Blanco');
INSERT INTO EnemigoElite VALUES ('Tigre Demonio');
INSERT INTO EnemigoJefe VALUES ('Rey Toro', 'Carga Infernal');

-- Zonas
INSERT INTO Zona VALUES ('Bosque de Bambú', 'Una zona con espeso follaje y enemigos veloces.', 10);
INSERT INTO Zona VALUES ('Volcán Ardiente', 'Zona final con lava y jefes de fuego.', 100);

-- Mapa
INSERT INTO Mapa VALUES (1);

-- Misiones
INSERT INTO Misiones VALUES (101, 'Inicio del Viaje', 'Comienza tu travesía', 1, 'Principal');
INSERT INTO Misiones VALUES (102, 'Furia del Volcán', 'Derrota al Rey Toro', 100, 'Principal');

-- Recompensas
INSERT INTO Recompensa VALUES (1, 1000, 200);
INSERT INTO Recompensa VALUES (2, 5000, 1000);

-- Items
INSERT INTO Items VALUES ('Espada de Jade', 'Rara', 10, 'S');
INSERT INTO Items VALUES ('Armadura de Fuego', 'Epica', 100, 'N');
INSERT INTO Items VALUES ('Reliquia Celestial', 'Legendaria', 120, 'N');

-- Características Afectadas
INSERT INTO CaracteristicaAfectada VALUES ('Espada de Jade', 'Fuerza', 10);
INSERT INTO CaracteristicaAfectada VALUES ('Armadura de Fuego', 'Resistencia', 25);
INSERT INTO CaracteristicaAfectada VALUES ('Reliquia Celestial', 'Inteligencia', 40);

-- Subtipos de Ítems
INSERT INTO Item_Arma VALUES ('Espada de Jade');
INSERT INTO Item_Armadura VALUES ('Armadura de Fuego');
INSERT INTO Item_Reliquia VALUES ('Reliquia Celestial');

-- Personaje posee habilidades
INSERT INTO Personaje_Posee_Habilidades VALUES ('wukong@monkey.com', 1, 'Bastón Extensible');
INSERT INTO Personaje_Posee_Habilidades VALUES ('wukong@monkey.com', 1, 'Llamas Celestiales');
INSERT INTO Personaje_Posee_Habilidades VALUES ('tripitaka@templo.com', 1, 'Escudo Espiritual');

-- Personaje posee ítems
INSERT INTO Personaje_Posee_Items VALUES ('wukong@monkey.com', 1, 'Espada de Jade', 'S');
INSERT INTO Personaje_Posee_Items VALUES ('wukong@monkey.com', 1, 'Reliquia Celestial', 'N');

-- Enemigos habitan zonas
INSERT INTO Enemigo_Habita_En_Zona VALUES ('Bosque de Bambú', 'Tigre Demonio');
INSERT INTO Enemigo_Habita_En_Zona VALUES ('Volcán Ardiente', 'Rey Toro');

-- Jefe aparece en misión
INSERT INTO Jefe_Aparece_En_Mision VALUES (102, 'Rey Toro');

-- Jefe tiene habilidades
INSERT INTO Jefe_Tiene_Habilidades VALUES ('Rey Toro', 'Llamas Celestiales');

-- Recompensas dejadas por enemigos
INSERT INTO Enemigo_Deja_Recompensa VALUES ('Rey Toro', 2);

-- Misiones dan recompensa
INSERT INTO Mision_Da_Recompensa VALUES (101, 1);
INSERT INTO Mision_Da_Recompensa VALUES (102, 2);

-- Recompensas poseen ítems
INSERT INTO Recompensa_Posee_Item VALUES ('Reliquia Celestial', 2);

-- Relaciones de misión previa
INSERT INTO Mision_Es_Previa_De_Mision VALUES (101, 102);
INSERT INTO Mision_Es_Previa_De_Zona VALUES (101, 'Volcán Ardiente');
