CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fw_reserve_spr_zu_2 AS SELECT mandant_id,
 fw_reserve_id,
 spr_id,
 fw_reserve_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.fw_reserve_spr_zu_2;