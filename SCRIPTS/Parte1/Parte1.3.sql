ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

    DROP TABLE Mision_Es_Previa_De_Zona CASCADE CONSTRAINTS;
    DROP TABLE Mision_Es_Previa_De_Mision CASCADE CONSTRAINTS;
    DROP TABLE Recompensa_Posee_Item CASCADE CONSTRAINTS;
    DROP TABLE Mision_Da_Recompensa CASCADE CONSTRAINTS;
    DROP TABLE Enemigo_Deja_Recompensa CASCADE CONSTRAINTS;
    DROP TABLE Jefe_Aparece_En_Mision CASCADE CONSTRAINTS;
    DROP TABLE Enemigo_Habita_En_Zona CASCADE CONSTRAINTS;
    DROP TABLE Jefe_Tiene_Habilidades CASCADE CONSTRAINTS;
    DROP TABLE Personaje_Posee_Items CASCADE CONSTRAINTS;
    DROP TABLE Personaje_Posee_Habilidades CASCADE CONSTRAINTS;
    --DROP TABLE Jugador_Tiene_Personaje CASCADE CONSTRAINTS;
    DROP TABLE Mapa CASCADE CONSTRAINTS;
    DROP TABLE CaracteristicaAfectada CASCADE CONSTRAINTS;
    DROP TABLE Item_Material CASCADE CONSTRAINTS;
    DROP TABLE Item_Consumible CASCADE CONSTRAINTS;
    DROP TABLE Item_Armadura CASCADE CONSTRAINTS;
    DROP TABLE Item_Arma CASCADE CONSTRAINTS;
    DROP TABLE Item_Reliquia CASCADE CONSTRAINTS;
    DROP TABLE Items CASCADE CONSTRAINTS;
    DROP TABLE Misiones CASCADE CONSTRAINTS;
    DROP TABLE Recompensa CASCADE CONSTRAINTS;
    DROP TABLE Zona CASCADE CONSTRAINTS;
    DROP TABLE EnemigoJefe CASCADE CONSTRAINTS;
    DROP TABLE EnemigoElite CASCADE CONSTRAINTS;
    DROP TABLE EnemigoNormal CASCADE CONSTRAINTS;
    DROP TABLE Enemigo CASCADE CONSTRAINTS;
    DROP TABLE Habilidades CASCADE CONSTRAINTS;
    DROP TABLE Personaje CASCADE CONSTRAINTS;
    DROP TABLE Jugador CASCADE CONSTRAINTS;
    

-- Tablas de entidades
CREATE TABLE Jugador (
    nombre VARCHAR2(50) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL,
    email VARCHAR2(40) CONSTRAINT pk_Jugador PRIMARY KEY,
    contrasena VARCHAR2(40) NOT NULL,
    nombrePais VARCHAR2(20) NOT NULL,
    cantHoras NUMBER(5) NOT NULL CHECK (cantHoras >= 0),
    nombreRegion VARCHAR2(20) NOT NULL CHECK (nombreRegion IN ('AMERICA', 'AFRICA', 'EUROPA', 'ASIA', 'OCEANIA'))
);

 
CREATE TABLE Personaje (
    email_Jugador VARCHAR2(40) CONSTRAINT pk_personaje PRIMARY KEY,
    id NUMBER(5) UNIQUE NOT NULL,
    especie VARCHAR2(10) NOT NULL CHECK (especie IN ('Bestia','Espíritu', 'Humano', 'Demonio')),
    fuerza NUMBER(10) NOT NULL CHECK(fuerza BETWEEN 0 AND 100),
    agilidad NUMBER(10) NOT NULL CHECK(agilidad BETWEEN 0 AND 100),
    inteligencia NUMBER(10) NOT NULL CHECK(inteligencia BETWEEN 0 AND 100),
    vitalidad NUMBER(10) NOT NULL CHECK(vitalidad BETWEEN 0 AND 100),
    resistencia NUMBER(10) NOT NULL CHECK(resistencia BETWEEN 0 AND 100),
    nivel NUMBER(10) NOT NULL CHECK(nivel BETWEEN 0 AND 342),
    cantMonedas NUMBER(10) NOT NULL,
    FOREIGN KEY (email_Jugador) REFERENCES Jugador(email)
);



  
CREATE TABLE Habilidades (
    nombre VARCHAR2(20) CONSTRAINT pk_Habilidades PRIMARY KEY,
    nivelMin NUMBER(3) NOT NULL CHECK (nivelMin <= 342 AND nivelMin >= 0),
    tipoEnergia VARCHAR2(10) NOT NULL CHECK(tipoEnergia IN ('Energia','Mana')),
    clasificacion VARCHAR2(10) NOT NULL CHECK(clasificacion IN ('Ataque', 'Defensa', 'Magia'))
);

