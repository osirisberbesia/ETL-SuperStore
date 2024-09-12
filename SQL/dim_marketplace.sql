WITH
  -- Seleccionamos los mercados de chain_market-competitors
  chain_market AS (
    SELECT
      id_market_chain,
      market AS market_chain_market
    FROM `id-superstore.datos_superstore.chain_market-competitors`
  ),
  -- Generamos un identificador de mercado secuencial
  markets AS (
    SELECT DISTINCT
      market_chain_market
    FROM chain_market
  ),
  markets_with_id AS (
    SELECT
      ROW_NUMBER() OVER() AS id_market,
      market_chain_market AS market,
      market_chain_market AS market2
    FROM markets
  ),
  -- Expande la lista de mercados en filas individuales
  markets_expanded AS (
    SELECT
      id_market_chain,
      TRIM(market_name) AS market_name
    FROM
      chain_market
    CROSS JOIN
      UNNEST(SPLIT(market_chain_market, ', ')) AS market_name
  ),
  -- Generamos las columnas dummy basadas en los mercados especificados
  dummy_columns AS (
    SELECT
      id_market_chain,
      MAX(CASE WHEN market_name = 'EMEA' THEN 1 ELSE 0 END) AS market_EMEA,
      MAX(CASE WHEN market_name = 'APAC' THEN 1 ELSE 0 END) AS market_APAC,
      MAX(CASE WHEN market_name = 'LATAM' THEN 1 ELSE 0 END) AS market_LATAM,
      MAX(CASE WHEN market_name = 'EU' THEN 1 ELSE 0 END) AS market_EU,
      MAX(CASE WHEN market_name = 'North America' THEN 1 ELSE 0 END) AS market_North_America
    FROM
      markets_expanded
    GROUP BY
      id_market_chain
  )

-- Consulta final combinando la tabla dummy con la original y agregando la columna de mercados concatenados
SELECT
  ROW_NUMBER() OVER(PARTITION BY cm.id_market_chain ORDER BY mw.id_market) AS id_market,
  cm.id_market_chain,
  mw.market2 AS market2,
  COALESCE(dc.market_EMEA, 0) AS market_EMEA,
  COALESCE(dc.market_APAC, 0) AS market_APAC,
  COALESCE(dc.market_LATAM, 0) AS market_LATAM,
  COALESCE(dc.market_EU, 0) AS market_EU,
  COALESCE(dc.market_North_America, 0) AS market_North_America
FROM
  chain_market cm
JOIN
  markets_with_id mw
ON
  cm.market_chain_market = mw.market
LEFT JOIN
  dummy_columns dc
ON
  cm.id_market_chain = dc.id_market_chain
ORDER BY
  cm.id_market_chain, id_market;
