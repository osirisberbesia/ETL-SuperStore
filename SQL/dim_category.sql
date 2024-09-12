SELECT
    detail_category,
    ROW_NUMBER() OVER () AS id_category  -- Generar id_subcategory secuencial
FROM (
    SELECT DISTINCT
        category AS detail_category
    FROM
        `id-superstore.datos_superstore.tabla-superstore`
) AS unique_categories;
