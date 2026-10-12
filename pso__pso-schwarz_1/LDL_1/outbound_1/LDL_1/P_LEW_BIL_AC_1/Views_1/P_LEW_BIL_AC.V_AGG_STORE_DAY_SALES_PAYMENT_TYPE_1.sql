CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_store_day_sales_payment_type_1 (client_id, dat_formdate, cy_month, loc_sid,
orig_store_nr, currency_iso_cd, sales_net_val_pos, return_net_val_pos, cnt_customer, sales_payment_type) AS SELECT
 client_id,
 dat_formdate,
 cy_month,
 loc_sid,
 orig_store_nr,
 currency_iso_cd,
 sales_net_val_pos,
 return_net_val_pos,
 cnt_customer,
 sales_payment_type
FROM ldl_p_lew_bil.t_agg_store_day_sales_payment_type_1;