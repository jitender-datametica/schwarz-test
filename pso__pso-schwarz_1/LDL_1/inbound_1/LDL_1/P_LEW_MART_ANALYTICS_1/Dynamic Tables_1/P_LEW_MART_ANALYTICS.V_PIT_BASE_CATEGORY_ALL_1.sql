
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_BASE_CATEGORY_ALL_1
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     vt.client_id,
   vt.adv_week_id,
   COALESCE(rwk.adv_week_id, -1)                     AS rltd_adv_week_id,
   CAST(44 AS BYTEINT)                               AS hier_level_id,
   'X'                         AS sort_order_val,
   CAST(-2 AS INTEGER)                               AS item_grp_int_sid,
   CAST(-2 AS INTEGER)                               AS sub_item_grp_sid,
   COALESCE(vt.advert_items_pv_cnt, 0)
    + COALESCE(vt.advert_items_nf_cnt, 0)
    + COALESCE(vt.advert_items_fa_cnt, 0)             AS advert_items_cnt,
   COALESCE(vt.advert_items_pv_cnt, 0)               AS advert_items_pv_cnt,
   COALESCE(vt.advert_items_nf_cnt, 0)               AS advert_items_nf_cnt,
   COALESCE(vt.advert_items_fa_cnt, 0)               AS advert_items_fa_cnt,
   vt.stores_cnt,
   vt.receipts_cnt,
   vt.sales_net_val,
   vt.sales_buy_price_net_val,
   vt.total_receipts_cnt,
   vt.total_sales_net_val,
   vtr.receipts_cnt                                  AS rltd_receipts_cnt,
   vtr.sales_net_val                                 AS rltd_sales_net_val,
   CASE WHEN RANK() OVER (PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST) = 1 THEN 1 ELSE 0 END AS nearest_rltd_adv_week_fg
  FROM p_lew_mart_analytics.t_advert_week_total_1 AS vt
   LEFT OUTER JOIN p_lew_mart_analytics.t_advert_week_1 AS rwk
   ON  vt.client_id              = rwk.client_id
   AND vt.adv_week_id            > rwk.adv_week_id
   LEFT OUTER JOIN p_lew_mart_analytics.t_advert_week_total_1 AS vtr
   ON  rwk.client_id              = vtr.client_id
   AND rwk.adv_week_id            = vtr.adv_week_id
   WHERE hier_level_id = 44
   UNION ALL
   SELECT
     awk.client_id,
   awk.adv_week_id,
   COALESCE(rwk.adv_week_id, -1)                     AS rltd_adv_week_id,
   CAST(43 AS BYTEINT)                               AS hier_level_id,
   LPAD(igi.src_itemgrp_int_cd, 20, '0')
    || '#X'                                           AS sort_order_val,
   igi.item_grp_int_sid,
   CAST(-2 AS INTEGER)                               AS sub_item_grp_sid,
   CASE WHEN vt.client_id IS NOT NULL
         THEN COALESCE(vt.advert_items_pv_cnt, 0)
            + COALESCE(vt.advert_items_nf_cnt, 0)
            + COALESCE(vt.advert_items_fa_cnt, 0)
    END                                               AS advert_items_cnt,
   CASE WHEN vt.client_id IS NOT NULL
         THEN COALESCE(vt.advert_items_pv_cnt, 0)
    END                                               AS advert_items_pv_cnt,
   CASE WHEN vt.client_id IS NOT NULL
         THEN COALESCE(vt.advert_items_nf_cnt, 0)
    END                                               AS advert_items_nf_cnt,
   CASE WHEN vt.client_id IS NOT NULL
         THEN COALESCE(vt.advert_items_fa_cnt, 0)
    END                                               AS advert_items_fa_cnt,
   vt.stores_cnt,
   vt.receipts_cnt,
   vt.sales_net_val,
   vt.sales_buy_price_net_val,
   vt.total_receipts_cnt,
   vt.total_sales_net_val,
   vtr.receipts_cnt                                  AS rltd_receipts_cnt,
   vtr.sales_net_val                                 AS rltd_sales_net_val,
   CASE WHEN RANK() OVER (PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST) = 1 THEN 1 ELSE 0 END AS nearest_rltd_adv_week_fg
  FROM p_lew_mart_analytics.t_advert_week_1 AS awk
   INNER JOIN p_lew_core_ac.v_itemgroup_international_1 AS igi
   ON  awk.client_id             = igi.client_id
   AND TRY_CAST(igi.src_itemgrp_int_cd AS INTEGER) > 0
   LEFT OUTER JOIN p_lew_mart_analytics.t_advert_week_1 AS rwk
   ON  awk.client_id             = rwk.client_id
   AND awk.adv_week_id           > rwk.adv_week_id
   LEFT OUTER JOIN p_lew_mart_analytics.t_advert_week_itemgroup_int_1 AS vt
   ON  awk.client_id             = vt.client_id
   AND awk.adv_week_id           = vt.adv_week_id
   AND igi.item_grp_int_sid      = vt.item_grp_int_sid
   LEFT OUTER JOIN p_lew_mart_analytics.t_advert_week_itemgroup_int_1 AS vtr
   ON  rwk.client_id             = vtr.client_id
   AND rwk.adv_week_id           = vtr.adv_week_id
   AND igi.item_grp_int_sid      = vtr.item_grp_int_sid
   WHERE hier_level_id = 43
   UNION ALL
   SELECT
     awk.client_id,
   awk.adv_week_id,
   COALESCE(rwk.adv_week_id, -1)                     AS rltd_adv_week_id,
   CAST(42 AS BYTEINT)                               AS hier_level_id,
   LPAD(igi.src_itemgrp_int_cd, 20, '0')
    || '#' || LPAD(sig.src_subitemgrp_cd, 20, '0')    AS sort_order_val,
   igi.item_grp_int_sid,
   sig.sub_item_grp_sid,
   CASE WHEN vt.client_id IS NOT NULL
         THEN COALESCE(vt.advert_items_pv_cnt, 0)
            + COALESCE(vt.advert_items_nf_cnt, 0)
            + COALESCE(vt.advert_items_fa_cnt, 0)
    END                                               AS advert_items_cnt,
   CASE WHEN vt.client_id IS NOT NULL
         THEN COALESCE(vt.advert_items_pv_cnt, 0)
    END                                               AS advert_items_pv_cnt,
   CASE WHEN vt.client_id IS NOT NULL
        THEN COALESCE(vt.advert_items_nf_cnt, 0)
    END                                               AS advert_items_nf_cnt,
   CASE WHEN vt.client_id IS NOT NULL
         THEN COALESCE(vt.advert_items_fa_cnt, 0)
    END                                               AS advert_items_fa_cnt,
   vt.stores_cnt,
   vt.receipts_cnt,
   vt.sales_net_val,
   vt.sales_buy_price_net_val,
   vt.total_receipts_cnt,
   vt.total_sales_net_val,
   vtr.receipts_cnt                                  AS rltd_receipts_cnt,
   vtr.sales_net_val                                 AS rltd_sales_net_val,
   CASE WHEN RANK() OVER (PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST) = 1 THEN 1 ELSE 0 END AS nearest_rltd_adv_week_fg
  FROM p_lew_mart_analytics.t_advert_week_1 AS awk
   INNER JOIN p_lew_core_ac.v_subitemgroup_1 AS sig
   ON  awk.client_id             = sig.client_id
   AND TRY_CAST(sig.src_subitemgrp_cd AS INTEGER) > 0
   AND SUBSTR( sig.sub_item_grp_name, 1, 7) <> '!STORNO'
   INNER JOIN p_lew_core_ac.v_subitemgroup_hist_1 AS sgh
   ON  sig.client_id             = sgh.client_id
   AND sig.sub_item_grp_sid      = sgh.sub_item_grp_sid
   AND CURRENT_DATE BETWEEN sgh.dwh_valid_from AND sgh.dwh_valid_to
   AND sgh.deleted_fg = 0
   INNER JOIN p_lew_core_ac.v_itemgroup_international_1 AS igi
   ON  sgh.client_id             = igi.client_id
   AND sgh.item_grp_int_sid      = igi.item_grp_int_sid
   AND CAST(igi.src_itemgrp_int_cd AS INTEGER) > 0
   LEFT OUTER JOIN p_lew_mart_analytics.t_advert_week_1 AS rwk
   ON  awk.client_id             = rwk.client_id
   AND awk.adv_week_id           > rwk.adv_week_id
   LEFT OUTER JOIN p_lew_mart_analytics.t_advert_week_subitemgroup_1 AS vt
   ON  awk.client_id             = vt.client_id
   AND awk.adv_week_id           = vt.adv_week_id
   AND sig.sub_item_grp_sid      = vt.sub_item_grp_sid
   LEFT OUTER JOIN p_lew_mart_analytics.t_advert_week_subitemgroup_1 AS vtr
   ON  rwk.client_id             = vtr.client_id
   AND rwk.adv_week_id           = vtr.adv_week_id
   AND sig.sub_item_grp_sid      = vtr.sub_item_grp_sid
   WHERE hier_level_id = 42
   ;
