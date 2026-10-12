CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_l_pruefung_klasse_1 AS SELECT pruefung_klasse_id,
 amx_system_id,
 pruefung_klasse_bez,
 amx_grp_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_l_pruefung_klasse_1;