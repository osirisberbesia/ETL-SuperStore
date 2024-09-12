WITH sales_fact AS (
    SELECT
        customer_ID AS customer_id,
        '1' AS id_market,
        STRING_AGG(DISTINCT order_id, ',') AS order_id,
        STRING_AGG(DISTINCT product_id, ',') AS product_id,
        COUNT(product_id) AS productos_comprados,
        COUNTIF(EXTRACT(YEAR FROM order_date) = 2011) AS compras_2011,
        COUNTIF(EXTRACT(YEAR FROM order_date) = 2012) AS compras_2012,
        COUNTIF(EXTRACT(YEAR FROM order_date) = 2013) AS compras_2013,
        COUNTIF(EXTRACT(YEAR FROM order_date) = 2014) AS compras_2014,
        SUM(CASE WHEN ship_mode = 'Standard Class' THEN 1 ELSE 0 END) AS standard_class_count,
        SUM(CASE WHEN ship_mode = 'Second Class' THEN 1 ELSE 0 END) AS second_class_count,
        SUM(CASE WHEN ship_mode = 'First Class' THEN 1 ELSE 0 END) AS first_class_count,
        SUM(CASE WHEN ship_mode = 'Same Day' THEN 1 ELSE 0 END) AS same_day_count,
        -- Contar categorías
        SUM(CASE WHEN category = 'Office Supplies' THEN 1 ELSE 0 END) AS office_supplies_count,
        SUM(CASE WHEN category = 'Furniture' THEN 1 ELSE 0 END) AS furniture_count,
        SUM(CASE WHEN category = 'Technology' THEN 1 ELSE 0 END) AS technology_count,
        SUM(shipping_cost) AS ship_cost,
        -- Sumar costos de envío por clase
        SUM(CASE WHEN ship_mode = 'Standard Class' THEN shipping_cost ELSE 0 END) AS standard_class_ship_cost,
        SUM(CASE WHEN ship_mode = 'Second Class' THEN shipping_cost ELSE 0 END) AS second_class_ship_cost,
        SUM(CASE WHEN ship_mode = 'First Class' THEN shipping_cost ELSE 0 END) AS first_class_ship_cost,
        SUM(CASE WHEN ship_mode = 'Same Day' THEN shipping_cost ELSE 0 END) AS same_day_ship_cost,
        segment AS segment,
        STRING_AGG(DISTINCT country, ',') AS country,
        STRING_AGG(DISTINCT city, ',') AS city
    FROM
        `id-superstore.datos_superstore.tabla-superstore`
    GROUP BY
        customer_ID, segment
)
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS fact_id,
    order_id,
    customer_id,
    product_id,
    productos_comprados,
    compras_2011,
    compras_2012,
    compras_2013,
    compras_2014,
    standard_class_count, 
    second_class_count,
    first_class_count,
    same_day_count,
    ship_cost,
    standard_class_ship_cost,
    second_class_ship_cost,
    first_class_ship_cost,
    same_day_ship_cost,
    -- Agregar los conteos por categoría
    office_supplies_count,
    furniture_count,
    technology_count,
    segment,
    country,
    city
FROM
    sales_fact;
