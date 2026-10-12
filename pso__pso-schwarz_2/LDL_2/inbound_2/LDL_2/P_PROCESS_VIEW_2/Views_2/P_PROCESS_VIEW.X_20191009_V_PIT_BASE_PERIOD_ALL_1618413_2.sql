CREATE OR REPLACE VIEW P_PROCESS_VIEW.X_20191009_V_PIT_BASE_PERIOD_ALL_1618413_2 as

   SELECT
     vt.client_id,
   vt.adv_week_id,
   COALESCE(rwk.adv_week_id, -1)             AS rltd_adv_week_id,
   CAST(15 AS BYTEINT)                       AS hier_level_id                        -- total row (all sales_2 including promotions)
   ,
   '000'                                                                             -- show it at the top in the report grid
    || '#' || '999'
    || '#' || '9999999999'                    AS sort_order_val,
   CAST(-2 AS BYTEINT)                       AS action_type_id,
   CAST(-2 AS BYTEINT)                       AS adv_period_id,
   CAST(-2 AS INTEGER)                       AS item_sid,
   CAST(-2 AS INTEGER)                       AS item_fam_grp_sid,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_old,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_new,
   CAST(NULL AS DECIMAL(38, 5))              AS price_retail_net_old,
   CAST(NULL AS DECIMAL(38, 5))              AS price_retail_net_new,
   CAST(NULL AS DECIMAL(18, 5))              AS vat_pct_val,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_diff_pct,
   CAST(NULL AS DECIMAL(18, 5))              AS pv_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS pv_net_val_sfo,
   CAST(NULL AS INTEGER)                     AS advert_items_cnt,
   tot.total_stores_cnt                      AS stores_cnt,
   vt.total_receipts_cnt                     AS receipts_cnt,
   vt.total_sales_net_val                    AS sales_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS sales_buy_price_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS sales_qty,
   CAST(NULL AS DECIMAL(18, 5))              AS sales_1d_qty,
   CAST(NULL AS DECIMAL(18, 5))              AS deliv_qty,
   vt.total_receipts_cnt,
   vt.total_sales_net_val,
   CAST(NULL AS INTEGER)                     AS cherry_pick_receipts_cnt,
   CAST(NULL AS INTEGER)                     AS base_receipts_cnt,
   CAST(NULL AS DECIMAL(18, 5))              AS base_sales_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS base_sales_qty,
   CAST(NULL AS DECIMAL(18, 5))              AS receipt_total_sales_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS receipt_action_sales_net_val,
   vtr.total_receipts_cnt                    AS rltd_receipts_cnt,
   vtr.total_sales_net_val                   AS rltd_sales_net_val,
   vtr.total_sales_net_val                   AS rltd_total_sales_net_val,
   CASE WHEN RANK() OVER (PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST) = 1 THEN 1 ELSE 0 END AS nearest_rltd_adv_week_fg

  FROM  p_lew_mart_analytics.t_advert_week_total_2 AS vt
   INNER JOIN (SELECT mer.client_id,
   weeks.adv_week_id,
   COUNT(DISTINCT loc_sid_store) as total_stores_cnt                -- total number of stores open during the advertising week (needed for total sales_2 per store)
               FROM  p_lew_bil_ac.v_org_store_merge_2 mer                             -- lookup table for open stores

   INNER JOIN (SELECT w.client_id,
   w.adv_week_id,
   MIN(w.adv_week_period_start_dt) AS adv_week_start_dt -- advertising week start date = the start date of the earliest period in this advertising week 
                           FROM  p_lew_mart_analytics.t_advert_week_period_2 AS w
   GROUP BY 1,2
  ) AS weeks
   ON  mer.client_id = weeks.client_id
   AND dat_opening <= weeks.adv_week_start_dt + 6                      -- the store should have opened the first time on the last day of the advertisement week or earlier
   AND weeks.adv_week_start_dt <= COALESCE(dat_closing, CAST('9999-12-31' AS VARCHAR ))   -- the store should only close on the first day of the advertising week or later
   WHERE  aspect_id = 2                                                -- only stores for sales_2 (duplicates would occur otherwise)
   GROUP BY 1,2
  ) tot
   ON vt.client_id = tot.client_id
   AND vt.adv_week_id = tot.adv_week_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_2 AS rwk
   ON  vt.client_id              = rwk.client_id
   AND vt.adv_week_id            > rwk.adv_week_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_total_2 AS vtr
   ON  rwk.client_id             = vtr.client_id
   AND rwk.adv_week_id           = vtr.adv_week_id
   WHERE hier_level_id = 15                                                            -- total level including promotions

   UNION ALL

   SELECT
     vt.client_id,
   vt.adv_week_id,
   COALESCE(rwk.adv_week_id, -1)             AS rltd_adv_week_id,
   CAST(14 AS BYTEINT)                       AS hier_level_id,
   '999'
    || '#' || '999'
    || '#' || '9999999999'                    AS sort_order_val,
   CAST(-2 AS BYTEINT)                       AS action_type_id,
   CAST(-2 AS BYTEINT)                       AS adv_period_id,
   CAST(-2 AS INTEGER)                       AS item_sid,
   CAST(-2 AS INTEGER)                       AS item_fam_grp_sid,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_old,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_new,
   CAST(NULL AS DECIMAL(38, 5))              AS price_retail_net_old,
   CAST(NULL AS DECIMAL(38, 5))              AS price_retail_net_new,
   CAST(NULL AS DECIMAL(18, 5))              AS vat_pct_val,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_diff_pct,
   CAST(NULL AS DECIMAL(18, 5))              AS pv_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS pv_net_val_sfo,
   COALESCE(vt.advert_items_pv_cnt, 0)
    + COALESCE(vt.advert_items_nf_cnt, 0)
    + COALESCE(vt.advert_items_fa_cnt, 0)     AS advert_items_cnt,
   vt.stores_cnt,
   vt.receipts_cnt,
   vt.sales_net_val,
   vt.sales_buy_price_net_val,
   vt.sales_qty,
   vt.sales_1d_qty,
   CAST(NULL AS DECIMAL(18, 5))              AS deliv_qty,
   vt.total_receipts_cnt,
   vt.total_sales_net_val,
   vt.cherry_pick_receipts_cnt,
   CAST(NULL AS INTEGER)                     AS base_receipts_cnt,
   CAST(NULL AS DECIMAL(18, 5))              AS base_sales_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS base_sales_qty,
   CAST(NULL AS DECIMAL(18, 5))              AS receipt_total_sales_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS receipt_action_sales_net_val,
   vtr.receipts_cnt                          AS rltd_receipts_cnt,
   vtr.sales_net_val                         AS rltd_sales_net_val,
   vtr.total_sales_net_val                   AS rltd_total_sales_net_val,
   CASE WHEN RANK() OVER (PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST) = 1 THEN 1 ELSE 0 END AS nearest_rltd_adv_week_fg

  FROM  p_lew_mart_analytics.t_advert_week_total_2 AS vt
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_2 AS rwk
   ON  vt.client_id              = rwk.client_id
   AND vt.adv_week_id            > rwk.adv_week_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_total_2 AS vtr
   ON  rwk.client_id             = vtr.client_id
   AND rwk.adv_week_id           = vtr.adv_week_id
   WHERE hier_level_id = 14                                                            -- total level of promotions

   UNION ALL

   SELECT
     vt.client_id,
   vt.adv_week_id,
   COALESCE(rwk.adv_week_id, -1)             AS rltd_adv_week_id,
   CAST(13 AS BYTEINT)                       AS hier_level_id,
   LPAD(CAST(act.action_type_sort_val AS VARCHAR(3)), 3, '0')
    || '#' || '999'
    || '#' || '9999999999'                    AS sort_order_val,
   vt.action_type_id                         AS action_type_id,
   CAST(-2 AS BYTEINT)                       AS adv_period_id,
   CAST(-2 AS INTEGER)                       AS item_sid,
   CAST(-2 AS INTEGER)                       AS item_fam_grp_sid,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_old,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_new,
   CAST(NULL AS DECIMAL(38, 5))              AS price_retail_net_old,
   CAST(NULL AS DECIMAL(38, 5))              AS price_retail_net_new,
   CAST(NULL AS DECIMAL(18, 5))              AS vat_pct_val,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_diff_pct,
   CAST(NULL AS DECIMAL(18, 5))              AS pv_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS pv_net_val_sfo,
   vt.advert_items_cnt,
   vt.stores_cnt,
   vt.receipts_cnt,
   vt.sales_net_val,
   vt.sales_buy_price_net_val,
   vt.sales_qty,
   vt.sales_1d_qty,
   vt.deliv_qty,
   vt.total_receipts_cnt,
   vt.total_sales_net_val,
   vt.cherry_pick_receipts_cnt,
   CAST(NULL AS INTEGER)                     AS base_receipts_cnt,
   vt.base_sales_net_val                     AS base_sales_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS base_sales_qty,
   CAST(NULL AS DECIMAL(18, 5))              AS receipt_total_sales_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS receipt_action_sales_net_val,
   vtr.receipts_cnt                          AS rltd_receipts_cnt,
   vtr.sales_net_val                         AS rltd_sales_net_val,
   vtr.total_sales_net_val                   AS rltd_total_sales_net_val,
   CASE WHEN RANK() OVER (PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST) = 1 THEN 1 ELSE 0 END AS nearest_rltd_adv_week_fg

  FROM  p_lew_mart_analytics.t_advert_week_action_type_2 AS vt
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_2 AS rwk
   ON  vt.client_id              = rwk.client_id
   AND vt.adv_week_id            > rwk.adv_week_id
   INNER JOIN  p_lew_mart_analytics.t_action_type_2 AS act
   ON  vt.action_type_id          = act.action_type_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_action_type_2 AS vtr
   ON  rwk.client_id             = vtr.client_id
   AND rwk.adv_week_id           = vtr.adv_week_id
   AND vt.action_type_id         = vtr.action_type_id
   WHERE hier_level_id = 13                                                            -- total level of promotions per action type

   UNION ALL

   SELECT
     vt.client_id,
   vt.adv_week_id,
   COALESCE(rwk.adv_week_id, -1)             AS rltd_adv_week_id,
   CAST(12 AS BYTEINT)                       AS hier_level_id,
   LPAD(CAST(act.action_type_sort_val AS VARCHAR(3)), 3, '0')
    || '#' || LPAD(CAST(awp.adv_week_period_sort_val AS VARCHAR(3)), 3, '0')
    || '#' || '9999999999'                    AS sort_order_val,
   vt.action_type_id                         AS action_type_id,
   vt.adv_period_id                          AS adv_period_id,
   CAST(-2 AS INTEGER)                       AS item_sid,
   CAST(-2 AS INTEGER)                       AS item_fam_grp_sid,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_old,
   CAST(NULL AS DECIMAL(18, 5))              AS price_retail_new,
   CAST(NULL AS DECIMAL(38, 5))              AS price_retail_net_old,
   CAST(NULL AS DECIMAL(38, 5))              AS price_retail_net_new,
   CAST(NULL AS DECIMAL(18, 5))              AS vat_pct_val,
   vt.price_retail_diff_pct                  AS price_retail_diff_pct,
   vt.pv_net_val                             AS pv_net_val,
   vt.pv_net_val                             AS pv_net_val_sfo,
   vt.advert_items_cnt,
   vt.stores_cnt,
   vt.receipts_cnt,
   vt.sales_net_val,
   vt.sales_buy_price_net_val,
   vt.sales_qty,
   vt.sales_1d_qty,
   vt.deliv_qty,
   vt.total_receipts_cnt,
   vt.total_sales_net_val,
   vt.cherry_pick_receipts_cnt,
   CAST(NULL AS INTEGER)                     AS base_receipts_cnt,
   vt.base_sales_net_val                     AS base_sales_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS base_sales_qty,
   CAST(NULL AS DECIMAL(18, 5))              AS receipt_total_sales_net_val,
   CAST(NULL AS DECIMAL(18, 5))              AS receipt_action_sales_net_val,
   vtr.receipts_cnt                          AS rltd_receipts_cnt,
   vtr.sales_net_val                         AS rltd_sales_net_val,
   vtr.total_sales_net_val                   AS rltd_total_sales_net_val,
   CASE WHEN RANK() OVER (PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST) = 1 THEN 1 ELSE 0 END AS nearest_rltd_adv_week_fg

  FROM  p_lew_mart_analytics.t_advert_week_period_action_type_2 AS vt
   INNER JOIN  p_lew_mart_analytics.t_advert_week_period_2 AS awp
   ON  vt.client_id              = awp.client_id
   AND vt.adv_week_id            = awp.adv_week_id
   AND vt.adv_period_id          = awp.adv_period_id
   INNER JOIN  p_lew_mart_analytics.t_action_type_2 AS act
   ON  vt.action_type_id          = act.action_type_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_2 AS rwk
   ON  vt.client_id              = rwk.client_id
   AND vt.adv_week_id            > rwk.adv_week_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_period_action_type_2 AS vtr
   ON  rwk.client_id             = vtr.client_id
   AND rwk.adv_week_id           = vtr.adv_week_id
   AND vt.adv_period_id          = vtr.adv_period_id
   AND vt.action_type_id         = vtr.action_type_id
   WHERE hier_level_id = 12                                                            -- total level of promotions per action type and advertising period
   ;