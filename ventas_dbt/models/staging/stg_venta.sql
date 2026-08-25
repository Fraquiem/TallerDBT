select
    cast(nro as integer) as nro,
    cast(fecha_venta as date) as fecha_venta,
    trim(descripcion) as descripcion
from {{ source('ventas_oltp', 'venta') }}
