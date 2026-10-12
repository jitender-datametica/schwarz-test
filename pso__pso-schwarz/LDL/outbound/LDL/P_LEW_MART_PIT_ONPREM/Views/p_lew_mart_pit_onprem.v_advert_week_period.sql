CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_advert_week_period AS SELECT client_id,
 adv_week_id,
 adv_period_id,
 adv_week_period_start_dt,
 adv_week_period_end_dt,
 adv_week_period_sort_val
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_period;