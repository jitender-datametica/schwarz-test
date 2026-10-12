
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_BASE_PERIOD_ITEM
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     vt.client_id,
   vt.adv_week_id,
   CAST(vt.adv_week_id * 100 + vt.client_id AS INTEGER)  AS adv_week_sid,
   vt.adv_week_id                                        AS orig_adv_week_id,
   CAST(vt.adv_week_id * 100 + vt.client_id AS INTEGER)  AS orig_adv_week_sid,
   CAST(0 AS BYTEINT)                                    AS extended_week_fg,
   CAST(12 AS BYTEINT)                       AS hier_level_id,
   LPAD(CAST(act.action_type_sort_val AS VARCHAR(3)), 3, '0')
    || '#' || LPAD(CAST(awp.adv_week_period_sort_val AS VARCHAR(3)), 3, '0')
    || '#' || '9999999999'                    AS sort_order_val,
   vt.action_type_id                         AS action_type_id,
   vt.adv_period_id                          AS adv_period_id,
   CAST(-2 AS INTEGER)                       AS item_sid,
   CAST(-2 AS INTEGER)                       AS sub_item_grp_sid,
   CAST(-2 AS INTEGER)                       AS item_grp_int_sid,
   TO_NUMBER(NULL)              AS price_retail_old,
   TO_NUMBER(NULL)              AS price_retail_new,
   TO_NUMBER(NULL)              AS price_retail_net_old,
   TO_NUMBER(NULL)              AS price_retail_net_new,
   TO_NUMBER(NULL)              AS vat_pct_val,
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
   vt.cherry_pick_receipts_cnt,
   TO_NUMBER(NULL)                     AS base_receipts_cnt,
   vt.base_sales_net_val                     AS base_sales_net_val,
   TO_NUMBER(NULL)              AS base_sales_qty,
   TO_NUMBER(NULL)              AS receipt_total_sales_net_val,
   TO_NUMBER(NULL)              AS receipt_action_sales_net_val
   FROM p_lew_mart_analytics.t_advert_week_period_action_type AS vt
   INNER JOIN p_lew_mart_analytics.t_advert_week_period AS awp
   ON  vt.client_id               = awp.client_id
   AND vt.adv_week_id             = awp.adv_week_id
   AND vt.adv_period_id           = awp.adv_period_id
   INNER JOIN p_lew_mart_analytics.t_action_type AS act
   ON  vt.action_type_id          = act.action_type_id
   LEFT OUTER JOIN
   (
       SELECT
         client_id,
   adv_week_id,
   adv_period_id,
   action_type_id,
   SUM(-1 * (price_retail_net_old - price_retail_net_new) * sales_qty) AS pv_net_val
      FROM p_lew_mart_analytics.t_advert_week_item
      WHERE action_type_id = 1
      GROUP BY 1,2,3,4
  ) AS pv
   ON  vt.client_id              = pv.client_id
   AND vt.adv_week_id            = pv.adv_week_id
   AND vt.action_type_id         = pv.action_type_id
   AND vt.adv_period_id          = pv.adv_period_id
   WHERE hier_level_id = 12
   UNION ALL
   SELECT
     vt.client_id,
   vt.adv_week_id,
   CAST(vt.adv_week_id * 100 + vt.client_id AS INTEGER)               AS adv_week_sid,
   MIN(COALESCE(vt.orig_adv_week_id, vt.adv_week_id))                 AS orig_adv_week_id,
   CAST(MIN(COALESCE(vt.orig_adv_week_id, vt.adv_week_id) * 100 + vt.client_id) AS INTEGER)
                                                                       AS orig_adv_week_sid,
   CASE WHEN MIN(vt.orig_adv_week_id) IS NOT NULL THEN 1 ELSE 0 END   AS extended_week_fg,
   CAST(11 AS BYTEINT)                       AS hier_level_id,
   MIN(LPAD(CAST(act.action_type_sort_val AS VARCHAR(3)), 3, '0')
    || '#' || LPAD(CAST(awp.adv_week_period_sort_val AS VARCHAR(3)), 3, '0')
    || '#' || LPAD(CAST(vt.orig_item_nr /*Warning, Format 'Z(18)9' removed, semantic information not found.*/ AS VARCHAR(10)), 10, '0'))
                                              AS sort_order_val,
   MIN(vt.action_type_id)                    AS action_type_id,
   MIN(vt.adv_period_id)                     AS adv_period_id,
   MIN(vt.item_sid)                          AS item_sid,
   MIN(vt.sub_item_grp_sid)                  AS sub_item_grp_sid,
   MIN(vt.item_grp_int_sid)                  AS item_grp_int_sid,
   MIN(vt.price_retail_old)                  AS price_retail_old,
   MIN(vt.price_retail_new)                  AS price_retail_new,
   MIN(vt.price_retail_net_old)              AS price_retail_net_old,
   MIN(vt.price_retail_net_new)              AS price_retail_net_new,
   MIN(vt.vat_pct_val)                       AS vat_pct_val,
   CAST(100 * (MIN(vt.price_retail_old) - MIN(vt.price_retail_new) ) AS DECIMAL(18,5)) / CASE WHEN MIN(vt.price_retail_old) = 0 THEN NULL ELSE MIN(vt.price_retail_old) END
   AS price_retail_diff_pct,
   SUM(CASE WHEN vt.action_type_id = 1
                 THEN -1 * (vt.price_retail_net_old - vt.price_retail_net_new) * vt.sales_qty
             ELSE NULL
        END)                                  AS pv_net_val,
   CAST(1 AS INTEGER)                        AS advert_items_cnt,
   MAX(vt.stores_cnt)                        AS stores_cnt,
   SUM(vt.receipts_cnt)                      AS receipts_cnt,
   SUM(vt.sales_net_val)                     AS sales_net_val,
   SUM(CAST(vt.price_buy * vt.sales_qty AS DECIMAL(18,5)))
                                              AS sales_buy_price_net_val,
   SUM(vt.sales_qty)                         AS sales_qty,
   SUM(vt.sales_1d_qty)                      AS sales_1d_qty,
   SUM(vt.deliv_qty)                         AS deliv_qty,
   MAX(vt.total_receipts_cnt)                AS total_receipts_cnt,
   MAX(vt.total_sales_net_val)               AS total_sales_net_val,
   SUM(vt.cherry_pick_receipts_cnt)          AS cherry_pick_receipts_cnt,
   SUM(vt.base_receipts_cnt)                 AS base_receipts_cnt,
   SUM(vt.base_sales_net_val)                AS base_sales_net_val,
   SUM(vt.base_sales_qty)                    AS base_sales_qty,
   SUM(vt.receipt_total_sales_net_val)       AS receipt_total_sales_net_val,
   SUM(vt.receipt_action_sales_net_val)      AS receipt_action_sales_net_val
  FROM p_lew_mart_analytics.t_advert_week_item AS vt
   INNER JOIN p_lew_mart_analytics.t_advert_week_period AS awp
   ON  vt.client_id               = awp.client_id
   AND vt.adv_week_id             = awp.adv_week_id
   AND vt.adv_period_id           = awp.adv_period_id
   INNER JOIN p_lew_mart_analytics.t_action_type AS act
   ON  vt.action_type_id          = act.action_type_id
   WHERE hier_level_id = 11
   GROUP BY
     vt.client_id
   , vt.adv_week_id
   , vt.orig_item_nr
   ;
