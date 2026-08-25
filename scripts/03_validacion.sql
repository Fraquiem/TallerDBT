-- Conteo por tabla
SELECT 'cliente' AS tabla, COUNT(*) AS registros FROM cliente
UNION ALL SELECT 'empleado', COUNT(*) FROM empleado
UNION ALL SELECT 'producto', COUNT(*) FROM producto
UNION ALL SELECT 'orden_venta', COUNT(*) FROM orden_venta
UNION ALL SELECT 'venta', COUNT(*) FROM venta
UNION ALL SELECT 'orden_productos', COUNT(*) FROM orden_productos
ORDER BY tabla;

-- Cada resultado debe ser cero
SELECT 'orden_cliente_sin_correspondencia' AS validacion, COUNT(*) AS errores
FROM orden_venta o LEFT JOIN cliente c ON c.cc = o.cc WHERE c.cc IS NULL
UNION ALL
SELECT 'orden_empleado_sin_correspondencia', COUNT(*)
FROM orden_venta o LEFT JOIN empleado e ON e.id_empleado = o.id_empleado WHERE e.id_empleado IS NULL
UNION ALL
SELECT 'venta_sin_orden', COUNT(*)
FROM venta v LEFT JOIN orden_venta o ON o.nro = v.nro WHERE o.nro IS NULL
UNION ALL
SELECT 'detalle_sin_producto', COUNT(*)
FROM orden_productos d LEFT JOIN producto p ON p.codigo = d.codigo WHERE p.codigo IS NULL
UNION ALL
SELECT 'detalle_sin_orden', COUNT(*)
FROM orden_productos d LEFT JOIN orden_venta o ON o.nro = d.nro WHERE o.nro IS NULL
UNION ALL
SELECT 'cantidad_invalida', COUNT(*) FROM orden_productos WHERE cantidad <= 0
UNION ALL
SELECT 'descuento_invalido', COUNT(*) FROM orden_productos WHERE descuento < 0 OR descuento > 1
UNION ALL
SELECT 'fecha_venta_invalida', COUNT(*)
FROM venta v JOIN orden_venta o ON o.nro = v.nro WHERE v.fecha_venta < o.fecha_solicitud;

-- Deben existir ambos estados
SELECT CASE WHEN v.nro IS NULL THEN 'pendiente' ELSE 'vendida' END AS estado,
       COUNT(*) AS ordenes
FROM orden_venta o
LEFT JOIN venta v ON v.nro = o.nro
GROUP BY CASE WHEN v.nro IS NULL THEN 'pendiente' ELSE 'vendida' END
ORDER BY estado;
