CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artkz_posten_artbew_2 (posten_id, posten_bez, mandant_id,
spr_id) AS SELECT CASE
  WHEN posten_id = '1'
  THEN 'PN'
  WHEN posten_id IN ('0', '')
  THEN 'SO'
  ELSE posten_id
  END AS posten_id,
  CASE
  WHEN posten_id IN ('PN', 'PF', 'SP', '1')
  THEN 'Postenart./Sortimentsart. SA'
  ELSE 'Sortimentsartikel AF'
  END AS posten_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_posten_2
WHERE posten_id IN ('PN', '', '0', '1')
 AND spr_id = 22;