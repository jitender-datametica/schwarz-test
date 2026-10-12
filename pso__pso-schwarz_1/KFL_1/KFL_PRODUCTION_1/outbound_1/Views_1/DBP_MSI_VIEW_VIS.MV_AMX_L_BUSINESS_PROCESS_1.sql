CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_l_business_process_1 (business_process_id,
business_process_bez, pruef_feld_typ_id, in_matrix_pruefgebiete_fg, aktiv_fg) AS SELECT business_process_id,
 business_process_bez,
 pruef_feld_typ_id,
 in_matrix_pruefgebiete_fg,
 aktiv_fg
FROM kfl_production_dbp_view.v_amx_l_business_process_1
WHERE amx_system_id = 1;