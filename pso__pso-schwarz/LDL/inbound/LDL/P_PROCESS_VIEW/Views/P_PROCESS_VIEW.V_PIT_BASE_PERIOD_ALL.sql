CREATE OR REPLACE VIEW P_PROCESS_VIEW.V_PIT_BASE_PERIOD_ALL as
   SELECT
     vt.client_id,
   vt.adv_week_id,
   COALESCE(rwk.adv_week_id, -1)             AS rltd_adv_week_id,
   CAST(15 AS BYTEINT)                       AS hier_level_id,
   '000'
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
   vt.total_sales_net_val                    AS total_adv_week_sales_net_val,
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

  FROM  p_lew_mart_analytics.t_advert_week_total AS vt
   INNER JOIN
   (
       SELECT
         str.client_id,
   awk.adv_week_id,
   COUNT(DISTINCT loc_sid_store) AS total_stores_cnt
 FROM  p_lew_bil_ac.v_org_store_merge AS str
   INNER JOIN
   (
       SELECT
         client_id,
   adv_week_id,
   MIN(adv_week_period_start_dt) AS adv_week_start_dt
 FROM  p_lew_mart_analytics.t_advert_week_period
 GROUP BY 1,2
) AS awk
   ON  str.client_id          = awk.client_id
   /* Store was opened during the advertising week */
   AND str.dat_opening       <= awk.adv_week_start_dt + 6
   AND awk.adv_week_start_dt <= COALESCE(str.dat_closing, DATE'9999-12-31')
   WHERE aspect_id = 2
   GROUP BY 1,2
) AS tot
   ON  vt.client_id              = tot.client_id
   AND vt.adv_week_id            = tot.adv_week_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week AS rwk
   ON  vt.client_id              = rwk.client_id
   AND vt.adv_week_id            > rwk.adv_week_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_total AS vtr
   ON  rwk.client_id             = vtr.client_id
   AND rwk.adv_week_id           = vtr.adv_week_id
   WHERE hier_level_id = 15

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
   pv.pv_net_val,
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
   vt.total_sales_net_val                    AS total_adv_week_sales_net_val,
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

  FROM  p_lew_mart_analytics.t_advert_week_total AS vt
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week AS rwk
   ON  vt.client_id              = rwk.client_id
   AND vt.adv_week_id            > rwk.adv_week_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_total AS vtr
   ON  rwk.client_id             = vtr.client_id
   AND rwk.adv_week_id           = vtr.adv_week_id
   LEFT OUTER JOIN
   (
       SELECT
         client_id,
   adv_week_id,
   SUM(-1 * (price_retail_net_old - price_retail_net_new) * sales_qty) AS pv_net_val
      FROM  p_lew_mart_analytics.t_advert_week_item
      WHERE action_type_id = 1
      GROUP BY 1,2
  ) AS pv
   ON  vt.client_id              = pv.client_id
   AND vt.adv_week_id            = pv.adv_week_id

   WHERE hier_level_id = 14

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
   pv.pv_net_val,
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
   vt.total_sales_net_val                    AS total_adv_week_sales_net_val,
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

  FROM  p_lew_mart_analytics.t_advert_week_action_type AS vt
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week AS rwk
   ON  vt.client_id              = rwk.client_id
   AND vt.adv_week_id            > rwk.adv_week_id
   INNER JOIN  p_lew_mart_analytics.t_action_type AS act
   ON  vt.action_type_id          = act.action_type_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_action_type AS vtr
   ON  rwk.client_id             = vtr.client_id
   AND rwk.adv_week_id           = vtr.adv_week_id
   AND vt.action_type_id         = vtr.action_type_id
   LEFT OUTER JOIN
   (
       SELECT
         client_id,
   adv_week_id,
   action_type_id,
   SUM(-1 * (price_retail_net_old - price_retail_net_new) * sales_qty) AS pv_net_val
      FROM  p_lew_mart_analytics.t_advert_week_item
      WHERE action_type_id = 1
      GROUP BY 1,2,3
  ) AS pv
   ON  vt.client_id              = pv.client_id
   AND vt.adv_week_id            = pv.adv_week_id
   AND vt.action_type_id         = pv.action_type_id

   WHERE hier_level_id = 13

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
   vt.price_retail_diff_pct,
   pv.pv_net_val,
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
   tot.total_sales_net_val                   AS total_adv_week_sales_net_val,
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

  FROM  p_lew_mart_analytics.t_advert_week_period_action_type AS vt
   INNER JOIN  p_lew_mart_analytics.t_advert_week_period AS awp
   ON  vt.client_id              = awp.client_id
   AND vt.adv_week_id            = awp.adv_week_id
   AND vt.adv_period_id          = awp.adv_period_id
   INNER JOIN  p_lew_mart_analytics.t_action_type AS act
   ON  vt.action_type_id         = act.action_type_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week AS rwk
   ON  vt.client_id              = rwk.client_id
   AND vt.adv_week_id            > rwk.adv_week_id
   LEFT OUTER JOIN  p_lew_mart_analytics.t_advert_week_period_action_type AS vtr
   ON  rwk.client_id             = vtr.client_id
   AND rwk.adv_week_id           = vtr.adv_week_id
   AND vt.adv_period_id          = vtr.adv_period_id
   AND vt.action_type_id         = vtr.action_type_id
   LEFT OUTER JOIN
   (
       SELECT
         client_id,
   adv_week_id,
   adv_period_id,
   action_type_id,
   SUM(-1 * (price_retail_net_old - price_retail_net_new) * sales_qty) AS pv_net_val
      FROM  p_lew_mart_analytics.t_advert_week_item
      WHERE action_type_id = 1
      GROUP BY 1,2,3,4
  ) AS pv
   ON  vt.client_id              = pv.client_id
   AND vt.adv_week_id            = pv.adv_week_id
   AND vt.action_type_id         = pv.action_type_id
   AND vt.adv_period_id          = pv.adv_period_id
   INNER JOIN  p_lew_mart_analytics.t_advert_week_total AS tot
   ON  vt.client_id              = tot.client_id
   AND vt.adv_week_id            = tot.adv_week_id

   WHERE hier_level_id = 12
;