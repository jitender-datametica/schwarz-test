CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_kmr_l_system (amx_system_id, amx_system_bez) AS SELECT
 amx_system_id,
 amx_system_bez
FROM kfl_production_dbp_view.v_kmr_l_system AS V01;