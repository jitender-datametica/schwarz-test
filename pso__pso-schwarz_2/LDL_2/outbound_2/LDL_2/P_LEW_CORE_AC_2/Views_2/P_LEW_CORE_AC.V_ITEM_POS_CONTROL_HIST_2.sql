CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_pos_control_hist_2 (client_id, item_sid, sales_org_sid, loc_sid,
distribution_channel_cd, scale_area, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 item_sid,
 sales_org_sid,
 loc_sid,
 distribution_channel_cd,
 scale_area,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_pos_control_hist_2;