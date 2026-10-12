CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_kol_sales_quantity_2 (client_id, item_ian, item_sid, orig_store_nr,
adv_store_dt, adv_ian_dt, range_plan_cd, ean_barcode_clean, sales_hour, sales_dt, sales_qty) AS SELECT client_id,
 item_ian,
 item_sid,
 orig_store_nr,
 adv_store_dt,
 adv_ian_dt,
 range_plan_cd,
 ean_barcode_clean,
 sales_hour,
 sales_dt,
 sales_qty
FROM ldl_p_lew_mart_analytics.t_kol_sales_quantity_2;