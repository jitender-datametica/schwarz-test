CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_BASE_THEME_ALL_2
AS
SELECT
client_id
,adv_week_id
,adv_week_sid
,hier_level_id
,sort_order_val
,adv_theme_sid
,adv_theme_mstr_sid
,advert_items_cnt
,advert_items_pv_cnt
,advert_items_nf_cnt
,advert_items_fa_cnt
,stores_cnt
,receipts_cnt
,sales_net_val
,sales_buy_price_net_val
,total_receipts_cnt
,total_sales_net_val
FROM p_lew_mart_pit_onprem.v_pit_base_theme_all_2;