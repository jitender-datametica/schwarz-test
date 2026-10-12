CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_client_advert_week (client_id, adv_week_id, adv_week_start_dt,
adv_week_end_dt, adv_week_order_desc) AS SELECT client_id,
 adv_week_id,
 adv_week_start_dt,
 adv_week_end_dt,
 adv_week_order_desc
FROM ldl_p_lew_mart_pit_onprem.t_pit_client_advert_week AS CAW;