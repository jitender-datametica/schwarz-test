CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artkz_posten_artbew_hist_1 (posten_kz, posten_bez,
mandant_id, spr_id) AS SELECT CASE
  WHEN posten_id <> '1'
  THEN 'SO'
  ELSE 'PN'
  END AS posten_kz,
  CASE
  WHEN posten_id <> '1'
  THEN 'Sortimentartikel'
  ELSE 'Postenartikel'
  END AS posten_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_posten_1
WHERE posten_id IN ('1', '0')
 AND mandant_id <> 1
 AND spr_id <> 22;