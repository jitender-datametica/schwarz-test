CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_zustand_empfehlung_1 (zustand_id, amx_system_id,
zustand_bez) AS SELECT zustand_id,
 amx_system_id,
 zustand_bez
FROM kfl_production_dbp_view.v_amx_l_zustand_1;