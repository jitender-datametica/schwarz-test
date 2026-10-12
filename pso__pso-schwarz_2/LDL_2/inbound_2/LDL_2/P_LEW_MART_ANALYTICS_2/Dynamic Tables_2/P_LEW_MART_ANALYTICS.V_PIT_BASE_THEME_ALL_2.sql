
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_BASE_THEME_ALL_2
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     vt.client_id,
   vt.adv_week_id,
   CAST(vt.adv_week_id *100 + vt.client_id AS INTEGER)   AS adv_week_sid,
   CAST(33 AS BYTEINT)                                   AS hier_level_id,
   '2#X'                           AS sort_order_val,
   CAST(-2 AS INTEGER)                                   AS adv_theme_sid,
   CAST(-2 *100 + client_id AS INTEGER)                  AS adv_theme_mstr_sid,
   COALESCE(vt.advert_items_pv_cnt, 0)
    + COALESCE(vt.advert_items_nf_cnt, 0)
    + COALESCE(vt.advert_items_fa_cnt, 0)                 AS advert_items_cnt,
   COALESCE(vt.advert_items_pv_cnt, 0)                   AS advert_items_pv_cnt,
   COALESCE(vt.advert_items_nf_cnt, 0)                   AS advert_items_nf_cnt,
   COALESCE(vt.advert_items_fa_cnt, 0)                   AS advert_items_fa_cnt,
   vt.stores_cnt,
   vt.receipts_cnt,
   vt.sales_net_val,
   vt.sales_buy_price_net_val,
   vt.total_receipts_cnt,
   vt.total_sales_net_val
  FROM p_lew_mart_analytics.t_advert_week_theme_total_2 AS vt
   WHERE hier_level_id = 33
   UNION ALL
   SELECT
     vt.client_id,
   vt.adv_week_id,
   CAST(vt.adv_week_id *100 + vt.client_id AS INTEGER)   AS adv_week_sid,
   CAST(32 AS BYTEINT)                                   AS hier_level_id,
   '1#' || th.adv_theme_descr                            AS sort_order_val,
   vt.adv_theme_sid                                      AS adv_theme_sid,
   CAST(vt.adv_theme_sid *100 + vt.client_id AS INTEGER) AS adv_theme_mstr_sid,
   COALESCE(vt.advert_items_pv_cnt, 0)
    + COALESCE(vt.advert_items_nf_cnt, 0)
    + COALESCE(vt.advert_items_fa_cnt, 0)                 AS advert_items_cnt,
   COALESCE(vt.advert_items_pv_cnt, 0)                   AS advert_items_pv_cnt,
   COALESCE(vt.advert_items_nf_cnt, 0)                   AS advert_items_nf_cnt,
   COALESCE(vt.advert_items_fa_cnt, 0)                   AS advert_items_fa_cnt,
   vt.stores_cnt,
   vt.receipts_cnt,
   vt.sales_net_val,
   vt.sales_buy_price_net_val,
   vt.total_receipts_cnt,
   vt.total_sales_net_val
  FROM p_lew_mart_analytics.t_advert_week_theme_2 AS vt
   INNER JOIN p_lew_mart_analytics.t_advert_theme_2 AS th
   ON  vt.client_id       = th.client_id
   AND vt.adv_theme_sid   = th.adv_theme_sid
   WHERE hier_level_id = 32
   ;
