SELECT
    product_id,
    MIN(product_name) AS product_name
FROM
    `id-superstore.datos_superstore.tabla-superstore`
GROUP BY
    product_id;