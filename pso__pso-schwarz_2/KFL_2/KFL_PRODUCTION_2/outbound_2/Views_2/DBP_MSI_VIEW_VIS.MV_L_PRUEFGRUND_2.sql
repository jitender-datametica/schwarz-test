CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_pruefgrund_2 (pruef_id, mandant_id, pruef_bez,
z_arbeitsgebiet_id) AS SELECT pruef_id,
 mandant_id,
 pruef_bez,
 z_arbeitsgebiet_id
FROM kfl_production_dbp_data.l_pruefgrund_2 AS V01
WHERE CAST(pruef_id AS INTEGER) IN (202, 203, 205, 206, 207, 209, 210, 214, 216, 218, 223, 225, 231, 700) AND mandant_id
     > 1 AND z_arbeitsgebiet_id = 1
 OR mandant_id > 1 AND CAST(pruef_id AS INTEGER) IN (250, 252, 1, 5, 2, 253) AND z_arbeitsgebiet_id = 0;