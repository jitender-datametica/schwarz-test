CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ADVERT_WEEK_ACTION_TYPE
AS
   SELECT
     client_id,
   adv_week_id,
   action_type_id,
   advert_items_cnt,
   stores_cnt,
   receipts_cnt,
   sales_net_val,
   sales_buy_price_net_val,
   sales_qty,
   sales_1d_qty,
   deliv_qty,
   total_receipts_cnt,
   total_sales_net_val,
   cherry_pick_receipts_cnt,
   base_sales_net_val
  FROM p_lew_mart_analytics.t_advert_week_action_type;