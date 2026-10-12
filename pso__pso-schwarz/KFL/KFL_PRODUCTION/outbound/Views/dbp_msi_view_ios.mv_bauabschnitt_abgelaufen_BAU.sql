CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bauabschnitt_abgelaufen_bau (projekt_nr, bauabschnitt_id,
bauabschnitt_abgelaufen_kz) AS SELECT projekt_nr,
  CASE
  WHEN projekt_phase_id IS NOT NULL
  THEN projekt_id || '0000'
  ELSE NULL
  END AS bauabschnitt_id,
 MIN(bauabschnitt_abgelaufen_kz) AS bauabschnitt_abgelaufen_kz
FROM kfl_production_dbp_msi_view_ios.mv_bauabschnitt_abgelaufen AS ABG
GROUP BY projekt_nr,
 bauabschnitt_id;