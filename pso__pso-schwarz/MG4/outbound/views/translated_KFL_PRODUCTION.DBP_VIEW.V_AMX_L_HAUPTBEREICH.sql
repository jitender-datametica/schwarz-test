CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_l_hauptbereich (hauptbereich_id, amx_system_id, hauptbereich_bez,
amx_grp_id, td_insert, td_update) AS SELECT *
FROM kfl_production_dbp_data.amx_l_hauptbereich;