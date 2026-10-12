CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_l_zustand_empfehlung (zustand_id, zustand_bez) AS SELECT
 zustand_id,
 zustand_bez
FROM kfl_production_dbp_view.v_amx_l_zustand
WHERE amx_system_id = 1;