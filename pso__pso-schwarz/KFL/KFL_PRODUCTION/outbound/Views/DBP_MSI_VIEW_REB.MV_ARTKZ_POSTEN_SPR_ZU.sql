CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_artkz_posten_spr_zu (posten_id_orig, mandant_id, spr_id,
posten_bez) AS SELECT posten_id AS posten_id_orig,
 mandant_id,
 spr_id,
  CASE
  WHEN posten_id = ''
  THEN 'nicht gepflegt'
  ELSE posten_bez
  END AS posten_bez
FROM kfl_production_dbp_view.v_artkz_posten
WHERE mandant_id = 1
 AND spr_id = 22;