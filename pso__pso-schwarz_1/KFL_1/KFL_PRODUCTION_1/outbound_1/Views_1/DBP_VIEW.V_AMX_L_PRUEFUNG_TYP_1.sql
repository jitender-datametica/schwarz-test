CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_l_pruefung_typ_1 AS SELECT pruefung_typ_id,
 amx_system_id,
 pruefung_typ_bez,
 ad_hoc_fg,
 amx_grp_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_l_pruefung_typ_1;