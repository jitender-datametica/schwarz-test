CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_gp_fehlerart_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
  CASE
  WHEN gp_fehlerart_id = ''
  THEN '0'
  ELSE gp_fehlerart_id
  END AS gp_fehlerart_id
FROM kfl_production_dbp_view.v_l_gp_fehlerart_2
WHERE mandant_id = 1;