CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artkz_posten_artbew_hist (posten_kz, posten_bez, mandant_id,
spr_id) AS SELECT CASE
  WHEN posten_id = ''
  THEN 'SO'
  ELSE posten_id
  END AS posten_kz,
  CASE
  WHEN posten_id = 'PN'
  THEN 'Postenartikel'
  WHEN posten_id = ''
  THEN 'Sortimentartikel'
  ELSE NULL
  END AS posten_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_posten
WHERE posten_id IN ('PN', '')
 AND mandant_id = 1;