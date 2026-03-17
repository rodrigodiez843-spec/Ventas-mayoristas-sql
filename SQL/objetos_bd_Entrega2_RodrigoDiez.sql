USE ventas_mayoristas;

-- 
-- VISTAS
-- 
CREATE VIEW vw_ventas_por_provincia AS
SELECT 
p.provincia,
SUM(v.cantidad * v.precio_venta) AS ventas_totales
FROM ventas v
JOIN clientes c ON v.cliente_id = c.cliente_id
JOIN provincias p ON c.provincia_id = p.provincia_id
GROUP BY p.provincia;


CREATE VIEW vw_ventas_por_vendedor AS
SELECT 
ve.vendedor_id,
ve.nombre,
ve.apellido,
SUM(v.cantidad * v.precio_venta) AS total_vendido
FROM ventas v
JOIN vendedores ve ON v.vendedor_id = ve.vendedor_id
GROUP BY ve.vendedor_id, ve.nombre, ve.apellido;


CREATE VIEW vw_productos_mas_vendidos AS
SELECT 
p.descripcion,
SUM(v.cantidad) AS unidades_vendidas
FROM ventas v
JOIN productos p ON v.producto_id = p.producto_id
GROUP BY p.descripcion
ORDER BY unidades_vendidas DESC;

-- 
-- FUNCIONES
--

DELIMITER //

CREATE FUNCTION fn_total_venta(
cantidad INT,
precio DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
RETURN cantidad * precio;
END //

CREATE FUNCTION fn_margen_producto(
precio DECIMAL(10,2),
costo DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
RETURN precio - costo;
END //

-- 
-- STORED PROCEDURES
-- 

CREATE PROCEDURE sp_ventas_por_provincia(
IN provincia_nombre VARCHAR(50)
)
BEGIN

SELECT 
p.provincia,
SUM(v.cantidad * v.precio_venta) AS total_ventas
FROM ventas v
JOIN clientes c ON v.cliente_id = c.cliente_id
JOIN provincias p ON c.provincia_id = p.provincia_id
WHERE p.provincia = provincia_nombre
GROUP BY p.provincia;

END //

CREATE PROCEDURE sp_ventas_por_fecha(
IN fecha_inicio DATE,
IN fecha_fin DATE
)
BEGIN

SELECT *
FROM ventas
WHERE fecha BETWEEN fecha_inicio AND fecha_fin;

END //

-- 
-- TRIGGER
-- 

CREATE TRIGGER trg_validar_cantidad
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN

IF NEW.cantidad <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'La cantidad debe ser mayor a cero';
END IF;

END //

DELIMITER ;
