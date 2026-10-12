CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_zerlege_gruppe AS SELECT mandant_id,
 zerlege_gruppe_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_zerlege_gruppe;