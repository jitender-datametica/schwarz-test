CREATE OR REPLACE VIEW kfl_production_dbp_view.v_we_message_status_spr_zu AS SELECT mandant_id,
 we_message_status_id,
 spr_id,
 we_message_status_bez
FROM kfl_production_dbp_data.we_message_status_spr_zu;