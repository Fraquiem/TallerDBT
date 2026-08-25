select
    md5('empleado|' || cast(id_empleado as varchar)) as empleado_sk,
    id_empleado,
    nombre,
    apellidos,
    cargo
from {{ ref('stg_empleado') }}
