\pset pager off

SET client_encoding = 'UTF8';

/*
 * Buscar en la documentación oficial de PostgreSQL:
 * REGEXP_MATCHES_TO_TABLE
 * RPLACE
 * REGEXP_REPLACE
 * MAKE_INTERVAL
 * 
 * COPY NOMBRE ARCHIVO FROM 'RUTA' DELIMITER 'DELIMITADOR' NULL 'NULL' CSV ENCODING 'UTF8';
 * ON DELETE RESTRICT ON UPDATE CASCADE  soLO PARA FOREIGN KEY
 * 
 * Igual sobran NOT NULL 
 */

BEGIN;
\echo 'creando el esquema para la BBDD de intercambio de discos'

CREATE TABLE IF NOT EXISTS Grupo(
    Nombre TEXT NOT NULL,
    Url_grupo TEXT -- NOT NULL
    CONSTRAINT pk_grupo PRIMARY KEY (Nombre)
);

CREATE TABLE IF NOT EXISTS Disco(
    Titulo TEXT NOT NULL, 
    Ano_publicacion INT NOT NULL,
    --Generos TEXT, -- MULTIEVALUADO no se ponen los generos
    Url_portada TEXT,
    Nombre_grupo TEXT NOT NULL,
    CONSTRAINT pk_disco PRIMARY KEY (Titulo, Ano_publicacion)
    CONSTRAINT fk_disco_grupo FOREIGN KEY (Nombre_grupo) REFERENCES Grupo(Nombre) 
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Generos(
    Titulo_disco TEXT,
    Ano_publicacion INT,
    Genero TEXT,    
    CONSTRAINT pk_genero PRIMARY KEY (Titulo_disco, Ano_publicacion, Genero) --revisar
    --CONSTRAINT fk_genero_disco FOREIGN KEY (Titulo_disco, Ano_publicacion) REFERENCES Disco(Titulo, Ano_publicacion) --revisar
    --ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Canciones(
    Titulo_cancion TEXT NOT NULL,
    Titulo_disco TEXT NOT NULL,
    Ano_publicacion INT NOT NULL,
    Duracion INT ,
    CONSTRAINT pk_cancion PRIMARY KEY (Titulo_cancion, Titulo_disco, Ano_publicacion) 
    CONSTRAINT fk_cancion_disco FOREIGN KEY (Titulo_disco, Ano_publicacion) REFERENCES Disco(Titulo, Ano_publicacion)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Ediciones(
    Titulo_disco TEXT NOT NULL,
    Ano_publicacion INT NOT NULL,
    Formato TEXT NOT NULL,
    Ano_edicion INT NOT NULL, --FORMAT('YYYY')
    Pais TEXT NOT NULL,
    CONSTRAINT pk_edicion PRIMARY KEY (Titulo_disco, Ano_publicacion, Formato, Ano_edicion, Pais)
);

CREATE TABLE IF NOT EXISTS Tiene(
    Nombre_user TEXT NOT NULL,
    Titulo_disco TEXT NOT NULL,
    Ano_publicacion INT NOT NULL,
    Formato TEXT NOT NULL,
    Ano_edicion INT NOT NULL,
    Pais TEXT NOT NULL,
    Estado TEXT,
    CONSTRAINT pk_tiene PRIMARY KEY (Nombre_user, Titulo_disco, Ano_publicacion, Formato, Ano_edicion, Pais)
    CONSTRAINT fk_tiene_user FOREIGN KEY (Nombre_user) REFERENCES Usuario(Nombre_user)
    ON DELETE RESTRICT ON UPDATE CASCADE
    CONSTRAINT fk_tiene_disco FOREIGN KEY (Titulo_disco, Ano_publicacion, Formato, Ano_edicion, Pais) REFERENCES Ediciones(Titulo_disco, Ano_publicacion, Formato, Ano_edicion, Pais)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Desea(
    Titulo_disco TEXT NOT NULL,
    Ano_publicacion INT NOT NULL,
    Nombre_user TEXT NOT NULL,
    CONSTRAINT pk_desea PRIMARY KEY (Titulo_disco, Ano_publicacion, Nombre_user)
    CONSTRAINT fk_desea_user FOREIGN KEY (Nombre_user) REFERENCES Usuario(Nombre_user)
    ON DELETE RESTRICT ON UPDATE CASCADE
    CONSTRAINT fk_desea_disco FOREIGN KEY (Titulo_disco, Ano_publicacion) REFERENCES Disco(Titulo, Ano_publicacion)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

\echo 'creando un esquema temporal'

-- NOMBRE TABLE, TEMPORAL.GRUPO, ETC

SET search_path='nombre del esquema o esquemas utilizados';

\echo 'Cargando datos'


\echo 'insertando datos en el esquema final'

\echo 'Consulta 1: texto de la consulta'

\echo 'Consulta n':


ROLLBACK;                       -- importante! permite correr el script multiples veces...p