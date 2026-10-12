CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_BASE_CATEGORY_ALL
AS

SELECT
  client_id
, adv_week_id
, rltd_adv_week_id
, hier_level_id
, sort_order_val
, item_grp_int_sid
, sub_item_grp_sid
, advert_items_cnt
, advert_items_pv_cnt
, advert_items_nf_cnt
, advert_items_fa_cnt
, stores_cnt
, receipts_cnt
, sales_net_val
, sales_buy_price_net_val
, total_receipts_cnt
, total_sales_net_val
, rltd_receipts_cnt
, rltd_sales_net_val
, nearest_rltd_adv_week_fg
FROM p_lew_mart_analytics.v_pit_base_category_all
;