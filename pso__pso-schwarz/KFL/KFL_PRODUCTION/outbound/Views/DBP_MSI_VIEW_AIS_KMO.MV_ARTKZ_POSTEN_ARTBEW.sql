CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artkz_posten_artbew (posten_id, posten_bez, mandant_id,
spr_id) AS SELECT CASE
  WHEN posten_id = '1'
  THEN 'PN'
  ELSE 'SO'
  END AS posten_id,
  CASE
  WHEN posten_id = '1'
  THEN 'Postenart./Sortimentsart. SA'
  ELSE 'Sortimentsartikel AF'
  END AS posten_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_posten
WHERE posten_id IN ('0', '1')
 AND mandant_id <> 1
 AND spr_id = 22;