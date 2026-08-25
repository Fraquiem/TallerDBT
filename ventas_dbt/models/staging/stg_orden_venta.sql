select
    cast(nro as integer) as nro,
    cast(fecha_solicitud as date) as fecha_solicitud,
    trim(domicilio) as domicilio,
    cast(cc as integer) as cc,
    cast(id_empleado as integer) as id_empleado
from {{ source('ventas_oltp', 'orden_venta') }}
