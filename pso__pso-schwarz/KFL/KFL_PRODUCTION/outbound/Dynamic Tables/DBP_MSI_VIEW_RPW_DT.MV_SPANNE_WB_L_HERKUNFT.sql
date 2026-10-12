CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_spanne_wb_l_herkunft
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT spr_id AS spanne_wb_herkunft_id,
  CASE
  WHEN spr_id = 1
  THEN 'Umlagerung VZ => VZ oder Lieferant => Markt                            '
  WHEN spr_id = 2
  THEN 'Dezentral Lieferant => VZ/Markt sowie Umlagerung Markt => Markt'
  WHEN spr_id = 3
  THEN 'Zentral VZ => Markt (""Faktura"")'
  ELSE NULL
  END AS spanne_wb_herkunft_bez
FROM kfl_production_dbp_view.v_spr
WHERE spr_id IN (1, 2, 3);