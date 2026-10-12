CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artkz_aldi_2 (aldi_bez, aldi_id, mandant_id, spr_id) AS SELECT CASE
  WHEN aldi_bez = 'system generated'
  THEN 'kein Aldiartikel'
  ELSE aldi_bez
  END AS aldi_bez,
 aldi_id,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_aldi_2
WHERE mandant_id = 1;