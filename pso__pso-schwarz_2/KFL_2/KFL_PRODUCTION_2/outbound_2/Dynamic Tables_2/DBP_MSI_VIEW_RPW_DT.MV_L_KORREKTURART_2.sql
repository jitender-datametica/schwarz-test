CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_korrekturart_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
  CASE
  WHEN korrekturart_id = ''
  THEN '0'
  ELSE korrekturart_id
  END AS korrekturart_id
FROM kfl_production_dbp_view.v_l_korrekturart_2
WHERE mandant_id = 1;