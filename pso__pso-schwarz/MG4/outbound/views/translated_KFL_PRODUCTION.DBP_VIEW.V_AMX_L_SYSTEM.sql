CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_l_system (amx_system_id, amx_system_bez, td_insert, td_update) AS
SELECT amx_system_id,
 amx_system_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_l_system;