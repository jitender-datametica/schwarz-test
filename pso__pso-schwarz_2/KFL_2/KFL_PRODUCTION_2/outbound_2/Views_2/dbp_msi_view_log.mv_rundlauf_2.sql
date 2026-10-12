CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_rundlauf_2 AS (SELECT 10 AS rundlauf_transport_fg,
  'Industrieabholung' AS rundlauf_transport_bez
 FROM kfl_production_dbp_view.v_tag_2
 WHERE dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AND (CURRENT_DATE)
 UNION DISTINCT
 SELECT 1 AS rundlauf_transport_fg,
  'Rundlauf' AS rundlauf_transport_bez
 FROM kfl_production_dbp_view.v_tag_2
 WHERE dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AND (CURRENT_DATE))
UNION DISTINCT
SELECT 0 AS rundlauf_transport_fg,
 'OneWay' AS rundlauf_transport_bez
FROM kfl_production_dbp_view.v_tag_2
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AND (CURRENT_DATE);