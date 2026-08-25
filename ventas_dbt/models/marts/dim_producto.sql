select
    md5('producto|' || cast(codigo as varchar)) as producto_sk,
    codigo,
    nombre,
    precio
from {{ ref('stg_producto') }}
