CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_str_day_ejr_txj_ww_asis_1 AS SELECT AGG.client_id,
 AGG.dat_formdate,
 AGG.cy_month,
 AGG.orig_store_nr AS src_orig_store_nr,
 AGG.loc_sid_store,
  AGG.val_retail / B.exchange_rate AS val_retail_asis,
  AGG.val_retail_net / B.exchange_rate AS val_retail_net_asis,
 AGG.cnt_customer AS cnt_customer_asis,
   AGG.val_rtl_wawi * - 1 / B.exchange_rate AS val_retail_wawi_asis,
   AGG.val_rtl_net_wawi * - 1 / B.exchange_rate AS val_retail_net_wawi_asis,
  AGG.val_rtl_txj_item / B.exchange_rate AS val_retail_txj_asis,
  AGG.val_rtl_net_txj_item / B.exchange_rate AS val_retail_net_txj_asis,
  AGG.val_rtl_txj_str / B.exchange_rate AS val_retail_txj_str,
  AGG.val_rtl_net_txj_str / B.exchange_rate AS val_retail_net_txj_str,
  AGG.val_rtl_ejr / B.exchange_rate AS val_retail_ejr_asis,
  AGG.val_rtl_net_ejr / B.exchange_rate AS val_retail_net_ejr_asis,
 AGG.cnt_customer_wawi AS cnt_customer_wawi_asis,
 AGG.cnt_customer_txj AS cnt_customer_txj_asis,
 AGG.cnt_customer_ejr_he AS cnt_customer_ejr_he_asis,
 B.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil.v_agg_sales_store_day_1 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS B ON AGG.client_id = B.client_id AND CURRENT_DATE BETWEEN B
    .active_from_dt AND B.active_to_dt AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';