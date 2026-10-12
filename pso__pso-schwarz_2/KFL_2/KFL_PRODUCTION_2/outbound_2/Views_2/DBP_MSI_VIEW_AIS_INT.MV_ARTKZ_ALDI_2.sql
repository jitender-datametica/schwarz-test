CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artkz_aldi_2 (aldi_bez, aldi_id, mandant_id, spr_id) AS
SELECT CASE
  WHEN aldi_bez = 'system generated'
  THEN 'kein_aldi'
  ELSE aldi_bez
  END AS aldi_bez,
 aldi_id,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_aldi_2
WHERE mandant_id = 1
UNION ALL
SELECT 'X',
 1,
 mandant_id,
 22
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id <> 1
UNION ALL
SELECT ' ',
 0,
 mandant_id,
 22
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id <> 1;