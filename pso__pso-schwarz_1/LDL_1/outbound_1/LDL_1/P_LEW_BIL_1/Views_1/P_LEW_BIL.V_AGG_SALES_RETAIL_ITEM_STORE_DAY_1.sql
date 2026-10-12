CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_sales_retail_item_store_day_1 (client_id, loc_sid_store, src_orig_store_nr,
src_wh_id, item_sid, dwh_cal_dt, cy_month, retail_val, retail_net_val, qty_act, dwh_updated) AS SELECT client_id,
 loc_sid_store,
 src_orig_store_nr,
 src_wh_id,
 item_sid,
 dwh_cal_dt,
 cy_month,
 retail_val,
 retail_net_val,
 qty_act,
 dwh_updated
FROM ldl_p_lew_bil.t_agg_sales_retail_item_store_day_1;