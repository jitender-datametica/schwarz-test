CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_waqfk_fehler_1 AS SELECT mandant_id,
 system_id,
 waqfk_fehler_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_waqfk_fehler_1;