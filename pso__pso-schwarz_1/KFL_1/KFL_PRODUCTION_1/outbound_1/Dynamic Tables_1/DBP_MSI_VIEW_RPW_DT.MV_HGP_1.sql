CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_hgp_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT gp_id AS hgp_id,
  CASE
  WHEN loesch_fg = 1
  THEN '{' || gp_name || '}'
  ELSE gp_name
  END AS gp_name,
 mandant_id,
 7 AS system_id,
 zek_id,
 COALESCE(loesch_fg, 0) AS loesch_fg,
 gp_branche_id
FROM kfl_production_dbp_view.v_gp_1
WHERE mandant_id = 1 AND (gp_id > 99999 AND gp_id < 1000000)
 OR gp_id BETWEEN 9211 AND 9220;