CREATE TABLE Enemigo (
    nombre VARCHAR2(20) CONSTRAINT pk_Enemigo PRIMARY KEY,
    nivel NUMBER(10) NOT NULL,
    tipo VARCHAR2(10) NOT NULL,
    ubicacion VARCHAR2(100)
);

CREATE TABLE EnemigoNormal (
    nombre VARCHAR2(20) CONSTRAINT pk_EnemigoNormal PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Enemigo(nombre)
);

CREATE TABLE EnemigoElite (
    nombre VARCHAR2(20) CONSTRAINT pk_EnemigoElite PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Enemigo(nombre)
);

CREATE TABLE EnemigoJefe (
    nombre VARCHAR2(20) CONSTRAINT pk_EnemigoJefe PRIMARY KEY,
    habilidadEspecial VARCHAR2(100),
    FOREIGN KEY (nombre) REFERENCES Enemigo(nombre)
);

CREATE TABLE Zona (
    nombre VARCHAR2(20) CONSTRAINT pk_Zona PRIMARY KEY,
    descripcion VARCHAR2(50) NOT NULL,
    nivelMin NUMBER(3) NOT NULL CHECK (nivelMin <= 342 AND nivelMin >= 0)
);
CREATE TABLE Recompensa (
    id NUMBER(5) CONSTRAINT pk_Recompensa PRIMARY KEY,
    cantMonedas NUMBER(10) NOT NULL,
    cantExperiencia NUMBER(10) NOT NULL
);
CREATE TABLE Misiones (
    id NUMBER(5) CONSTRAINT pk_Misiones PRIMARY KEY,
    nombre VARCHAR2(20) NOT NULL,
    descripcion VARCHAR2(50) NOT NULL,
    nivelMin NUMBER(3) NOT NULL CHECK (nivelMin <= 342 AND nivelMin >= 0),
    estado VARCHAR2(10) NOT NULL CHECK(estado IN ('Principal','Secundaria', 'Especial'))
);

-- Tabla general de ítems
CREATE TABLE Items (
    nombre VARCHAR2(20) CONSTRAINT pk_Items PRIMARY KEY,
    rareza VARCHAR2(10) NOT NULL 
        CHECK (rareza IN ('Comun','Rara', 'Epica', 'Legendaria')),
    nivelMinUtilizacion NUMBER(3) NOT NULL 
        CHECK (nivelMinUtilizacion BETWEEN 0 AND 342),
    intercambiable CHAR(1) NOT NULL 
        CHECK (intercambiable IN ('S', 'N'))
);

-- Atributo multivaluado: características afectadas por el ítem
CREATE TABLE CaracteristicaAfectada (
    nombreItem VARCHAR2(20),
    caracteristica VARCHAR2(15),
    cantAfectacion NUMBER(3) NOT NULL CHECK (cantAfectacion >= 0),
    PRIMARY KEY (nombreItem, caracteristica),
    FOREIGN KEY (nombreItem) REFERENCES Items(nombre),
    CHECK (caracteristica IN ('Agilidad', 'Fuerza', 'Inteligencia', 'Vitalidad', 'Resistencia'))
);

-- Subtipos de ítem (especialización total, exclusiva)
CREATE TABLE Item_Arma (
    nombre VARCHAR2(20) CONSTRAINT Item_Arma PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Items(nombre)
);

