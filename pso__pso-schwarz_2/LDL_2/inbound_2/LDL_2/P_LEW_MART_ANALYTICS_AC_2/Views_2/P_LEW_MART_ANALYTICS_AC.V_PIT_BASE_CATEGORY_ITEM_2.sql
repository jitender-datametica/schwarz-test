CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_BASE_CATEGORY_ITEM_2
AS

SELECT
  client_id
, adv_week_id
, adv_week_sid
, orig_adv_week_id
, orig_adv_week_sid
, extended_week_fg
, hier_level_id
, sort_order_val
, action_type_id
, adv_period_id
, adv_week_period_sort_val
, rowcnt
, item_sid
, item_grp_int_sid
, item_grp_int_mstr_sid
, sub_item_grp_sid
, sub_item_grp_mstr_sid
, price_retail_old
, price_retail_new
, price_retail_net_old
, price_retail_net_new
, vat_pct_val
, pv_net_val
, stores_cnt
, receipts_cnt
, sales_net_val
, sales_buy_price_net_val
, sales_qty
, sales_1d_qty
, deliv_qty
, total_receipts_cnt
, total_sales_net_val
, cherry_pick_receipts_cnt
, base_receipts_cnt
, base_sales_net_val
, base_sales_qty
, receipt_total_sales_net_val
, receipt_action_sales_net_val
FROM p_lew_mart_analytics.v_pit_base_category_item_2
;