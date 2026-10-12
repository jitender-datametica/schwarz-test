-- || '#' || '9999999999'                    AS sort_order_val

-- '#' || LPAD ( CAST ( awp.adv_week_period_sort_val AS STRING ( 3)), 3, '0')

-- LPAD ( CAST ( act.action_type_sort_val AS STRING ( 3)), 3, '0')
 -- Overall country_2 sum (action, non-action)

-- LPAD ( CAST ( act.action_type_sort_val AS STRING ( 3)), 3, '0')

CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_base_period_all_2 AS SELECT VT.client_id,
 VT.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 CAST(VT.adv_week_id * 100 + VT.client_id AS BIGNUMERIC) AS adv_week_sid,
 CAST(COALESCE(RWK.adv_week_id, - 1) * 100 + VT.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 15 AS hier_level_id,
     '000' || '#' || '999' || '#' || '9999999999' AS sort_order_val,
 CAST(- 2 AS BIGNUMERIC) AS action_type_id,
 CAST(- 2 AS BIGNUMERIC) AS adv_period_id,
 - 2 AS item_sid,
 - 2 AS item_fam_grp_sid,
 CAST(NULL AS BIGNUMERIC) AS price_retail_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_new,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_new,
 CAST(NULL AS BIGNUMERIC) AS vat_pct_val,
 CAST(NULL AS BIGNUMERIC) AS price_retail_diff_pct,
 CAST(NULL AS BIGNUMERIC) AS pv_net_val,
 CAST(NULL AS BIGNUMERIC) AS advert_items_cnt,
 tot.total_stores_cnt AS stores_cnt,
 VT.total_receipts_cnt AS receipts_cnt,
 VT.total_sales_net_val AS sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS sales_buy_price_net_val,
 CAST(NULL AS BIGNUMERIC) AS sales_qty,
 CAST(NULL AS BIGNUMERIC) AS sales_1d_qty,
 CAST(NULL AS BIGNUMERIC) AS sales_3d_qty,
 CAST(NULL AS BIGNUMERIC) AS sales_7d_qty,
 CAST(NULL AS BIGNUMERIC) AS deliv_qty,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 VT.total_sales_net_val AS total_adv_week_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS cherry_pick_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS heavy_buy_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS exclusive_buy_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS base_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS base_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS base_sales_qty,
 CAST(NULL AS BIGNUMERIC) AS receipt_total_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS receipt_action_sales_net_val,
 VTR.total_receipts_cnt AS rltd_receipts_cnt,
 VTR.total_sales_net_val AS rltd_sales_net_val,
 VTR.total_sales_net_val AS rltd_total_sales_net_val,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_total_2 AS VT
 INNER JOIN (SELECT STR.client_id,
   awk.adv_week_id,
   COUNT(DISTINCT STR.loc_sid_store) AS total_stores_cnt
  FROM ldl_p_lew_bil_ac.v_org_store_merge_2 AS STR
   INNER JOIN (SELECT client_id,
     adv_week_id,
     MIN(adv_week_period_start_dt) AS adv_week_start_dt
    FROM ldl_p_lew_mart_pit_onprem.t_advert_week_period_2
    GROUP BY client_id,
     adv_week_id) AS awk ON STR.client_id = awk.client_id /* Store was opened during the advertising week */ AND STR.dat_opening
       <= DATE_ADD(awk.adv_week_start_dt, INTERVAL 6 DAY) AND awk.adv_week_start_dt <= COALESCE(STR.dat_closing,
      PARSE_DATE('%F', '9999-12-31'))
  WHERE STR.aspect_id = 2
  GROUP BY STR.client_id,
   awk.adv_week_id) AS tot ON VT.client_id = tot.client_id AND VT.adv_week_id = tot.adv_week_id
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_2 AS RWK ON VT.client_id = RWK.client_id AND VT.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_total_2 AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id =
   VTR.adv_week_id
WHERE 15 = 15 -- All Action Items Sum

UNION ALL
SELECT VT.client_id,
 VT.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 CAST(VT.adv_week_id * 100 + VT.client_id AS BIGNUMERIC) AS adv_week_sid,
 CAST(COALESCE(RWK.adv_week_id, - 1) * 100 + VT.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 14 AS hier_level_id,
     '999' || '#' || '999' || '#' || '9999999999' AS sort_order_val,
 CAST(- 2 AS BIGNUMERIC) AS action_type_id,
 CAST(- 2 AS BIGNUMERIC) AS adv_period_id,
 - 2 AS item_sid,
 - 2 AS item_fam_grp_sid,
 CAST(NULL AS BIGNUMERIC) AS price_retail_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_new,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_new,
 CAST(NULL AS BIGNUMERIC) AS vat_pct_val,
 CAST(NULL AS BIGNUMERIC) AS price_retail_diff_pct,
 CAST(NULL AS BIGNUMERIC) AS pv_net_val,
   COALESCE(VT.advert_items_pv_cnt, 0) + COALESCE(VT.advert_items_nf_cnt, 0) + COALESCE(VT.advert_items_fa_cnt, 0) AS
 advert_items_cnt,
 VT.stores_cnt,
 VT.receipts_cnt,
 VT.sales_net_val,
 VT.sales_buy_price_net_val,
 VT.sales_qty,
 VT.sales_1d_qty,
 VT.sales_3d_qty,
 VT.sales_7d_qty,
 CAST(NULL AS BIGNUMERIC) AS deliv_qty,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 VT.total_sales_net_val AS total_adv_week_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS cherry_pick_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS heavy_buy_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS exclusive_buy_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS base_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS base_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS base_sales_qty,
 CAST(NULL AS BIGNUMERIC) AS receipt_total_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS receipt_action_sales_net_val,
 VTR.receipts_cnt AS rltd_receipts_cnt,
 VTR.sales_net_val AS rltd_sales_net_val,
 VTR.total_sales_net_val AS rltd_total_sales_net_val,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_total_2 AS VT
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_2 AS RWK ON VT.client_id = RWK.client_id AND VT.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_total_2 AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id =
   VTR.adv_week_id
WHERE 14 = 14 -- Action Type Sum

UNION ALL
SELECT VT.client_id,
 VT.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 CAST(VT.adv_week_id * 100 + VT.client_id AS BIGNUMERIC) AS adv_week_sid,
 CAST(COALESCE(RWK.adv_week_id, - 1) * 100 + VT.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 13 AS hier_level_id,
     TRIM(CAST(ACT.action_type_sort_val AS STRING FORMAT '000')) || '#' || '999' || '#' || '9999999999' AS
 sort_order_val,
 VT.action_type_id,
 CAST(- 2 AS BIGNUMERIC) AS adv_period_id,
 - 2 AS item_sid,
 - 2 AS item_fam_grp_sid,
 CAST(NULL AS BIGNUMERIC) AS price_retail_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_new,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_new,
 CAST(NULL AS BIGNUMERIC) AS vat_pct_val,
 CAST(NULL AS BIGNUMERIC) AS price_retail_diff_pct,
 VT.pv_net_val,
 VT.advert_items_cnt,
 VT.stores_cnt,
 VT.receipts_cnt,
 VT.sales_net_val,
 VT.sales_buy_price_net_val,
 VT.sales_qty,
 VT.sales_1d_qty,
 VT.sales_3d_qty,
 VT.sales_7d_qty,
 VT.deliv_qty,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 VT.total_sales_net_val AS total_adv_week_sales_net_val,
  CASE
  WHEN VT.action_type_id IN (2, 3)
  THEN NULL
  ELSE VT.cherry_pick_receipts_cnt
  END AS cherry_pick_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS heavy_buy_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS exclusive_buy_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS base_receipts_cnt,
 VT.base_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS base_sales_qty,
 CAST(NULL AS BIGNUMERIC) AS receipt_total_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS receipt_action_sales_net_val,
 VTR.receipts_cnt AS rltd_receipts_cnt,
 VTR.sales_net_val AS rltd_sales_net_val,
 VTR.total_sales_net_val AS rltd_total_sales_net_val,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_action_type_2 AS VT
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_2 AS RWK ON VT.client_id = RWK.client_id AND VT.adv_week_id > RWK.adv_week_id
   
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_pit_action_type_2 AS ACT ON VT.action_type_id = ACT.action_type_id
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_action_type_2 AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id
     = VTR.adv_week_id AND VT.action_type_id = VTR.action_type_id
WHERE 13 = 13 -- Period Sum

UNION ALL
SELECT VT.client_id,
 VT.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 CAST(VT.adv_week_id * 100 + VT.client_id AS BIGNUMERIC) AS adv_week_sid,
 CAST(COALESCE(RWK.adv_week_id, - 1) * 100 + VT.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 12 AS hier_level_id,
     TRIM(CAST(ACT.action_type_sort_val AS STRING FORMAT '000')) || '#' || TRIM(CAST(AWP.adv_week_period_sort_val AS STRING FORMAT '000')
     ) || '#' || '9999999999' AS sort_order_val,
 VT.action_type_id,
 VT.adv_period_id,
 - 2 AS item_sid,
 - 2 AS item_fam_grp_sid,
 CAST(NULL AS BIGNUMERIC) AS price_retail_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_new,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_new,
 CAST(NULL AS BIGNUMERIC) AS vat_pct_val,
 VT.price_retail_diff_pct,
 VT.pv_net_val,
 VT.advert_items_cnt,
 VT.stores_cnt,
 VT.receipts_cnt,
 VT.sales_net_val,
 VT.sales_buy_price_net_val,
 VT.sales_qty,
 VT.sales_1d_qty,
 VT.sales_3d_qty,
 VT.sales_7d_qty,
 VT.deliv_qty,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 TOT.total_sales_net_val AS total_adv_week_sales_net_val,
  CASE
  WHEN VT.action_type_id IN (2, 3)
  THEN NULL
  ELSE VT.cherry_pick_receipts_cnt
  END AS cherry_pick_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS heavy_buy_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS exclusive_buy_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS base_receipts_cnt,
 VT.base_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS base_sales_qty,
 CAST(NULL AS BIGNUMERIC) AS receipt_total_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS receipt_action_sales_net_val,
 VTR.receipts_cnt AS rltd_receipts_cnt,
 VTR.sales_net_val AS rltd_sales_net_val,
 VTR.total_sales_net_val AS rltd_total_sales_net_val,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_period_action_type_2 AS VT
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_period_2 AS AWP ON VT.client_id = AWP.client_id AND VT.adv_week_id =
    AWP.adv_week_id AND VT.adv_period_id = AWP.adv_period_id
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_pit_action_type_2 AS ACT ON VT.action_type_id = ACT.action_type_id
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_2 AS RWK ON VT.client_id = RWK.client_id AND VT.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_period_action_type_2 AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id
      = VTR.adv_week_id AND VT.adv_period_id = VTR.adv_period_id AND VT.action_type_id = VTR.action_type_id
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_total_2 AS TOT ON VT.client_id = TOT.client_id AND VT.adv_week_id =
   TOT.adv_week_id
WHERE 12 = 12;