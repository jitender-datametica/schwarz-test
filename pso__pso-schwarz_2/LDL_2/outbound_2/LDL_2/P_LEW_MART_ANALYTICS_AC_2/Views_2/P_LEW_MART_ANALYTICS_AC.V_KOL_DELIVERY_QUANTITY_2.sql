CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_kol_delivery_quantity_2 (client_id, item_ian, orig_store_nr,
adv_store_dt, adv_ian_dt, range_plan_cd, delivery_qty) AS SELECT client_id,
 item_ian,
 orig_store_nr,
 adv_store_dt,
 adv_ian_dt,
 range_plan_cd,
 delivery_qty
FROM ldl_p_lew_mart_analytics.t_kol_delivery_quantity_2;