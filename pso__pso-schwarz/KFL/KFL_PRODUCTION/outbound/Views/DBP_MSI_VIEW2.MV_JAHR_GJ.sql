CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_jahr_gj (gj, akt_gj, akt_gj_komplett, akt_gj_help) AS SELECT gj,
 akt_gj,
 akt_gj_komplett,
  CASE
  WHEN EXTRACT(MONTH FROM CURRENT_DATE) = 3
  THEN akt_gj + 1
  ELSE akt_gj
  END AS akt_gj_help
FROM kfl_production_dbp_view.v_jahr_gj
WHERE gj > 2001;