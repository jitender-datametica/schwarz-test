CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_l_business_process_2 AS SELECT business_process_id,
 amx_system_id,
 business_process_bez,
 pruef_feld_typ_id,
 in_matrix_pruefgebiete_fg,
 aktiv_fg,
 amx_grp_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_l_business_process_2;