CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_agg_sales_store_day (client_id, loc_sid_store, store_mis_sid, orig_store_nr,
dat_formdate, cy_month, cnt_customer, cnt_customer_wawi, cnt_customer_ejr_he, cnt_customer_ejr_st, cnt_customer_txj,
val_retail, val_retail_net, val_rtl_wawi, val_rtl_net_wawi, val_rtl_ejr, val_rtl_net_ejr, val_rtl_txj_str,
val_rtl_net_txj_str, val_rtl_txj_item, val_rtl_net_txj_item, val_vatamount_ejr, val_vatamount_txj, val_vatamount_net_txj
, val_vatamount_vatsum_txj) AS SELECT *
FROM ldl_p_lew_bil.v_agg_sales_store_day;