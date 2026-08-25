select
    cast(cc as integer) as cc,
    trim(nombre) as nombre,
    trim(apellidos) as apellidos,
    trim(telefono) as telefono
from {{ source('ventas_oltp', 'cliente') }}
