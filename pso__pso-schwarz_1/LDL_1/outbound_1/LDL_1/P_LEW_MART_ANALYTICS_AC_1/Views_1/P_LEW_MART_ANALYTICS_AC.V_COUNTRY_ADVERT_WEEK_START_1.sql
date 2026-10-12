CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_country_advert_week_start_1 AS SELECT client_id,
 dwh_valid_from,
 dwh_valid_to,
 adv_week_start_day,
 following_cal_week_fg,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_analytics.t_country_advert_week_start_1;