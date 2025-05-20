ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Mision_Es_Previa_De_Zona CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Mision_Es_Previa_De_Mision CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Recompensa_Posee_Item CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Mision_Da_Recompensa CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Enemigo_Deja_Recompensa CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Jefe_Aparece_En_Mision CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Enemigo_Habita_En_Zona CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Jefe_Tiene_Habilidades CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Personaje_Posee_Items CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Personaje_Posee_Habilidades CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Jugador_Tiene_Personaje CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Mapa CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Item_Material CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Item_Consumible CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Item_Armadura CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Item_Arma CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Item_Reliquia CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Item CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Misiones CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Recompensa CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Zona CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE EnemigoJefe CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE EnemigoElite CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE EnemigoNormal CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Enemigo CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Habilidades CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Personaje CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE Jugador CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL; -- Ignora errores si la tabla no existe
END;


-- Tablas de entidades
CREATE TABLE Jugador (
    nombre VARCHAR2(50) UNIQUE NOT NULL,
    fecha_registro DATE NOT NULL,
    email VARCHAR2(40) PRIMARY KEY,
    contrasena VARCHAR2(40) NOT NULL,
    nombrePais VARCHAR2(20) NOT NULL,
    cantHoras NUMBER(5) NOT NULL CHECK (cantHoras <= 0),
    nombreRegion VARCHAR2(20) NOT NULL
);

 
CREATE TABLE Personaje (
    id NUMBER(5) UNIQUE NOT NULL,
    FOREIGN KEY (email_Jugador) REFERENCES Jugador(email),
    PRIMARY Key (email_Jugador, id),
    especie VARCHAR2(10) NOT NULL CHECK(especie IN ('Bestia','Espíritu', 'Humano', 'Demonio')),
    fuerza NUMBER(10) NOT NULL CHECK(fuerza <= 100 AND fuerza >= 0),
    agilidad NUMBER(10) NOT NULL CHECK(agilidad <= 100 AND agilidad >= 0),
    intelifencia NUMBER(10) NOT NULL CHECK(intelifencia <= 100 AND intelifencia >= 0),
    vitalidad NUMBER(10) NOT NULL CHECK(vitalidad <= 100 AND vitalidad >= 0),
    resistencia NUMBER(10) NOT NULL CHECK(resistencia <= 100 AND resistencia >= 0),
    nivel NUMBER(10) NOT NULL CHECK(nivel <= 342 AND nivel >= 0),
    cantMonedas NUMBER(10) NOT NULL
);
  
CREATE TABLE Habilidades (
    nombre VARCHAR2(20) PRIMARY KEY,
    nivelMin NUMBER(3) NOT NULL CHECK (nivel <= 342 AND nivel >= 0),
    tipoEnergia VARCHAR2(10) NOT NULL CHECK(tipoEnergia IN ('Energia','Mana')),
    clasificacion VARCHAR2(10) NOT NULL CHECK(clasificacion IN ('Ataque', 'Defensa', 'Magia'))
);

CREATE TABLE Enemigo (
    nombre VARCHAR2(20) PRIMARY KEY,
    nivel NUMBER(10) NOT NULL,
    tipo VARCHAR2(10) NOT NULL,
    ubicacion VARCHAR2(100)
);

CREATE TABLE EnemigoNormal (
    nombre VARCHAR2(20) PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Enemigo(nombre)
);

CREATE TABLE EnemigoElite (
    nombre VARCHAR2(20) PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Enemigo(nombre)
);

CREATE TABLE EnemigoJefe (
    nombre VARCHAR2(20) PRIMARY KEY,
    habilidadEspecial VARCHAR2(100),
    FOREIGN KEY (nombre) REFERENCES Enemigo(nombre)
);

