CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_l_zustand_2 AS SELECT zustand_id,
 amx_system_id,
 zustand_bez,
 amx_grp_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_l_zustand_2;