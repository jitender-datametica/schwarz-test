CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_l_tageszeit (amx_system_id, tageszeit_id, tageszeit_bez) AS SELECT
 amx_system_id,
 tageszeit_id,
 tageszeit_bez
FROM kfl_production_dbp_data.kmr_l_tageszeit;