CREATE TABLE Zona (
    nombre VARCHAR2(20) PRIMARY KEY,
    descripcion VARCHAR2(50) NOT NULL,
    nivelMin NUMBER(3) NOT NULL CHECK (nivel <= 342 AND nivel >= 0)
);
CREATE TABLE Recompensa (
    id NUMBER(5) PRIMARY KEY,
    cantMonedas NUMBER(10) NOT NULL,
    cantExperiencia NUMBER(10) NOT NULL
);
CREATE TABLE Misiones (
    id NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(20) NOT NULL,
    descripcion VARCHAR2(50) NOT NULL,
    nivelMin NUMBER(3) NOT NULL CHECK (nivel <= 342 AND nivel >= 0),
    estado VARCHAR2(10) NOT NULL CHECK(estado IN ('Principal','Secundaria', 'Especial'))
);

-- Tabla general de ítems
CREATE TABLE Items (
    nombre VARCHAR2(20) PRIMARY KEY,
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
    nombre VARCHAR2(20) PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Items(nombre)
);

CREATE TABLE Item_Armadura (
    nombre VARCHAR2(20) PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Items(nombre)
);

CREATE TABLE Item_Consumible (
    nombre VARCHAR2(20) PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Items(nombre)
);

CREATE TABLE Item_Material (
    nombre VARCHAR2(20) PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Items(nombre)
);

CREATE TABLE Item_Reliquia (
    nombre VARCHAR2(20) PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES Items(nombre)
);


CREATE TABLE Mapa (
    id NUMBER(5) PRIMARY KEY
);

--Tablas de relaciones
CREATE TABLE Jugador_Tiene_Personaje (
    emailJugador VARCHAR(40) NOT NULL,
    idPersonaje NUMBER(5) NOT NULL,
    PRIMARY KEY (emailJugador, idPersonaje),
    FOREIGN KEY (emailJugador) REFERENCES Jugador(email),
    FOREIGN KEY (idPersonaje) REFERENCES Personaje(id)
);

CREATE TABLE Personaje_Posee_Habilidades (
    emailJugador VARCHAR(40) NOT NULL,
    idPersonaje NUMBER(5) NOT NULL,
    nombreHabilidad VARCHAR(20) NOT NULL,
    PRIMARY KEY (emailJugador, idPersonaje, nombreHabilidad),
    FOREIGN KEY (emailJugador) REFERENCES Jugador(email),
    FOREIGN KEY (idPersonaje) REFERENCES Personaje(id),
    FOREIGN KEY (nombreHabilidad) REFERENCES Habilidad(nombre)
);

CREATE TABLE Personaje_Posee_Items (
    emailJugador VARCHAR(40) NOT NULL,
    idPersonaje NUMBER(5) NOT NULL,
    nombreItem VARCHAR(20) NOT NULL,
    equipado BOOLEAN NOT NULL,
    PRIMARY KEY (emailJugador, idPersonaje, nombreItem),
    FOREIGN KEY (emailJugador) REFERENCES Jugador(email),
    FOREIGN KEY (idPersonaje) REFERENCES Personaje(id),
    FOREIGN KEY (nombreItem) REFERENCES Items(nombre)
);

CREATE TABLE Jefe_Tiene_Habilidades (
    nombreJefe VARCHAR(20) NOT NULL,
    nombreHabilidad VARCHAR(20) NOT NULL,
    PRIMARY KEY (nombreJefe, nombreHabilidad),
    FOREIGN KEY (nombreJefe) REFERENCES Jefe(nombre),
    FOREIGN KEY (nombreHabilidad) REFERENCES Habilidad(nombre)
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
    FOREIGN KEY (codigoMision) REFERENCES Mision(codigo),
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
    FOREIGN KEY (codMision) REFERENCES Mision(codigo),
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
    FOREIGN KEY (codMision1) REFERENCES Mision(codigo),
    FOREIGN KEY (codMision2) REFERENCES Mision(codigo)
);

CREATE TABLE Mision_Es_Previa_De_Zona (
    codMision NUMBER(5) NOT NULL,
    nombreZona VARCHAR(20) NOT NULL,
    PRIMARY KEY (codMision, nombreZona),
    FOREIGN KEY (codMision) REFERENCES Mision(codigo),
    FOREIGN KEY (nombreZona) REFERENCES Zona(nombre)
);