CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_artkz_display
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT display_id,
  CASE
  WHEN display_id = 0
  THEN 'kein Displayartikel'
  ELSE display_bez
  END AS display_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_display
WHERE mandant_id = 1;