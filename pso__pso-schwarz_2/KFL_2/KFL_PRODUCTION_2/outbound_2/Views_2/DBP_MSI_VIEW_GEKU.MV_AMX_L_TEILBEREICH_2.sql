CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_teilbereich_2 (teilbereich_id, amx_system_id,
teilbereich_bez) AS SELECT teilbereich_id,
 amx_system_id,
 teilbereich_bez
FROM kfl_production_dbp_view.v_amx_l_teilbereich_2;