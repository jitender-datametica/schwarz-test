CREATE OR REPLACE VIEW kfl_production_dbp_view.v_waqfk_kennziffer_spr_zu AS SELECT mandant_id,
 waqfk_fehler_id,
 waqfk_kennziffer_id,
 spr_id,
 system_id,
 waqfk_kennziffer_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.waqfk_kennziffer_spr_zu;