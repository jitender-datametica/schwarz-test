CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_aldi_1 (aldi_id, aldi_bez) AS SELECT aldi_id,
  CASE
  WHEN aldi_bez = 'system generated'
  THEN 'kein Aldiartikel'
  ELSE aldi_bez
  END AS aldi_bez
FROM kfl_production_dbp_view.v_artkz_aldi_1
WHERE mandant_id = 1;