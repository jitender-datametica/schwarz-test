CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_pruefgrund_1 (pruef_id, mandant_id, spr_id, pruef_bez,
z_arbeitsgebiet_id) AS SELECT pruef_id,
 mandant_id,
 spr_id,
 pruef_bez,
  CASE
  WHEN z_arbeitsgebiet_id = 0
  THEN 'Z'
  WHEN z_arbeitsgebiet_id = 1
  THEN 'S'
  ELSE ' '
  END AS z_arbeitsgebiet_id
FROM kfl_production_dbp_view.v_l_pruefgrund_1
WHERE CAST(pruef_id AS INTEGER) IN (126, 203, 204, 205, 206, 207, 208, 209, 210, 214, 216, 218, 221, 223, 225, 231, 700
   , 1, 5, 2, 253, 254)
 AND mandant_id = 1
 AND spr_id = 22
 AND z_arbeitsgebiet_id < 4;