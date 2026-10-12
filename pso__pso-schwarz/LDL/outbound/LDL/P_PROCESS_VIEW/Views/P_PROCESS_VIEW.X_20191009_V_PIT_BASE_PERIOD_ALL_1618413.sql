-- total number of stores open during the advertising week (needed for total sales per store)

-- lookup table for open stores
 -- the store should only close on the first day of the advertising week or later

-- total row (all sales including promotions)

-- the store should have opened the first time on the last day of the advertisement week or earlier

-- advertising week start date = the start date of the earliest period in this advertising week

CREATE OR REPLACE VIEW ldl_p_process_view.x_20191009_v_pit_base_period_all_1618413 AS SELECT VT.client_id,
 VT.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 15 AS hier_level_id,
     '000' -- show it at the top in the report grid
 || '#' || '999' || '#' || '9999999999' AS sort_order_val,
 CAST(- 2 AS BIGNUMERIC) AS action_type_id,
 CAST(- 2 AS BIGNUMERIC) AS adv_period_id,
 CAST(- 2 AS BIGNUMERIC) AS item_sid,
 CAST(- 2 AS BIGNUMERIC) AS item_fam_grp_sid,
 CAST(NULL AS NUMERIC) AS price_retail_old,
 CAST(NULL AS NUMERIC) AS price_retail_new,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_new,
 CAST(NULL AS NUMERIC) AS vat_pct_val,
 CAST(NULL AS NUMERIC) AS price_retail_diff_pct,
 CAST(NULL AS NUMERIC) AS pv_net_val,
 CAST(NULL AS NUMERIC) AS pv_net_val_sfo,
 CAST(NULL AS BIGNUMERIC) AS advert_items_cnt,
 tot.total_stores_cnt AS stores_cnt,
 VT.total_receipts_cnt AS receipts_cnt,
 VT.total_sales_net_val AS sales_net_val,
 CAST(NULL AS NUMERIC) AS sales_buy_price_net_val,
 CAST(NULL AS NUMERIC) AS sales_qty,
 CAST(NULL AS NUMERIC) AS sales_1d_qty,
 CAST(NULL AS NUMERIC) AS deliv_qty,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 CAST(NULL AS BIGNUMERIC) AS cherry_pick_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS base_receipts_cnt,
 CAST(NULL AS NUMERIC) AS base_sales_net_val,
 CAST(NULL AS NUMERIC) AS base_sales_qty,
 CAST(NULL AS NUMERIC) AS receipt_total_sales_net_val,
 CAST(NULL AS NUMERIC) AS receipt_action_sales_net_val,
 VTR.total_receipts_cnt AS rltd_receipts_cnt,
 VTR.total_sales_net_val AS rltd_sales_net_val,
 VTR.total_sales_net_val AS rltd_total_sales_net_val,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_analytics.t_advert_week_total AS VT
 INNER JOIN (SELECT MER.client_id,
   weeks.adv_week_id,
   COUNT(DISTINCT MER.loc_sid_store) AS total_stores_cnt
  FROM ldl_p_lew_bil_ac.v_org_store_merge AS MER
   INNER JOIN (SELECT client_id,
     adv_week_id,
     MIN(adv_week_period_start_dt) AS adv_week_start_dt
    FROM ldl_p_lew_mart_analytics.t_advert_week_period AS W
    GROUP BY client_id,
     adv_week_id) AS weeks ON MER.client_id = weeks.client_id AND MER.dat_opening <= DATE_ADD(weeks.adv_week_start_dt,
       INTERVAL 6 DAY) AND weeks.adv_week_start_dt <= CAST(COALESCE(SUBSTR(CAST(MER.dat_closing AS STRING), 1, 20),
       '9999-12-31') AS DATE)
  WHERE MER.aspect_id = 2 -- only stores for sales (duplicates would occur otherwise)

  GROUP BY MER.client_id,
   weeks.adv_week_id) AS tot ON VT.client_id = tot.client_id AND VT.adv_week_id = tot.adv_week_id
 LEFT JOIN ldl_p_lew_mart_analytics.t_advert_week AS RWK ON VT.client_id = RWK.client_id AND VT.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_analytics.t_advert_week_total AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id =
   VTR.adv_week_id
