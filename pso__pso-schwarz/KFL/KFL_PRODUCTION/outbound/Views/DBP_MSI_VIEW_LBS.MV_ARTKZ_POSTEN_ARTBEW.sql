CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_artkz_posten_artbew (posten_id, posten_id_bez, mandant_id,
spr_id) AS SELECT CASE
  WHEN posten_id NOT IN ('PN', 'PF', 'SP', '1')
  THEN 'SO'
  ELSE 'PN'
  END AS posten_id,
  CASE
  WHEN posten_id NOT IN ('PN', 'PF', 'SP', '1')
  THEN 'Sortimentsartikel AF'
  ELSE 'Postenart./Sortimentsart. SA'
  END AS posten_id_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_posten
WHERE posten_id IN ('PN', '', '0', '1', 'PF', 'SP')
 AND spr_id = 22;