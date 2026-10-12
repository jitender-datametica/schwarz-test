CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_base_medium_item AS
-- LPAD ( CAST ( act.action_type_sort_val AS STRING ( 3)), 3, '0')

-- LPAD ( CAST ( awp.adv_week_period_sort_val AS STRING ( 3)), 3, '0')

-- LPAD ( CAST ( vt.orig_item_nr /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'Z ( 18 ) 9' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ AS STRING ( 10)), 10, '0'))

SELECT VT.client_id,
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
 21 AS hier_level_id,
 MIN(TRIM(CAST(ACT.action_type_sort_val AS STRING FORMAT '09')) || '#' || TRIM(CAST(AWP.adv_week_period_sort_val AS STRING FORMAT '009')
      ) || '#' || TRIM(CAST(VT.orig_item_nr AS STRING FORMAT '0000000009'))) AS sort_order_val,
 MIN(VT.action_type_id) AS action_type_id,
 MED.adv_medium_sid,
 CAST(MED.adv_medium_sid * 100 + VT.client_id AS BIGNUMERIC) AS adv_medium_mstr_sid,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING), VT.orig_item_nr, CAST(VT.item_sid AS STRING)
       , CAST(VT.adv_period_id AS STRING), CAST(MED.adv_medium_grp_sid AS STRING) ORDER BY MED.adv_medium_sid IS NULL,
       MED.adv_medium_sid)) = 1
  THEN 1
  ELSE 0
  END AS adv_medium_grp_drilldown_disp_fg,
 MIN(VT.price_retail_old) AS price_retail_old,
 MIN(VT.price_retail_new) AS price_retail_new,
 MIN(VT.price_retail_net_old) AS price_retail_net_old,
 MIN(VT.price_retail_net_new) AS price_retail_net_new,
 MIN(VT.vat_pct_val) AS vat_pct_val,
 SUM(VT.pv_net_val) AS pv_net_val,
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
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_item_period AS VT
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_item_medium AS MD ON VT.client_id = MD.client_id AND VT.item_sid =
    MD.item_sid AND VT.adv_week_id = MD.adv_week_id
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_period AS AWP ON VT.client_id = AWP.client_id AND VT.adv_week_id =
    AWP.adv_week_id AND VT.adv_period_id = AWP.adv_period_id
 INNER JOIN ldl_p_lew_mart_pit_onprem.v_pit_advert_medium AS MED ON MD.client_id = MED.client_id AND MD.adv_medium_sid =
   MED.adv_medium_sid
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_pit_action_type AS ACT ON VT.action_type_id = ACT.action_type_id
WHERE 21 = 21
GROUP BY VT.client_id,
 VT.adv_week_id,
 VT.orig_item_nr,
 VT.item_sid,
 VT.adv_period_id,
 MED.adv_medium_grp_sid,
 MED.adv_medium_sid;