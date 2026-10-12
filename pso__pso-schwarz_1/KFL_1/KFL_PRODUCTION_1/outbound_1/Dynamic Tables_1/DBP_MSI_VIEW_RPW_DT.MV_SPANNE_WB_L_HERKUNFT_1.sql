CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_spanne_wb_l_herkunft_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT spr_id AS spanne_wb_herkunft_id,
  CASE
  WHEN spr_id = 1
  THEN 'Umlagerung_1 VZ => VZ oder Lieferant => Markt                            '
  WHEN spr_id = 2
  THEN 'Dezentral Lieferant => VZ/Markt sowie Umlagerung_1 Markt => Markt'
  WHEN spr_id = 3
  THEN 'Zentral VZ => Markt (""Faktura"")'
  ELSE NULL
  END AS spanne_wb_herkunft_bez
FROM kfl_production_dbp_view.v_spr_1
WHERE spr_id IN (1, 2, 3);