SELECT
    ROW_NUMBER() OVER () AS id_ship,
    ship_mode,

FROM
    `id-superstore.datos_superstore.tabla-superstore`
GROUP BY
    ship_mode;
