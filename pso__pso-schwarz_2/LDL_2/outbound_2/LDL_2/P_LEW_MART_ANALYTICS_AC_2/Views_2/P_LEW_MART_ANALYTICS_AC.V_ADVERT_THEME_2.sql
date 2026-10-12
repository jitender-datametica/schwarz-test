CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_advert_theme_2 AS SELECT client_id,
 adv_theme_sid,
 adv_theme_descr,
 dwh_created
FROM ldl_p_lew_mart_analytics.t_advert_theme_2;