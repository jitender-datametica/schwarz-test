CREATE OR REPLACE VIEW kfl_production_dbp_view.v_waqfk_fehler_spr_zu_1 AS SELECT mandant_id,
 waqfk_fehler_id,
 spr_id,
 system_id,
 waqfk_fehler_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.waqfk_fehler_spr_zu_1;