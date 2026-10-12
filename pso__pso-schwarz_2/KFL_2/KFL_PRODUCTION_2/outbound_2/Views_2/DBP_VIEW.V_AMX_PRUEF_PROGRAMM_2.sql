CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_pruef_programm_2 AS SELECT pruef_programm_id,
 amx_system_id,
 pruef_programm_bez,
 zustand_id,
 kapitel_typ_id,
 pruef_programm_mutter_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_pruef_programm_2;