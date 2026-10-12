CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_campaign_1 (client_id, campaign_sid, src_item_campaign_name, src_theme_nat,
src_valid_from, campaign_name, campaign_start_dt, campaign_end_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 campaign_sid,
 src_item_campaign_name,
 src_theme_nat,
 src_valid_from,
 campaign_name,
 campaign_start_dt,
 campaign_end_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_campaign_1;