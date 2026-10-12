CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_zustand_2 (zustand_id, amx_system_id, zustand_bez) AS
SELECT zustand_id,
 amx_system_id,
 zustand_bez
FROM kfl_production_dbp_view.v_amx_l_zustand_2
WHERE amx_system_id = 2 AND zustand_id IN (100003, 100004, 100005, 1001, 100025)
 OR amx_system_id = 1 AND zustand_id IN (100005, 1001, 100041);