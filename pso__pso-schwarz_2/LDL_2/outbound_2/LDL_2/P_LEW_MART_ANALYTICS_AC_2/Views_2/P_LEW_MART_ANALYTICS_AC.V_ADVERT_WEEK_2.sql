CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_advert_week_2 AS SELECT client_id,
 adv_week_id,
 adv_week_descr,
 adv_week_year_num,
 adv_week_week_num,
 adv_week_start_dt,
 adv_week_end_dt,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_analytics.t_advert_week_2;