WHERE 15 = 15 -- total level including promotions

UNION ALL
SELECT VT.client_id,
 VT.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 14 AS hier_level_id,
     '999' || '#' || '999' || '#' || '9999999999' AS sort_order_val,
 CAST(- 2 AS BIGNUMERIC) AS action_type_id,
 CAST(- 2 AS BIGNUMERIC) AS adv_period_id,
 CAST(- 2 AS BIGNUMERIC) AS item_sid,
 CAST(- 2 AS BIGNUMERIC) AS item_fam_grp_sid,
 CAST(NULL AS NUMERIC) AS price_retail_old,
 CAST(NULL AS NUMERIC) AS price_retail_new,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_new,
 CAST(NULL AS NUMERIC) AS vat_pct_val,
 CAST(NULL AS NUMERIC) AS price_retail_diff_pct,
 CAST(NULL AS NUMERIC) AS pv_net_val,
 CAST(NULL AS NUMERIC) AS pv_net_val_sfo,
   COALESCE(VT.advert_items_pv_cnt, 0) + COALESCE(VT.advert_items_nf_cnt, 0) + COALESCE(VT.advert_items_fa_cnt, 0) AS
 advert_items_cnt,
 VT.stores_cnt,
 VT.receipts_cnt,
 VT.sales_net_val,
 VT.sales_buy_price_net_val,
 VT.sales_qty,
 VT.sales_1d_qty,
 CAST(NULL AS NUMERIC) AS deliv_qty,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 VT.cherry_pick_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS base_receipts_cnt,
 CAST(NULL AS NUMERIC) AS base_sales_net_val,
 CAST(NULL AS NUMERIC) AS base_sales_qty,
 CAST(NULL AS NUMERIC) AS receipt_total_sales_net_val,
 CAST(NULL AS NUMERIC) AS receipt_action_sales_net_val,
 VTR.receipts_cnt AS rltd_receipts_cnt,
 VTR.sales_net_val AS rltd_sales_net_val,
 VTR.total_sales_net_val AS rltd_total_sales_net_val,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_analytics.t_advert_week_total AS VT
 LEFT JOIN ldl_p_lew_mart_analytics.t_advert_week AS RWK ON VT.client_id = RWK.client_id AND VT.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_analytics.t_advert_week_total AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id =
   VTR.adv_week_id
WHERE 14 = 14 -- total level of promotions

UNION ALL
SELECT VT.client_id,
 VT.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 13 AS hier_level_id,
     LPAD(CAST(ACT.action_type_sort_val AS STRING), 3, '0') || '#' || '999' || '#' || '9999999999' AS sort_order_val,
 VT.action_type_id,
 CAST(- 2 AS BIGNUMERIC) AS adv_period_id,
 CAST(- 2 AS BIGNUMERIC) AS item_sid,
 CAST(- 2 AS BIGNUMERIC) AS item_fam_grp_sid,
 CAST(NULL AS NUMERIC) AS price_retail_old,
 CAST(NULL AS NUMERIC) AS price_retail_new,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_new,
 CAST(NULL AS NUMERIC) AS vat_pct_val,
 CAST(NULL AS NUMERIC) AS price_retail_diff_pct,
 CAST(NULL AS NUMERIC) AS pv_net_val,
 CAST(NULL AS NUMERIC) AS pv_net_val_sfo,
 VT.advert_items_cnt,
 VT.stores_cnt,
 VT.receipts_cnt,
 VT.sales_net_val,
 VT.sales_buy_price_net_val,
 VT.sales_qty,
 VT.sales_1d_qty,
 VT.deliv_qty,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 VT.cherry_pick_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS base_receipts_cnt,
 VT.base_sales_net_val,
 CAST(NULL AS NUMERIC) AS base_sales_qty,
 CAST(NULL AS NUMERIC) AS receipt_total_sales_net_val,
 CAST(NULL AS NUMERIC) AS receipt_action_sales_net_val,
 VTR.receipts_cnt AS rltd_receipts_cnt,
 VTR.sales_net_val AS rltd_sales_net_val,
 VTR.total_sales_net_val AS rltd_total_sales_net_val,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_analytics.t_advert_week_action_type AS VT
 LEFT JOIN ldl_p_lew_mart_analytics.t_advert_week AS RWK ON VT.client_id = RWK.client_id AND VT.adv_week_id > RWK.adv_week_id
   
 INNER JOIN ldl_p_lew_mart_analytics.t_action_type AS ACT ON VT.action_type_id = ACT.action_type_id
 LEFT JOIN ldl_p_lew_mart_analytics.t_advert_week_action_type AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id
     = VTR.adv_week_id AND VT.action_type_id = VTR.action_type_id
