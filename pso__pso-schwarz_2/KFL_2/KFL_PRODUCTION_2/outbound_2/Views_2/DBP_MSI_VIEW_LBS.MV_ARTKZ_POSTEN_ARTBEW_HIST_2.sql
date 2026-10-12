CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_artkz_posten_artbew_hist_2 (posten_kz, posten_kz_bez, mandant_id
, spr_id) AS SELECT CASE
  WHEN posten_id NOT IN ('PN', 'PF', 'SP', '1')
  THEN 'SO'
  ELSE 'PN'
  END AS posten_kz,
  CASE
  WHEN posten_id NOT IN ('PN', 'PF', 'SP', '1')
  THEN 'Sortimentartikel'
  ELSE 'Postenartikel'
  END AS posten_kz_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_artkz_posten_2
WHERE posten_id IN ('PN', '', '0', '1', 'PF', 'SP');