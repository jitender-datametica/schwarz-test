CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_artkz_esb_2 (esb_id, esb_bez, mandant_id, spr_id) AS SELECT
 esb_id,
  CASE
  WHEN esb_bez = 'system generated'
  THEN 'kein Esbartikel'
  ELSE esb_bez
  END AS esb_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_esb_2
WHERE mandant_id = 1
 AND spr_id = 22;