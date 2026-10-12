CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_campaign_hist (client_id, campaign_sid, campaign_name, campaign_start_dt,
campaign_end_dt, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 campaign_sid,
 campaign_name,
 campaign_start_dt,
 campaign_end_dt,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_campaign_hist;