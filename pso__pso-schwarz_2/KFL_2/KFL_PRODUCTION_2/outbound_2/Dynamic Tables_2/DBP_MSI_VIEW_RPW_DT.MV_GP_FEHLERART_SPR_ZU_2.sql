CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_gp_fehlerart_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
  CASE
  WHEN gp_fehlerart_id = ''
  THEN '0'
  ELSE gp_fehlerart_id
  END AS gp_fehlerart_id,
 spr_id,
 gp_fehlerart_bez
FROM kfl_production_dbp_view.v_gp_fehlerart_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;