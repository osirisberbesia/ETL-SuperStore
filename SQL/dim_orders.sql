SELECT DISTINCT
    ts.order_id,
    od.id_ship,  
    ts.quantity,
    ts.discount,
    ts.sales,
    ts.order_date,
    ts.weeknum,
    ts.shipping_cost,
    ts.profit,
    ts.ship_date,
    ts.year,
    ts.region,
    order_priority
FROM
    `id-superstore.datos_superstore.tabla-superstore` AS ts
JOIN
    `id-superstore.datos_superstore.dim_order_details` AS od
ON
    ts.ship_mode = od.ship_mode; 
