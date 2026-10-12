CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_l_pruef_feld_typ_1 AS SELECT pruef_feld_typ_id,
 amx_system_id,
 pruef_feld_typ_bez,
 pruef_feld_typ_typ_id,
 amx_grp_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_l_pruef_feld_typ_1;