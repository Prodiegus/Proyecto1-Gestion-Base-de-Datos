-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public."Almacenes"
(
    nif_estanco integer NOT NULL,
    marca text COLLATE pg_catalog."default" NOT NULL,
    filtro text COLLATE pg_catalog."default" NOT NULL,
    color text COLLATE pg_catalog."default" NOT NULL,
    clase text COLLATE pg_catalog."default" NOT NULL,
    mentol text COLLATE pg_catalog."default" NOT NULL,
    unidades integer DEFAULT 0,
    CONSTRAINT "Almacenes_pkey" PRIMARY KEY (nif_estanco, marca, filtro, color, clase, mentol)
);

CREATE TABLE IF NOT EXISTS public."Cigarrillos"
(
    marca text COLLATE pg_catalog."default" NOT NULL,
    filtro text COLLATE pg_catalog."default" NOT NULL,
    color text COLLATE pg_catalog."default" NOT NULL,
    clase text COLLATE pg_catalog."default" NOT NULL,
    mentol text COLLATE pg_catalog."default" NOT NULL,
    nicotina text COLLATE pg_catalog."default",
    alquitran text COLLATE pg_catalog."default",
    nombre_fabricante text COLLATE pg_catalog."default",
    precio_venta integer,
    precio_costo integer,
    carton integer,
    embalaje integer,
    CONSTRAINT "Cigarrillos_pkey" PRIMARY KEY (marca, filtro, color, clase, mentol)
);

CREATE TABLE IF NOT EXISTS public."Compras"
(
    nif_estanco integer NOT NULL,
    marca text COLLATE pg_catalog."default" NOT NULL,
    filtro text COLLATE pg_catalog."default" NOT NULL,
    color text COLLATE pg_catalog."default" NOT NULL,
    clase text COLLATE pg_catalog."default" NOT NULL,
    mentol text COLLATE pg_catalog."default" NOT NULL,
    fecha_compra date NOT NULL,
    c_comprada integer DEFAULT 0,
    precio_compra integer DEFAULT 0,
    CONSTRAINT "Compras_pkey" PRIMARY KEY (nif_estanco, marca, filtro, color, clase, mentol, fecha_compra)
);

CREATE TABLE IF NOT EXISTS public."Estancos"
(
    nif_estanco integer NOT NULL,
    num_expendeduria integer NOT NULL,
    cp_estanco integer NOT NULL,
    nombre_estanco text COLLATE pg_catalog."default",
    direccion_estanco text COLLATE pg_catalog."default",
    localidad_estanco text COLLATE pg_catalog."default",
    provincia_estanco text COLLATE pg_catalog."default",
    CONSTRAINT "Estancos_pkey" PRIMARY KEY (nif_estanco, num_expendeduria, cp_estanco)
);

CREATE TABLE IF NOT EXISTS public."Fabricantes"
(
    nombre_fabricante text COLLATE pg_catalog."default" NOT NULL,
    "país" text COLLATE pg_catalog."default",
    CONSTRAINT "Fabricantes_pkey" PRIMARY KEY (nombre_fabricante)
);

CREATE TABLE IF NOT EXISTS public."Ventas"
(
    nif_estanco integer NOT NULL,
    marca text COLLATE pg_catalog."default" NOT NULL,
    filtro text COLLATE pg_catalog."default" NOT NULL,
    color text COLLATE pg_catalog."default" NOT NULL,
    clase text COLLATE pg_catalog."default" NOT NULL,
    mentol text COLLATE pg_catalog."default" NOT NULL,
    fecha_venta date NOT NULL,
    c_vendida integer DEFAULT 0,
    precio_venta integer DEFAULT 0,
    CONSTRAINT "Ventas_pkey" PRIMARY KEY (mentol, clase, color, fecha_venta, nif_estanco, marca, filtro)
);

ALTER TABLE IF EXISTS public."Almacenes"
    ADD CONSTRAINT fk_cigarrillo FOREIGN KEY (filtro, mentol, clase, color, marca)
    REFERENCES public."Cigarrillos" (filtro, mentol, clase, color, marca) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Almacenes"
    ADD CONSTRAINT nif_estanco FOREIGN KEY (nif_estanco)
    REFERENCES public."Estancos" (nif_estanco) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS public."Cigarrillos"
    ADD CONSTRAINT nombre_fabricante FOREIGN KEY (nombre_fabricante)
    REFERENCES public."Fabricantes" (nombre_fabricante) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public."Compras"
    ADD CONSTRAINT fk_cigarrillo FOREIGN KEY (filtro, mentol, clase, color, marca)
    REFERENCES public."Cigarrillos" (filtro, mentol, clase, color, marca) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public."Compras"
    ADD CONSTRAINT fk_estanco FOREIGN KEY (nif_estanco)
    REFERENCES public."Estancos" (nif_estanco) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public."Ventas"
    ADD CONSTRAINT fk_cigarrillo FOREIGN KEY (filtro, mentol, clase, color, marca)
    REFERENCES public."Cigarrillos" (filtro, mentol, clase, color, marca) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public."Ventas"
    ADD CONSTRAINT fk_estanco FOREIGN KEY (nif_estanco)
    REFERENCES public."Estancos" (nif_estanco) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;