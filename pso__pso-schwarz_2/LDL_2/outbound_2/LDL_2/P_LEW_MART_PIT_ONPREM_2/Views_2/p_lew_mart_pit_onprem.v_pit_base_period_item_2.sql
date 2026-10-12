CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_base_period_item_2 AS SELECT VT.client_id,
 VT.adv_week_id,
 VT.item_sid,
 CAST(VT.item_sid * 100 + VT.client_id AS BIGNUMERIC) AS item_mstr_sid,
 VT.adv_period_id,
 CAST(VT.adv_week_id * 100 + VT.client_id AS BIGNUMERIC) AS adv_week_sid,
 MIN(VT.adv_week_id) AS orig_adv_week_id,
 CAST(MIN(VT.adv_week_id * 100 + VT.client_id) AS BIGNUMERIC) AS orig_adv_week_sid,
  CASE
  WHEN MIN(VT.orig_adv_week_id) IS NOT NULL
  THEN 1
  ELSE 0
  END AS extended_week_fg,
 11 AS hier_level_id,
 MIN(TRIM(CAST(ACT.action_type_sort_val AS STRING FORMAT '09')) || '#' || TRIM(CAST(AWP.adv_week_period_sort_val AS STRING FORMAT '009')
      ) || '#' || TRIM(CAST(VT.orig_item_nr AS STRING FORMAT '0000000009'))) AS sort_order_val,
 MIN(VT.action_type_id) AS action_type_id,
 MIN(VT.sub_item_grp_sid) AS sub_item_grp_sid,
 MIN(VT.item_grp_int_sid) AS item_grp_int_sid,
 MIN(VT.adv_theme_sid) AS adv_theme_sid,
 MIN(VT.price_retail_old) AS price_retail_old,
 MIN(VT.price_retail_new) AS price_retail_new,
 MIN(VT.price_retail_net_old) AS price_retail_net_old,
 MIN(VT.price_retail_net_new) AS price_retail_net_new,
 MIN(VT.vat_pct_val) AS vat_pct_val,
  CAST(100 * (MIN(VT.price_retail_old) - MIN(VT.price_retail_new)) AS BIGNUMERIC) / CASE
   WHEN MIN(VT.price_retail_old) = 0
   THEN NULL
   ELSE MIN(VT.price_retail_old)
   END AS price_retail_diff_pct,
 SUM(VT.pv_net_val) AS pv_net_val,
 1 AS advert_items_cnt,
 MAX(VT.stores_cnt) AS stores_cnt,
 SUM(VT.receipts_cnt) AS receipts_cnt,
 SUM(VT.sales_net_val) AS sales_net_val,
 SUM(ROUND(CAST(VT.price_buy * VT.sales_qty AS BIGNUMERIC), 5)) AS sales_buy_price_net_val,
 SUM(VT.sales_qty) AS sales_qty,
 SUM(VT.sales_1d_qty) AS sales_1d_qty,
 SUM(VT.sales_3d_qty) AS sales_3d_qty,
 SUM(VT.sales_7d_qty) AS sales_7d_qty,
 SUM(VT.deliv_qty) AS deliv_qty,
 MAX(VT.total_receipts_cnt) AS total_receipts_cnt,
 MAX(VT.total_sales_net_val) AS total_sales_net_val,
 SUM(VT.cherry_pick_receipts_cnt) AS cherry_pick_receipts_cnt,
 SUM(VT.heavy_buy_receipts_cnt) AS heavy_buy_receipts_cnt,
 SUM(VT.exclusive_buy_receipts_cnt) AS exclusive_buy_receipts_cnt,
 SUM(VT.base_receipts_cnt) AS base_receipts_cnt,
 SUM(VT.base_sales_net_val) AS base_sales_net_val,
 SUM(VT.base_sales_qty) AS base_sales_qty,
 SUM(VT.receipt_total_sales_net_val) AS receipt_total_sales_net_val,
 SUM(VT.receipt_action_sales_net_val) AS receipt_action_sales_net_val
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_item_period_2 AS VT
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_period_2 AS AWP ON VT.client_id = AWP.client_id AND VT.adv_week_id =
    AWP.adv_week_id AND VT.adv_period_id = AWP.adv_period_id
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_pit_action_type_2 AS ACT ON VT.action_type_id = ACT.action_type_id
GROUP BY VT.client_id,
 VT.adv_week_id,
 VT.orig_item_nr,
 VT.item_sid,
 VT.adv_period_id;