CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_hauptbereich_1 (hauptbereich_id, amx_system_id,
hauptbereich_bez) AS SELECT hauptbereich_id,
 amx_system_id,
 hauptbereich_bez
FROM kfl_production_dbp_view.v_amx_l_hauptbereich_1;