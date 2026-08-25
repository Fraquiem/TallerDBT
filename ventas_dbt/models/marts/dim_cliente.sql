select
    md5('cliente|' || cast(cc as varchar)) as cliente_sk,
    cc,
    nombre,
    apellidos,
    telefono
from {{ ref('stg_cliente') }}
