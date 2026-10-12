CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_ADVERT_WEEK_PERIOD_ACTION_TYPE_1
AS
SELECT
client_id
,adv_week_id
,adv_period_id
,action_type_id
,price_retail_diff_pct
,pv_net_val
,advert_items_cnt
,stores_cnt
,receipts_cnt
,sales_net_val
,sales_buy_price_net_val
,sales_qty
,sales_1d_qty
,sales_3d_qty
,sales_7d_qty
,deliv_qty
,total_receipts_cnt
,total_sales_net_val
,cherry_pick_receipts_cnt
,heavy_buy_receipts_cnt
,exclusive_buy_receipts_cnt
,base_sales_net_val
FROM p_lew_mart_pit_onprem.t_advert_week_period_action_type_1;