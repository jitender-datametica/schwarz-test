CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_advert_week_related AS SELECT client_id,
 adv_week_id,
 adv_week_rltd_type_id,
 rltd_adv_week_id
FROM ldl_p_lew_mart_analytics.t_advert_week_related;