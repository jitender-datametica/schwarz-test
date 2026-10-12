CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_l_handlung_typ_2 AS SELECT amx_handlung_typ_id,
 amx_system_id,
 amx_handlung_typ_bez,
 amx_grp_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_l_handlung_typ_2;