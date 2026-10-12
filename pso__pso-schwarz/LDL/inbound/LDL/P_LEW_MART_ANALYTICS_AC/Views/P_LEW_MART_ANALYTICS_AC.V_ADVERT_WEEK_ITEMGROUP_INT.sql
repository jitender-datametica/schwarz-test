CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ADVERT_WEEK_ITEMGROUP_INT
AS
   SELECT
     client_id,
   adv_week_id,
   item_grp_int_sid,
   advert_items_pv_cnt,
   advert_items_nf_cnt,
   advert_items_fa_cnt,
   stores_cnt,
   receipts_cnt,
   sales_net_val,
   sales_buy_price_net_val,
   total_receipts_cnt,
   total_sales_net_val
  FROM p_lew_mart_analytics.t_advert_week_itemgroup_int
;