select
    cast(codigo as integer) as codigo,
    trim(nombre) as nombre,
    cast(precio as decimal(18, 2)) as precio
from {{ source('ventas_oltp', 'producto') }}
