CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_advert_week_item_medium AS SELECT client_id,
 adv_week_id,
 item_sid,
 adv_medium_sid
FROM ldl_p_lew_mart_analytics.t_advert_week_item_medium;