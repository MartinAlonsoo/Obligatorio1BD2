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

);
 
CREATE TABLE Personaje (

);
  
CREATE TABLE Habilidades (

);

CREATE TABLE Enemigo (

);

CREATE TABLE EnemigoNormal (

);


CREATE TABLE EnemigoElite (

);

CREATE TABLE EnemigoJefe (

);

CREATE TABLE Zona (

);
CREATE TABLE Recompensa (

);
CREATE TABLE Misiones (

);

CREATE TABLE Item (

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

);

CREATE TABLE Enemigo_Habita_En_Zona (

);

CREATE TABLE Jefe_Aparece_En_Mision (
    codigoMision NUMBER() NOT NULL,
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

);

CREATE TABLE Recompensa_Posee_Item (

);

CREATE TABLE Mision_Es_Previa_De_Mision (

);

CREATE TABLE Mision_Es_Previa_De_Zona (

);