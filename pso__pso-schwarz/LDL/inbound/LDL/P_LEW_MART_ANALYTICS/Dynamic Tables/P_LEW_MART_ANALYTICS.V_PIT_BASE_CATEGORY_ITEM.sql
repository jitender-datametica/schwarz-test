
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_BASE_CATEGORY_ITEM
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     vt.client_id,
   vt.adv_week_id,
   CAST(vt.adv_week_id * 100 + vt.client_id AS INTEGER)               AS adv_week_sid,
   MIN(COALESCE(vt.orig_adv_week_id, vt.adv_week_id))                 AS orig_adv_week_id,
   CAST(MIN(COALESCE(vt.orig_adv_week_id, vt.adv_week_id) * 100 + vt.client_id) AS INTEGER)
                                                                       AS orig_adv_week_sid,
   CASE WHEN MIN(vt.orig_adv_week_id) IS NOT NULL THEN 1 ELSE 0 END   AS extended_week_fg,
   CAST(41 AS BYTEINT)                       AS hier_level_id,
   MIN(LPAD(CAST(act.action_type_sort_val AS VARCHAR(3)), 3, '0')
    || '#' || LPAD(CAST(awp.adv_week_period_sort_val AS VARCHAR(3)), 3, '0')
    || '#' || LPAD(CAST(vt.orig_item_nr /*Warning, Format 'Z(18)9' removed, semantic information not found.*/ AS VARCHAR(10)), 10, '0'))
                                              AS sort_order_val,
   MIN(vt.action_type_id)                    AS action_type_id,
   MIN(vt.adv_period_id)                     AS adv_period_id,
   MIN(awp.adv_week_period_sort_val)         AS adv_week_period_sort_val /* Obsolete, candidate for drop */,
   CAST(1 AS INTEGER)                        AS rowcnt,
   MIN(vt.item_sid)                          AS item_sid,
   MIN(vt.item_grp_int_sid)                  AS item_grp_int_sid,
   CAST(MIN(vt.item_grp_int_sid * 100 + vt.client_id) AS INTEGER) AS item_grp_int_mstr_sid,
   MIN(vt.sub_item_grp_sid)                  AS sub_item_grp_sid,
   CAST(MIN(vt.sub_item_grp_sid * 100 + vt.client_id) AS INTEGER) AS sub_item_grp_mstr_sid,
   MIN(vt.price_retail_old)                  AS price_retail_old,
   MIN(vt.price_retail_new)                  AS price_retail_new,
   MIN(vt.price_retail_net_old)              AS price_retail_net_old,
   MIN(vt.price_retail_net_new)              AS price_retail_net_new,
   MIN(vt.vat_pct_val)                       AS vat_pct_val,
   SUM(CASE WHEN vt.action_type_id = 1
                 THEN -1 * (vt.price_retail_net_old - vt.price_retail_net_new) * vt.sales_qty
             ELSE NULL
        END)                                  AS pv_net_val,
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
   ON  vt.client_id     = awp.client_id
   AND vt.adv_week_id   = awp.adv_week_id
   AND vt.adv_period_id = awp.adv_period_id
   INNER JOIN p_lew_mart_analytics.t_action_type AS act
   ON  vt.action_type_id    = act.action_type_id
   WHERE hier_level_id = 41
   GROUP BY
     vt.client_id
   , vt.adv_week_id
   , vt.orig_item_nr
   ;
