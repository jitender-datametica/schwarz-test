CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_advertise_theme_deliver_hist_1 (client_id, mdm_ad_theme_sid, item_del_seq,
cy_week_theme_del, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id
 ,
 mdm_ad_theme_sid,
 item_del_seq,
 cy_week_theme_del,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_advertise_theme_deliver_hist_1;