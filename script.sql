DROP TABLE IF EXISTS Campus;
DROP TABLE IF EXISTS Problema;
DROP TABLE IF EXISTS Presa;
DROP TABLE IF EXISTS Pared;
DROP TABLE IF EXISTS Panel;
DROP TABLE IF EXISTS Bien;
DROP TABLE IF EXISTS Escalada;
DROP TYPE IF EXISTS Tipo_Escalada_Enum;
DROP TABLE IF EXISTS Zona;
DROP TABLE IF EXISTS Registro;
DROP TYPE IF EXISTS Tipo_Contrato_Enum;
DROP TABLE IF EXISTS Trabaja;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Local;

DROP FUNCTION IF EXISTS comprobar_presas;
DROP FUNCTION IF EXISTS comprobar_problemas;
DROP FUNCTION IF EXISTS comprobar_paneles;

-- Creacion de la tabla Local
CREATE TABLE IF NOT EXISTS Local (
  ID_Local INT NOT NULL,
  Nombre VARCHAR(50) NULL,
  Localizacion VARCHAR(100),
  Dimensiones VARCHAR(30),

  PRIMARY KEY (ID_Local)
);

INSERT INTO Local (ID_Local, Nombre, Localizacion, Dimensiones) VALUES (333, 'Escala Plastica SC', 'Santa Cruz', '300x500');
INSERT INTO Local (ID_Local, Nombre, Localizacion, Dimensiones) VALUES (444, 'Escala Plastica LL', 'La Laguna', '900x400');
INSERT INTO Local (ID_Local, Nombre, Localizacion, Dimensiones) VALUES (666, 'Escala Plastica PC', 'Puerto de la Cruz', '100x200');

SELECT * FROM Local;


-- Creacion de la tabla Cliente
CREATE TABLE IF NOT EXISTS Cliente (
  DNI_Cliente VARCHAR(9) NOT NULL,
  Nombre VARCHAR(50) NOT NULL,

  PRIMARY KEY (DNI_Cliente)
);

INSERT INTO Cliente (DNI_Cliente, Nombre) VALUES ('456789z', 'Acevedoni');
INSERT INTO Cliente (DNI_Cliente, Nombre) VALUES ('555555x', 'Marleoni');
INSERT INTO Cliente (DNI_Cliente, Nombre) VALUES ('77777s', 'Tabaroni');

SELECT * FROM Cliente;


-- Creacion de la tabla Empleado
CREATE TABLE Empleado (
  DNI_Empleado VARCHAR(9),
  Nombre VARCHAR(50),
  Fecha_Ini_Contrato DATE,
  Fecha_Fin_Contrato DATE,

  PRIMARY KEY (DNI_Empleado)
);

INSERT INTO Empleado (DNI_Empleado, Nombre, Fecha_Ini_Contrato,  Fecha_Fin_Contrato) VALUES ('363636m', 'Alavalaro', '01/03/2021', '01/03/2025');
INSERT INTO Empleado (DNI_Empleado, Nombre, Fecha_Ini_Contrato,  Fecha_Fin_Contrato) VALUES ('777777m', 'Pedro Pico', '06/02/2020', '01/03/2026');
INSERT INTO Empleado (DNI_Empleado, Nombre, Fecha_Ini_Contrato,  Fecha_Fin_Contrato) VALUES ('555555m', 'Fernendado', '05/07/2019', '01/03/2027');

SELECT * FROM Empleado;


