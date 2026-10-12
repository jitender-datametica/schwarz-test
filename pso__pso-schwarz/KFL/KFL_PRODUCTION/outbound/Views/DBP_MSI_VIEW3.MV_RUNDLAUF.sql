CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_rundlauf AS (SELECT CAST(ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) AS BIGNUMERIC)
  AS mandant_id,
  10 AS rundlauf_transport_fg,
  'Industrieabholung' AS rundlauf_transport_bez
 FROM kfl_production_dbp_view.v_tag
 WHERE dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AND (CURRENT_DATE)
 UNION DISTINCT
 SELECT CAST(ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) AS BIGNUMERIC) AS mandant_id,
  1 AS rundlauf_transport_fg,
  'Rundlauf' AS rundlauf_transport_bez
 FROM kfl_production_dbp_view.v_tag
 WHERE dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AND (CURRENT_DATE))
UNION DISTINCT
SELECT CAST(ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) AS BIGNUMERIC) AS mandant_id,
 0 AS rundlauf_transport_fg,
 'OneWay' AS rundlauf_transport_bez
FROM kfl_production_dbp_view.v_tag
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AND (CURRENT_DATE);