CREATE TABLE Item_Armadura (
    nombre VARCHAR2(20) CONSTRAINT pk_Item_Armadura PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Items(nombre)
);

CREATE TABLE Item_Consumible (
    nombre VARCHAR2(20) CONSTRAINT pk_Item_Consumible PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Items(nombre)
);

CREATE TABLE Item_Material (
    nombre VARCHAR2(20) CONSTRAINT pk_Item_Material PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Items(nombre)
);

CREATE TABLE Item_Reliquia (
    nombre VARCHAR2(20) CONSTRAINT pk_Item_Reliquia PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Items(nombre)
);


CREATE TABLE Mapa (
    id NUMBER(5) CONSTRAINT pk_Mapa PRIMARY KEY
);

--Tablas de relaciones
--CREATE TABLE Jugador_Tiene_Personaje (
--    emailJugador VARCHAR(40) NOT NULL,
--    idPersonaje NUMBER(5) NOT NULL,
--    PRIMARY KEY (emailJugador, idPersonaje),
--    FOREIGN KEY (emailJugador) REFERENCES Jugador(email),
--    FOREIGN KEY (emailJugador, idPersonaje) REFERENCES Personaje(email_Jugador, id)
--);

CREATE TABLE Personaje_Posee_Habilidades (
    emailJugador VARCHAR(40) NOT NULL,
    idPersonaje NUMBER(5) NOT NULL,
    nombreHabilidad VARCHAR(20) NOT NULL,
    PRIMARY KEY (emailJugador, idPersonaje, nombreHabilidad),
    FOREIGN KEY (emailJugador) REFERENCES Personaje(email_Jugador),
    FOREIGN KEY (nombreHabilidad) REFERENCES Habilidades(nombre)
);

CREATE TABLE Personaje_Posee_Items (
    emailJugador VARCHAR(40) NOT NULL,
    idPersonaje NUMBER(5) NOT NULL,
    nombreItem VARCHAR(20) NOT NULL,
    equipado CHAR(1) NOT NULL CHECK (equipado IN ('S', 'N')),
    PRIMARY KEY (emailJugador, idPersonaje, nombreItem),
    FOREIGN KEY (emailJugador) REFERENCES Personaje(email_Jugador),
    FOREIGN KEY (nombreItem) REFERENCES Items(nombre)
);

CREATE TABLE Jefe_Tiene_Habilidades (
    nombreJefe VARCHAR(20) NOT NULL,
    nombreHabilidad VARCHAR(20) NOT NULL,
    PRIMARY KEY (nombreJefe, nombreHabilidad),
    FOREIGN KEY (nombreJefe) REFERENCES EnemigoJefe(nombre),
    FOREIGN KEY (nombreHabilidad) REFERENCES Habilidades(nombre)
);

CREATE TABLE Enemigo_Habita_En_Zona (
    nombreZona VARCHAR(20) NOT NULL,
    nombreEnemigo VARCHAR(20) NOT NULL,
    PRIMARY KEY (nombreZona, nombreEnemigo),
    FOREIGN KEY (nombreZona) REFERENCES Zona(nombre),
    FOREIGN KEY (nombreEnemigo) REFERENCES Enemigo(nombre)
);

CREATE TABLE Jefe_Aparece_En_Mision (
    codigoMision NUMBER(5) NOT NULL,
    nombreJefe VARCHAR(20) NOT NULL,
    PRIMARY KEY (codigoMision, nombreJefe),
    FOREIGN KEY (codigoMision) REFERENCES Misiones(id),
    FOREIGN KEY (nombreJefe) REFERENCES EnemigoJefe(nombre)
);

CREATE TABLE Enemigo_Deja_Recompensa (
    nombreEnemigo VARCHAR(20) NOT NULL,
    idRecompensa NUMBER(5) NOT NULL,
    PRIMARY KEY (nombreEnemigo, idRecompensa),
    FOREIGN KEY (nombreEnemigo) REFERENCES Enemigo(nombre),
    FOREIGN KEY (idRecompensa) REFERENCES Recompensa(id)
);

