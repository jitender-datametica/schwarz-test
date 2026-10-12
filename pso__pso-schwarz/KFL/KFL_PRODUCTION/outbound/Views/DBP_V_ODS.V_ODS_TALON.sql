CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_talon AS SELECT mandant_id,
 talon_id,
 wup_id,
 talon_dat,
 talon_booking,
 talon_bon_fg,
 talon_delta_status_bitfeld,
 td_update,
 td_insert
FROM kfl_production_dbp_ods.ods_talon;