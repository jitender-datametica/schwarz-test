CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_pruef_programm (pruef_programm_id, pruef_programm_bez,
zustand_id, kapitel_typ_id, pruef_programm_mutter_id) AS SELECT pruef_programm_id,
 pruef_programm_bez,
 zustand_id,
 kapitel_typ_id,
 pruef_programm_mutter_id
FROM kfl_production_dbp_view.v_amx_pruef_programm
WHERE amx_system_id = 1;