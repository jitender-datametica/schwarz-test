CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_pruef_objekt_1 (business_unit_id, amx_system_id,
business_unit_bez, pruef_feld_typ_id, mandant_id, in_matrix_pruefgebiete_fg, aktiv_fg) AS SELECT business_unit_id,
 amx_system_id,
 business_unit_bez,
 pruef_feld_typ_id,
 mandant_id,
 in_matrix_pruefgebiete_fg,
 aktiv_fg
FROM kfl_production_dbp_view.v_amx_l_pruef_objekt_1;