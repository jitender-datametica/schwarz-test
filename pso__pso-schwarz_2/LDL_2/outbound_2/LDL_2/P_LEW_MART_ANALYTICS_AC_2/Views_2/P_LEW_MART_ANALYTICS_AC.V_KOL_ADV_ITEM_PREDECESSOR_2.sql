CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_kol_adv_item_predecessor_2 (client_id, range_plan_cd, wh_loc_sid,
item_ian, adv_dt, sales_qty) AS SELECT client_id,
 range_plan_cd,
 wh_loc_sid,
 item_ian,
 adv_dt,
 sales_qty
FROM ldl_p_lew_mart_analytics.t_kol_adv_item_predecessor_2;