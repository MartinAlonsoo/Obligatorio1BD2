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
    cantHoras NUMBER(5) NOT NULL,
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
    nivelMin NUMBER(3) NOT NULL CHECK (nivel < 343),
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
    nivelMin NUMBER(3) NOT NULL CHECK (nivel < 343)
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
    nivelMin NUMBER(3) NOT NULL CHECK (nivel < 343),
    estado VARCHAR2(10) NOT NULL CHECK(estado IN ('Principal','Secundaria', 'Especial'))
);

CREATE TABLE Items (

);

CREATE TABLE Item_Reliquia (

);

CREATE TABLE Item_Arma (

);

CREATE TABLE Item_Armadura (

);

CREATE TABLE Item_Consumible (

);

CREATE TABLE Item_Material (

);

CREATE TABLE Mapa (

);

--Tablas de relaciones
CREATE TABLE Jugador_Tiene_Personaje (

);

CREATE TABLE Personaje_Posee_Habilidades (

);

CREATE TABLE Personaje_Posee_Items (

);

CREATE TABLE Jefe_Tiene_Habilidades (

);

CREATE TABLE Enemigo_Habita_En_Zona (

);

CREATE TABLE Jefe_Aparece_En_Mision (

);

CREATE TABLE Enemigo_Deja_Recompensa (

);

CREATE TABLE Mision_Da_Recompensa (

);

CREATE TABLE Recompensa_Posee_Item (

);

CREATE TABLE Mision_Es_Previa_De_Mision (

);

CREATE TABLE Mision_Es_Previa_De_Zona (

);