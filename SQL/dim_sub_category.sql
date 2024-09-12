SELECT
    detail_sub_category,
    ROW_NUMBER() OVER () AS id_subcategory  -- Generar id_subcategory secuencial
FROM (
    SELECT DISTINCT
        sub_category AS detail_sub_category
    FROM
        `id-superstore.datos_superstore.tabla-superstore`
) AS unique_subcategories;