-- Creacion de la tabla Trabaja
CREATE TABLE IF NOT EXISTS Trabaja (
  DNI_Empleado VARCHAR(9) NOT NULL,
  ID_Local INT NOT NULL,

  PRIMARY KEY (DNI_Empleado, ID_Local),

  FOREIGN KEY (DNI_Empleado)
    REFERENCES Empleado (DNI_Empleado)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (ID_Local)
    REFERENCES Local (ID_Local)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO Trabaja (DNI_Empleado, ID_Local) VALUES ('555555m',333);
INSERT INTO Trabaja (DNI_Empleado, ID_Local) VALUES ('777777m',333);
INSERT INTO Trabaja (DNI_Empleado, ID_Local) VALUES ('777777m',444);
INSERT INTO Trabaja (DNI_Empleado, ID_Local) VALUES ('363636m',444);

SELECT * FROM Trabaja;


-- Creacion del tipo de contrato
CREATE TYPE Tipo_Contrato_Enum AS ENUM ('Puntual', 'Periodico');


-- Creacion de la tabla Registro
CREATE TABLE IF NOT EXISTS Registro (
  DNI_Cliente VARCHAR(9),
  DNI_Empleado VARCHAR(9),
  ID_Local INT,
  Fecha_Ini_Contrato DATE,
  Fecha_Fin_Contrato DATE,
  Tipo_Contrato Tipo_Contrato_Enum,

  PRIMARY KEY (DNI_Cliente, DNI_Empleado, ID_Local, Fecha_Fin_Contrato),

  FOREIGN KEY (DNI_Cliente)
    REFERENCES Cliente (DNI_Cliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (DNI_Empleado)
    REFERENCES Empleado (DNI_Empleado)
    ON DELETE NO ACTION  -- Los contratos de los clientes no se ven afectados por los despidos de los empleados
    ON UPDATE CASCADE,
  FOREIGN KEY (ID_Local)
    REFERENCES Local (ID_Local)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO Registro (DNI_Cliente, DNI_Empleado, ID_Local, Fecha_Ini_Contrato, Fecha_Fin_Contrato, Tipo_Contrato) VALUES ('456789z', '363636m', 444, '05/02/2022', '06/02/2022', 'Puntual');
INSERT INTO Registro (DNI_Cliente, DNI_Empleado, ID_Local, Fecha_Ini_Contrato, Fecha_Fin_Contrato, Tipo_Contrato) VALUES ('456789z', '777777m', 444, '01/01/2022', '01/02/2022', 'Periodico');
INSERT INTO Registro (DNI_Cliente, DNI_Empleado, ID_Local, Fecha_Ini_Contrato, Fecha_Fin_Contrato, Tipo_Contrato) VALUES ('555555x', '777777m', 333, '05/02/2022', '05/02/2022', 'Puntual');
INSERT INTO Registro (DNI_Cliente, DNI_Empleado, ID_Local, Fecha_Ini_Contrato, Fecha_Fin_Contrato, Tipo_Contrato) VALUES ('77777s', '555555m', 333, '01/02/2022', '01/03/2022', 'Periodico');

SELECT * FROM Registro;


-- Creacion de la tabla Zona
CREATE TABLE IF NOT EXISTS Zona (
  ID_Zona INT NOT NULL,
  ID_Local INT NOT NULL,
  Nombre VARCHAR(50),
  Dimensiones VARCHAR(50),

  PRIMARY KEY (ID_Zona),

  FOREIGN KEY (ID_Local)
    REFERENCES Local (ID_Local)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO Zona (ID_Zona, ID_Local, Nombre, Dimensiones) VALUES (32, 333, 'Infantil', '10x10');
INSERT INTO Zona (ID_Zona, ID_Local, Nombre, Dimensiones) VALUES (38, 333, 'Outdoor', '25x30');
INSERT INTO Zona (ID_Zona, ID_Local, Nombre, Dimensiones) VALUES (43, 444, 'Ninja', '10x15');
INSERT INTO Zona (ID_Zona, ID_Local, Nombre, Dimensiones) VALUES (46, 444, 'Cringe', '20x5');

SELECT * FROM Zona;



-- Creacion del tipo de bien
CREATE TYPE Tipo_Bien_Enum AS ENUM ('Venta', 'Alquiler', 'Posesion');


-- Creacion de la tabla Bien
CREATE TABLE IF NOT EXISTS Bien (
  ID_Bien INT NOT NULL,
  ID_Local INT NOT NULL,
  Nombre VARCHAR(50) NOT NULL,
  Precio_Compra FLOAT,
  Precio_Venta FLOAT,
  Tipo_Bien Tipo_Bien_Enum,
  Descripcion VARCHAR(50),
  Marca VARCHAR(25),
  Fecha_Adquisicion DATE,

  PRIMARY KEY (ID_Bien),

  FOREIGN KEY (ID_Local)
    REFERENCES Local (ID_Local)
    ON DELETE NO ACTION  
    ON UPDATE CASCADE
);

INSERT INTO Bien (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion) 
VALUES           (01, 444, 'Gatos Tarantulace 42', 65, 3, 'Alquiler', 'Gama media', 'La Sportiva', '02-03-1999');
INSERT INTO Bien (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion) 
VALUES           (02, 333, 'Gatos Miura 42', 112, 5, 'Alquiler', 'Gama alta', 'La Sportiva', '02-03-2001');
INSERT INTO Bien (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion) 
VALUES           (03, 444, 'Cepillo extensible', 78, 0, 'Posesion', 'Para moon', 'Olimpia Oensusia', '02-03-2021');
INSERT INTO Bien (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion) 
VALUES           (04, 444, 'Crashpad Ocun Pillow', 225, 3, 'Alquiler', 'En zona moon', 'Ocun', '02-03-2002');
SELECT * FROM Bien;


-- Creacion de la tabla Presa
CREATE TABLE IF NOT EXISTS Presa (
  Nivel_Suciedad VARCHAR(25),
  Dimensiones VARCHAR(45),
  Color VARCHAR(20),
  Textura VARCHAR(20)
) INHERITS (Bien);

INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (05, 444, 'Volumen Mediano', 77, 0, 'Posesion', 'Romo con freno', 'Euroholds', '06-03-2022', 'Impio', '80x50', 'Rojo Claro', 'Porosidad Extrema');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (06, 444, 'Volumen Grande', 100, 0, 'Posesion', 'Multicanto', 'EHT', '06-04-2022', 'Limpio', '110x70', 'Verde', 'Semiliso');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (07, 444, 'Regleta positiva', 23, 0, 'Posesion', 'Pequeña pero comoda', 'AO', '06-05-2022', 'Sucio', '10x8', 'Amarillo', 'Porosidad Ligera');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (08, 444, 'Telefono una mano', 15, 0, 'Posesion', 'Muy comoda', 'AO', '06-05-2022', 'Limpia', '26x8', 'Verde', 'Porosidad Media');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (14, 444, 'Canto doble', 19, 0, 'Posesion', 'Muy comoda', 'AO', '06-05-2022', 'Limpia', '20x8', 'Verde', 'Porosidad baja');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (09, 444, 'Volumen Mediano', 77, 0, 'Posesion', 'Romo con freno', 'Euroholds', '06-03-2022', 'Impio', '80x50', 'Rojo Claro', 'Porosidad Extrema');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (10, 444, 'Regleta Campus 25', 100, 0, 'Posesion', 'Regleta', 'Elregletaso', '06-06-2022', 'Limpio', '100x8', 'Madera', 'Madera porosa');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (11, 444, 'Regleta Campus 25', 100, 0, 'Posesion', 'Pequeña pero comoda', 'AO', '06-05-2022', 'Sucio', '10x8', 'Amarillo', 'Porosidad Ligera');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (12, 444, 'Regleta Campus 25', 100, 0, 'Posesion', 'Muy comoda', 'AO', '06-05-2022', 'Limpia', '26x8', 'Verde', 'Porosidad Media');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (13, 444, 'Regleta Campus 25', 100, 0, 'Posesion', 'Muy comoda', 'AO', '06-05-2022', 'Limpia', '20x8', 'Verde', 'Porosidad baja');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (14, 444, 'Regleta Campus 25', 100, 0, 'Posesion', 'Regleta', 'Elregletaso', '06-06-2022', 'Limpio', '100x8', 'Madera', 'Madera porosa');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (15, 444, 'Regleta Campus 25', 100, 0, 'Posesion', 'Regleta', 'Elregletaso', '06-06-2022', 'Limpio', '100x8', 'Madera', 'Madera porosa');
INSERT INTO Presa (ID_Bien, ID_Local, Nombre, Precio_Compra, Precio_Venta, Tipo_Bien, Descripcion, Marca, Fecha_Adquisicion, Nivel_Suciedad, Dimensiones, Color, Textura)
            VALUES (16, 444, 'Regleta Campus 25', 100, 0, 'Posesion', 'Regleta', 'Elregletaso', '06-06-2022', 'Limpio', '100x8', 'Madera', 'Madera porosa');

SELECT ID_Bien, Nombre, Tipo_Bien, Marca, Dimensiones, Textura FROM Presa FETCH FIRST 8 ROWS ONLY;


-- Creacion de la tabla Problema
DROP TABLE IF EXISTS Problema;
CREATE TABLE IF NOT EXISTS Problema (
  ID_Problema INT NOT NULL,
  Dificultad VARCHAR(20),
  Lista_Presas INT[], -- ToDo: Trigger para comprobar que las presas insertadas existen

  PRIMARY KEY (ID_Problema)
);

INSERT INTO Problema (ID_Problema, Dificultad, Lista_Presas) VALUES (0, 'Roja', ARRAY[5,14,8,6,7,9]);
INSERT INTO Problema (ID_Problema, Dificultad, Lista_Presas) VALUES (1, 'Negra', ARRAY[5,8,7,9]);
-- INSERT INTO Problema (ID_Problema, Dificultad, Lista_Presas) VALUES (2, 'Verde', ARRAY[8, 7, 9]);
-- INSERT INTO Problema (ID_Problema, Dificultad, Lista_Presas) VALUES (3, 'Verde', ARRAY[8, 7, 9, 14, 99]);

SELECT * FROM Problema;


-- --------------------------------------
-- Function comprobar_presas
-- --------------------------------------
DROP FUNCTION IF EXISTS comprobar_presas;
CREATE OR REPLACE FUNCTION comprobar_presas() RETURNS TRIGGER AS $comprobar_presas$
  BEGIN
    FOR i IN 1.. array_length(new.Lista_Presas, 1) loop
      IF NOT EXISTS(SELECT * FROM Presa WHERE (
            Presa.ID_Bien = new.Lista_Presas[i]
          )) THEN
        RAISE EXCEPTION 'No existe una de las presas de las que se compone el problema';
      END IF;
    END loop;
    RETURN new;
  END;
$comprobar_presas$ LANGUAGE plpgsql;

-- --------------------------------------
-- Trigger trigger_presas_existen
-- Crear un disparador que permita verificar que cada una de las presas de la lista del problema existen realmente.
-- --------------------------------------
CREATE TRIGGER trigger_presas_existen
  BEFORE INSERT ON Problema
    FOR EACH ROW EXECUTE PROCEDURE comprobar_presas();




-- Creacion de la tabla Panel
CREATE TABLE IF NOT EXISTS Panel (
  ID_Panel INT NOT NULL,
  Superficie FLOAT,
  Inclinacion FLOAT,

  PRIMARY KEY (ID_Panel)
);

INSERT INTO Panel (ID_Panel, Superficie, Inclinacion) VALUES (0, 6.6, 45);
INSERT INTO Panel (ID_Panel, Superficie, Inclinacion) VALUES (1, 4.2, 42);
INSERT INTO Panel (ID_Panel, Superficie, Inclinacion) VALUES (2, 8, 40);
INSERT INTO Panel (ID_Panel, Superficie, Inclinacion) VALUES (3, 12, 50);

SELECT * FROM Panel;


-- Creacion de la tabla Pared
CREATE TABLE IF NOT EXISTS Pared (
  ID_Pared INT NOT NULL,
  ID_Zona INT,
  Superficie FLOAT,
  Lista_Paneles INT[],

  PRIMARY KEY (ID_Pared),

  FOREIGN KEY (ID_Zona)
    REFERENCES Zona (ID_Zona)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO Pared (ID_Pared, ID_Zona, Superficie, Lista_Paneles) VALUES (0, 32, 45, ARRAY[0, 1]);
INSERT INTO Pared (ID_Pared, ID_Zona, Superficie, Lista_Paneles) VALUES (1, 32, 45, ARRAY[2, 3]);
INSERT INTO Pared (ID_Pared, ID_Zona, Superficie, Lista_Paneles) VALUES (2, 32, 45, ARRAY[0, 4]);

SELECT * FROM Pared;


-- --------------------------------------
-- Function comprobar_paneles
-- --------------------------------------
DROP FUNCTION IF EXISTS comprobar_paneles;
CREATE OR REPLACE FUNCTION comprobar_paneles() RETURNS TRIGGER AS $comprobar_paneles$
  BEGIN
    FOR i IN 1.. array_length(new.Lista_Paneles, 1) loop
      IF NOT EXISTS(SELECT * FROM Panel WHERE (
            Panel.ID_Panel = new.Lista_Paneles[i]
          )) THEN
        RAISE EXCEPTION 'No existe uno de los paneles de los que se compone la pared';
      END IF;
    END loop;
    RETURN new;
  END;
$comprobar_paneles$ LANGUAGE plpgsql;

-- --------------------------------------
-- Trigger trigger_paneles_existen
-- Crear un disparador que permita verificar que cada uno de las paneles de la lista de la pared existen realmente.
-- --------------------------------------
CREATE TRIGGER trigger_paneles_existen
  BEFORE INSERT ON Pared
    FOR EACH ROW EXECUTE PROCEDURE comprobar_paneles();




-- Creacion del tipo de escalada
CREATE TYPE Tipo_Escalada_Enum AS ENUM ('Deportiva', 'Boulder');


-- Creacion de la tabla Escalada
CREATE TABLE IF NOT EXISTS Escalada (
  Tipo_Escalada Tipo_Escalada_Enum,
  Altura FLOAT NULL,
  Lista_Problemas INT[]  -- ToDo: Trigger para comprobar que los problemas insertados existen
) INHERITS (zona);

INSERT INTO Escalada (ID_Zona, ID_Local, Nombre, Dimensiones, Tipo_Escalada, Altura, Lista_Problemas) VALUES (100, 333, 'Capitan', '15x10', 'Deportiva', '60', ARRAY[0,1]);
-- INSERT INTO Escalada (ID_Zona, ID_Local, Nombre, Dimensiones, Tipo_Escalada, Altura, Lista_Problemas) VALUES (102, 333, 'Fake', '12x10', 'Deportiva', '75', ARRAY[8]);
-- INSERT INTO Escalada (ID_Zona, ID_Local, Nombre, Dimensiones, Tipo_Escalada, Altura, Lista_Problemas) VALUES (102, 333, 'Fake', '12x10', 'Deportiva', '75', ARRAY[0, 1, 8]);
SELECT * FROM Escalada;


-- --------------------------------------
-- Function comprobar_problemas
-- --------------------------------------
DROP FUNCTION IF EXISTS comprobar_problemas;
CREATE OR REPLACE FUNCTION comprobar_problemas() RETURNS TRIGGER AS $comprobar_problemas$
  BEGIN
    FOR i IN 1.. array_length(new.Lista_Problemas, 1) loop
      IF NOT EXISTS(SELECT * FROM Problema WHERE (
            Problema.ID_Problema = new.Lista_Problemas[i]
          )) THEN
        RAISE EXCEPTION 'No existe uno de las problemas de las que se compone la zona';
      END IF;
    END loop;
    RETURN new;
  END;
$comprobar_problemas$ LANGUAGE plpgsql;

-- --------------------------------------
-- Trigger trigger_problemas_existen
-- Crear un disparador que permita verificar que cada uno de las problemas de la zona existen realmente.
-- --------------------------------------
CREATE TRIGGER trigger_problemas_existen
  BEFORE INSERT ON Escalada
    FOR EACH ROW EXECUTE PROCEDURE comprobar_problemas();





-- Creacion de la tabla Campus
CREATE TABLE IF NOT EXISTS Campus (
  Lista_Presas INT[] NOT NULL  -- ToDo: Trigger para comprobar que las presas insertadas existen
) INHERITS (Zona);

INSERT INTO Campus (ID_Zona, ID_Local, Nombre, Dimensiones, Lista_Presas) VALUES (101, 333, 'Campus Regleta', '5x7', ARRAY[13, 14, 15, 16]);

SELECT * FROM Campus;

CREATE TRIGGER trigger_presas_existen_campus
  BEFORE INSERT ON Campus
    FOR EACH ROW EXECUTE PROCEDURE comprobar_presas();



SELECT * FROM Campus;
SELECT * FROM Problema;
SELECT ID_Bien, Nombre, Tipo_Bien, Marca, Dimensiones, Textura FROM Presa FETCH FIRST 8 ROWS ONLY;
SELECT * FROM Pared;
SELECT * FROM Panel;
SELECT * FROM Bien FETCH FIRST 8 ROWS ONLY;
SELECT * FROM Escalada;
SELECT * FROM Zona;
SELECT * FROM Registro;
SELECT * FROM Trabaja;
SELECT * FROM Empleado;
SELECT * FROM Cliente;
SELECT * FROM Local;
