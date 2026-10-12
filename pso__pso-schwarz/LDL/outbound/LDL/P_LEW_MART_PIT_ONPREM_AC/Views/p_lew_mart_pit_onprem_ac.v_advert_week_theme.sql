CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_advert_week_theme AS SELECT client_id,
 adv_week_id,
 adv_theme_sid,
 advert_items_pv_cnt,
 advert_items_nf_cnt,
 advert_items_fa_cnt,
 stores_cnt,
 receipts_cnt,
 sales_net_val,
 sales_buy_price_net_val,
 total_receipts_cnt,
 total_sales_net_val
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_theme;