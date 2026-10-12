CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_l_zustand_2 (zustand_id, zustand_bez) AS SELECT zustand_id,
 zustand_bez
FROM kfl_production_dbp_view.v_amx_l_zustand_2
WHERE zustand_id IN (100003, 100004, 100005, 1001, 100025);