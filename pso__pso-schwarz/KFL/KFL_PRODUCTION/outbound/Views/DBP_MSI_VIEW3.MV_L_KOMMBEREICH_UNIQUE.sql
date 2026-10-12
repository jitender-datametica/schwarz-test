CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_kommbereich_unique (komm_bereich) AS SELECT DISTINCT CASE
  WHEN TRIM(COALESCE(komm_bereich, '')) <> ''
  THEN komm_bereich
  ELSE 'kein Kommbereich'
  END AS komm_bereich
FROM kfl_production_dbp_view.v_l_lagerplatz;