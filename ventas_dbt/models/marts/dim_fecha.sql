with limites as (
    select
        min(fecha_venta) as fecha_minima,
        max(fecha_venta) as fecha_maxima
    from {{ ref('stg_venta') }}
),

fechas as (
    select cast(valor as date) as fecha
    from limites,
         generate_series(fecha_minima, fecha_maxima, interval 1 day) as serie(valor)
)

select
    cast(strftime(fecha, '%Y%m%d') as integer) as fecha_sk,
    fecha,
    year(fecha) as anio,
    quarter(fecha) as trimestre,
    month(fecha) as mes,
    day(fecha) as dia,
    dayofweek(fecha) as dia_semana
from fechas
