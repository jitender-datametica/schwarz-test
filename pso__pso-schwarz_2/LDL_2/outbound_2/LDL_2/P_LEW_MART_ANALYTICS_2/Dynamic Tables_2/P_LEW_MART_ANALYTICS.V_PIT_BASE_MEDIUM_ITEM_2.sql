

CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_analytics.v_pit_base_medium_item_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT VT.client_id,
 VT.adv_week_id,
 CAST(VT.adv_week_id * 100 + VT.client_id AS BIGNUMERIC) AS adv_week_sid,
 MIN(COALESCE(VT.orig_adv_week_id, VT.adv_week_id)) AS orig_adv_week_id,
 CAST(MIN(COALESCE(VT.orig_adv_week_id, VT.adv_week_id) * 100 + VT.client_id) AS BIGNUMERIC) AS orig_adv_week_sid,
  CASE
  WHEN MIN(VT.orig_adv_week_id) IS NOT NULL
  THEN 1
  ELSE 0
  END AS extended_week_fg,
 21 AS hier_level_id,
 MIN(LPAD(CAST(ACT.action_type_sort_val AS STRING), 3, '0') || '#' || LPAD(CAST(AWP.adv_week_period_sort_val AS STRING)
      , 3, '0') || '#' || LPAD(CAST(VT.orig_item_nr /* Warning, Format 'Z(18)9' removed, semantic information not found. */ AS STRING)
    , 10, '0')) AS sort_order_val,
 MIN(VT.action_type_id) AS action_type_id,
 MIN(VT.adv_period_id) AS adv_period_id,
 MIN(VT.item_sid) AS item_sid,
 MD.adv_medium_sid,
 CAST(MD.adv_medium_sid * 100 + VT.client_id AS BIGNUMERIC) AS adv_medium_mstr_sid,
 MIN(VT.price_retail_old) AS price_retail_old,
 MIN(VT.price_retail_new) AS price_retail_new,
 MIN(VT.price_retail_net_old) AS price_retail_net_old,
 MIN(VT.price_retail_net_new) AS price_retail_net_new,
 MIN(VT.vat_pct_val) AS vat_pct_val,
 SUM(CASE
   WHEN VT.action_type_id = 1
   THEN - 1 * (VT.price_retail_net_old - VT.price_retail_net_new) * VT.sales_qty
   ELSE NULL
   END) AS pv_net_val,
 MAX(VT.stores_cnt) AS stores_cnt,
 SUM(VT.receipts_cnt) AS receipts_cnt,
 SUM(VT.sales_net_val) AS sales_net_val,
 SUM(ROUND(CAST(VT.price_buy * VT.sales_qty AS NUMERIC), 5)) AS sales_buy_price_net_val,
 SUM(VT.sales_qty) AS sales_qty,
 SUM(VT.sales_1d_qty) AS sales_1d_qty,
 SUM(VT.deliv_qty) AS deliv_qty,
 MAX(VT.total_receipts_cnt) AS total_receipts_cnt,
 MAX(VT.total_sales_net_val) AS total_sales_net_val,
 SUM(VT.cherry_pick_receipts_cnt) AS cherry_pick_receipts_cnt,
 SUM(VT.base_receipts_cnt) AS base_receipts_cnt,
 SUM(VT.base_sales_net_val) AS base_sales_net_val,
 SUM(VT.base_sales_qty) AS base_sales_qty,
 SUM(VT.receipt_total_sales_net_val) AS receipt_total_sales_net_val,
 SUM(VT.receipt_action_sales_net_val) AS receipt_action_sales_net_val
FROM ldl_p_lew_mart_analytics.t_advert_week_item_2 AS VT
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_week_item_medium_2 AS MD ON VT.client_id = MD.client_id AND VT.item_sid = MD
    .item_sid AND VT.adv_week_id = MD.adv_week_id
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_week_period_2 AS AWP ON VT.client_id = AWP.client_id AND VT.adv_week_id =
    AWP.adv_week_id AND VT.adv_period_id = AWP.adv_period_id
 INNER JOIN ldl_p_lew_mart_analytics.t_action_type_2 AS ACT ON VT.action_type_id = ACT.action_type_id
WHERE 21 = 21
GROUP BY VT.client_id,
 VT.adv_week_id,
 VT.orig_item_nr,
 MD.adv_medium_sid;


