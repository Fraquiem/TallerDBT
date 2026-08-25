select
    cast(id_empleado as integer) as id_empleado,
    trim(nombre) as nombre,
    trim(apellidos) as apellidos,
    trim(cargo) as cargo
from {{ source('ventas_oltp', 'empleado') }}
