CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_advert_medium_1 AS SELECT client_id,
 adv_medium_sid,
 adv_medium_descr,
 adv_medium_sort_val,
 dwh_created
FROM ldl_p_lew_mart_analytics.t_advert_medium_1;