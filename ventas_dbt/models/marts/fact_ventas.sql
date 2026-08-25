with detalle_vendido as (
    select
        v.nro,
        v.fecha_venta,
        o.cc,
        o.id_empleado,
        d.codigo,
        d.cantidad,
        d.descuento,
        p.precio as precio_unitario
    from {{ ref('stg_venta') }} v
    inner join {{ ref('stg_orden_venta') }} o on o.nro = v.nro
    inner join {{ ref('stg_orden_productos') }} d on d.nro = v.nro
    inner join {{ ref('stg_producto') }} p on p.codigo = d.codigo
)

select
    md5('venta|' || cast(d.nro as varchar) || '|' || cast(d.codigo as varchar)) as venta_sk,
    c.cliente_sk,
    e.empleado_sk,
    p.producto_sk,
    cast(strftime(d.fecha_venta, '%Y%m%d') as integer) as fecha_sk,
    d.nro,
    d.codigo,
    d.cantidad,
    d.precio_unitario,
    d.descuento,
    cast(d.cantidad * d.precio_unitario as decimal(18, 2)) as valor_bruto,
    cast(d.cantidad * d.precio_unitario * d.descuento as decimal(18, 2)) as valor_descuento,
    cast(d.cantidad * d.precio_unitario * (1 - d.descuento) as decimal(18, 2)) as valor_neto
from detalle_vendido d
inner join {{ ref('dim_cliente') }} c on c.cc = d.cc
inner join {{ ref('dim_empleado') }} e on e.id_empleado = d.id_empleado
inner join {{ ref('dim_producto') }} p on p.codigo = d.codigo