CREATE TABLE Mision_Da_Recompensa (
    codMision NUMBER(5) NOT NULL,
    idRecompensa NUMBER(5) NOT NULL,
    PRIMARY KEY (codMision, idRecompensa),
    FOREIGN KEY (codMision) REFERENCES Misiones(id),
    FOREIGN KEY (idRecompensa) REFERENCES Recompensa(id)
);

CREATE TABLE Recompensa_Posee_Item (
    nombreItem VARCHAR(20) NOT NULL,
    idRecompensa NUMBER(5) NOT NULL,
    PRIMARY KEY (nombreItem, idRecompensa),
    FOREIGN KEY (nombreItem) REFERENCES Items(nombre),
    FOREIGN KEY (idRecompensa) REFERENCES Recompensa(id)
);

CREATE TABLE Mision_Es_Previa_De_Mision (
    codMision1 NUMBER(5) NOT NULL,
    codMision2 NUMBER(5) NOT NULL,
    PRIMARY KEY (codMision1, codMision2),
    FOREIGN KEY (codMision1) REFERENCES Misiones(id),
    FOREIGN KEY (codMision2) REFERENCES Misiones(id)
);

CREATE TABLE Mision_Es_Previa_De_Zona (
    codMision NUMBER(5) NOT NULL,
    nombreZona VARCHAR(20) NOT NULL,
    PRIMARY KEY (codMision, nombreZona),
    FOREIGN KEY (codMision) REFERENCES Misiones(id),
    FOREIGN KEY (nombreZona) REFERENCES Zona(nombre)
);




-- 1. Listar los índices definidos sobre JUGADOR
SELECT
  ui.index_name,
  ui.index_type,
  ui.uniqueness,
  uc.constraint_name,
  uc.constraint_type
FROM user_indexes ui
LEFT JOIN user_constraints uc
  ON ui.index_name = uc.index_name
WHERE ui.table_name = 'JUGADOR'
ORDER BY ui.index_name;


-- Consulta para listar todos los índices generados por Oracle para las tablas de tu esquema
WITH idx AS (
  SELECT 
    ui.table_name,
    ui.index_name,
    ui.index_type,
    ui.uniqueness,
    uc.constraint_type,
    uic.column_name
  FROM user_indexes ui
  LEFT JOIN user_constraints uc
    ON ui.index_name = uc.index_name
  JOIN user_ind_columns uic
    ON ui.index_name = uic.index_name
  WHERE ui.table_name IN (
    -- Incluye aquí todas las tablas de tu DDL, o quita esta línea para listar todas las tablas del esquema
    'JUGADOR','PERSONAJE','HABILIDADES','ENEMIGO','ENEMIGONORMAL',
    'ENEMIGOELITE','ENEMIGOJEFE','ZONA','RECOMPENSA','MISIONES',
    'ITEMS','CARACTERISTICAAFECTADA','ITEM_ARMA','ITEM_ARMADURA',
    'ITEM_CONSUMIBLE','ITEM_MATERIAL','ITEM_RELIQUIA','MAPA',
    'PERSONAJE_POSEE_HABILIDADES','PERSONAJE_POSEE_ITEMS',
    'JEFE_TIENE_HABILIDADES','ENEMIGO_HABITA_EN_ZONA',
    'JEFE_APARECE_EN_MISION','ENEMIGO_DEJA_RECOMPENSA',
    'MISION_DA_RECOMPENSA','RECOMPENSA_POSEE_ITEM',
    'MISION_ES_PREVIA_DE_MISION','MISION_ES_PREVIA_DE_ZONA'
  )
)
SELECT
  table_name,
  index_name,
  column_name,
  index_type        AS oracle_type,
  uniqueness,
  constraint_type,
  CASE
    WHEN constraint_type = 'P' THEN 'Índice primario (no denso)'
    WHEN constraint_type = 'U' THEN 'Índice secundario por clave (denso)'
    WHEN uniqueness = 'NONUNIQUE' THEN 'Índice secundario por no clave (denso)'
    ELSE 'Otro'
  END AS clasificacion
FROM idx
ORDER BY table_name, index_name, column_name;