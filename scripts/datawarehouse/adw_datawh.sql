
CREATE DATABASE IF NOT EXISTS adw_datawh;

USE adw_datawh;




CREATE TABLE
    IF NOT EXISTS dim_tienda
(
    tienda_key    INT          NOT NULL AUTO_INCREMENT,
    tienda_id     INT          NOT NULL,
    tienda_pais   VARCHAR(100) NOT NULL,
    tienda_estado VARCHAR(100) NOT NULL,
    tienda_ciudad VARCHAR(100) NOT NULL,
    tienda_nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY (tienda_key)
);



 CREATE TABLE IF NOT EXISTS dim_vendedor
(
    vendedor_key    INT(8)      NOT NULL AUTO_INCREMENT,
    vendedor_id     VARCHAR(64) NOT NULL,
    vendedor_nombre VARCHAR(64) NOT NULL,
    vendedor_edad   int(3)      NOT NULL,
    vendedor_sexo   VARCHAR(20) NOT NULL,
    PRIMARY KEY (vendedor_key)
);



CREATE TABLE
    IF NOT EXISTS dim_producto
(
    producto_key          INT          NOT NULL AUTO_INCREMENT,
    producto_id           INT          NOT NULL,
    producto_nombre       VARCHAR(100) NOT NULL,
    producto_categoria    VARCHAR(100) NOT NULL,
    producto_subcategoria VARCHAR(100) NOT NULL,
    producto_color        VARCHAR(64)  NULL,
    producto_tamanio      VARCHAR(64)  NULL,
    producto_peso         varchar(20)   NULL,
    PRIMARY KEY (producto_key)
);



CREATE TABLE
    IF NOT EXISTS dim_fecha
(
    fecha_key  INT(8)      NOT NULL,
    fecha      DATETIME    NOT NULL DEFAULT (CURRENT_DATE),
    anio       int(4)      NULL     DEFAULT NULL,
    mes        int(2)      NULL     DEFAULT NULL,
    dia        VARCHAR(64) NULL     DEFAULT NULL,
    dia_semana VARCHAR(20) NULL     DEFAULT NULL,
    trimestre  VARCHAR(50) NULL     DEFAULT NULL,
    PRIMARY KEY (fecha_key) #   INDEX customer_id (customer_id) VISIBLE
);



CREATE TABLE
    IF NOT EXISTS fact_orden
(
    orden_key       INT    NOT NULL AUTO_INCREMENT,
    orden_id        INT    NOT NULL,
    orden_ingresos  decimal(38,6)   NOT NULL,
    orden_costos    decimal(38,6)    NOT NULL,
    orden_utilidad  decimal(38,6)   NOT NULL,
    orden_cantidad  decimal(38,6)    NOT NULL,
    orden_descuento decimal(38,6)    NOT NULL,
    fecha_key       INT(8) NOT NULL,
    vendedor_key    INT(8) NOT NULL,
    producto_key    INT(8) NOT NULL,
    tienda_key      INT(8) NOT NULL,
    PRIMARY KEY (orden_key),
    CONSTRAINT fk_dim_fecha FOREIGN KEY (fecha_key) REFERENCES dim_fecha (fecha_key) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT fk_dim_vendedor FOREIGN KEY (vendedor_key) REFERENCES dim_vendedor (vendedor_key) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT fk_dim_producto FOREIGN KEY (producto_key) REFERENCES dim_producto (producto_key) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT fk_dim_tienda FOREIGN KEY (tienda_key) REFERENCES dim_tienda (tienda_key) ON DELETE CASCADE ON UPDATE NO ACTION
);
