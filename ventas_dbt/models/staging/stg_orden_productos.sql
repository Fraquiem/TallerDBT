select
    cast(codigo as integer) as codigo,
    cast(nro as integer) as nro,
    cast(descuento as decimal(5, 2)) as descuento,
    cast(cantidad as integer) as cantidad
from {{ source('ventas_oltp', 'orden_productos') }}
