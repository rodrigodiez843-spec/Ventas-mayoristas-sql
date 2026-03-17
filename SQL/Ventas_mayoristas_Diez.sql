-- =========================================
-- Proyecto: Base de Datos Ventas Mayoristas
-- Autor: Rodrigo Diez
-- Descripción: Modelo relacional para análisis de ventas
-- =========================================

-- Crear base de datos
CREATE DATABASE ventas_mayoristas;

-- Usar base de datos
USE ventas_mayoristas;

-- =========================================
-- Tabla: provincias
-- Contiene información geográfica
-- =========================================
CREATE TABLE provincias (
    provincia_id INT PRIMARY KEY,
    provincia VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);

-- =========================================
-- Tabla: clientes
-- Información de clientes mayoristas
-- =========================================
CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    nombre_comercial VARCHAR(100),
    tipo_local VARCHAR(50),
    provincia_id INT,
    FOREIGN KEY (provincia_id) REFERENCES provincias(provincia_id)
);

-- =========================================
-- Tabla: vendedores
-- Información del equipo comercial
-- =========================================
CREATE TABLE vendedores (
    vendedor_id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    provincia_id INT,
    FOREIGN KEY (provincia_id) REFERENCES provincias(provincia_id)
);

-- =========================================
-- Tabla: productos
-- Catálogo de productos comercializados
-- =========================================
CREATE TABLE productos (
    producto_id INT PRIMARY KEY,
    categoria VARCHAR(50),
    tipo VARCHAR(50),
    genero VARCHAR(50),
    origen VARCHAR(50),
    descripcion VARCHAR(100),
    costo_unitario DECIMAL(10,2)
);

-- =========================================
-- Tabla: ventas
-- Tabla de hechos del modelo
-- =========================================
CREATE TABLE ventas (
    venta_id INT PRIMARY KEY,
    fecha DATE NOT NULL,
    cliente_id INT,
    producto_id INT,
    vendedor_id INT,
    cantidad INT NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id),
    FOREIGN KEY (vendedor_id) REFERENCES vendedores(vendedor_id)
);

-- =========================================
-- Fin del script
-- =========================================