WHERE 13 = 13 -- total level of promotions per action type

UNION ALL
SELECT VT.client_id,
 VT.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 12 AS hier_level_id,
     LPAD(CAST(ACT.action_type_sort_val AS STRING), 3, '0') || '#' || LPAD(CAST(AWP.adv_week_period_sort_val AS STRING)
     , 3, '0') || '#' || '9999999999' AS sort_order_val,
 VT.action_type_id,
 VT.adv_period_id,
 CAST(- 2 AS BIGNUMERIC) AS item_sid,
 CAST(- 2 AS BIGNUMERIC) AS item_fam_grp_sid,
 CAST(NULL AS NUMERIC) AS price_retail_old,
 CAST(NULL AS NUMERIC) AS price_retail_new,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_old,
 CAST(NULL AS BIGNUMERIC) AS price_retail_net_new,
 CAST(NULL AS NUMERIC) AS vat_pct_val,
 VT.price_retail_diff_pct,
 VT.pv_net_val,
 VT.pv_net_val AS pv_net_val_sfo,
 VT.advert_items_cnt,
 VT.stores_cnt,
 VT.receipts_cnt,
 VT.sales_net_val,
 VT.sales_buy_price_net_val,
 VT.sales_qty,
 VT.sales_1d_qty,
 VT.deliv_qty,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 VT.cherry_pick_receipts_cnt,
 CAST(NULL AS BIGNUMERIC) AS base_receipts_cnt,
 VT.base_sales_net_val,
 CAST(NULL AS NUMERIC) AS base_sales_qty,
 CAST(NULL AS NUMERIC) AS receipt_total_sales_net_val,
 CAST(NULL AS NUMERIC) AS receipt_action_sales_net_val,
 VTR.receipts_cnt AS rltd_receipts_cnt,
 VTR.sales_net_val AS rltd_sales_net_val,
 VTR.total_sales_net_val AS rltd_total_sales_net_val,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_analytics.t_advert_week_period_action_type AS VT
 INNER JOIN ldl_p_lew_mart_analytics.t_advert_week_period AS AWP ON VT.client_id = AWP.client_id AND VT.adv_week_id =
    AWP.adv_week_id AND VT.adv_period_id = AWP.adv_period_id
 INNER JOIN ldl_p_lew_mart_analytics.t_action_type AS ACT ON VT.action_type_id = ACT.action_type_id
 LEFT JOIN ldl_p_lew_mart_analytics.t_advert_week AS RWK ON VT.client_id = RWK.client_id AND VT.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_analytics.t_advert_week_period_action_type AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id
      = VTR.adv_week_id AND VT.adv_period_id = VTR.adv_period_id AND VT.action_type_id = VTR.action_type_id
WHERE 12 = 12 -- total level of promotions per action type and advertising period
;