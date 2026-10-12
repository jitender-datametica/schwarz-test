-- Itemgroup_1  ( WGI )  Level  ( 43):
 -- AdvWeek Total Level for Category  ( 44):

-- Sub Itemgroup_1  ( UWG )  Level  ( 42):
 CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_base_category_all_1 AS
SELECT VT.client_id,
 VT.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 CAST(VT.adv_week_id * 100 + VT.client_id AS BIGNUMERIC) AS adv_week_sid,
 CAST(COALESCE(RWK.adv_week_id, - 1) * 100 + VT.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 44 AS hier_level_id,
 'X' AS sort_order_val,
 - 2 AS item_grp_int_sid,
 - 2 AS sub_item_grp_sid,
 CAST(- 2 * 100 + VT.client_id AS BIGNUMERIC) AS item_grp_int_mstr_sid,
 CAST(- 2 * 100 + VT.client_id AS BIGNUMERIC) AS sub_item_grp_mstr_sid,
   COALESCE(VT.advert_items_pv_cnt, 0) + COALESCE(VT.advert_items_nf_cnt, 0) + COALESCE(VT.advert_items_fa_cnt, 0) AS
 advert_items_cnt,
 COALESCE(VT.advert_items_pv_cnt, 0) AS advert_items_pv_cnt,
 COALESCE(VT.advert_items_nf_cnt, 0) AS advert_items_nf_cnt,
 COALESCE(VT.advert_items_fa_cnt, 0) AS advert_items_fa_cnt,
 VT.stores_cnt,
 VT.receipts_cnt,
 VT.sales_net_val,
 VT.sales_buy_price_net_val,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 VTR.receipts_cnt AS rltd_receipts_cnt,
 VTR.sales_net_val AS rltd_sales_net_val,
 VTR.stores_cnt AS rltd_stores_cnt,
 VTR.total_receipts_cnt AS rltd_total_receipts_cnt,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_total_1 AS VT
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS RWK ON VT.client_id = RWK.client_id AND VT.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_total_1 AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id =
   VTR.adv_week_id
WHERE 44 = 44 -- AdvWeek Total Level
 -- AdvWeek Total Level

UNION ALL
SELECT AWK.client_id,
 AWK.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 CAST(AWK.adv_week_id * 100 + AWK.client_id AS BIGNUMERIC) AS adv_week_sid,
 CAST(COALESCE(RWK.adv_week_id, - 1) * 100 + AWK.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 43 AS hier_level_id,
  LPAD(IGI.src_itemgrp_int_cd, 20, '0') || '#X' AS sort_order_val,
 IGI.item_grp_int_sid,
 - 2 AS sub_item_grp_sid,
 CAST(IGI.item_grp_int_sid * 100 + VT.client_id AS BIGNUMERIC) AS item_grp_int_mstr_sid,
 CAST(- 2 * 100 + VT.client_id AS BIGNUMERIC) AS sub_item_grp_mstr_sid,
  CASE
  WHEN VT.client_id IS NOT NULL
  THEN COALESCE(VT.advert_items_pv_cnt, 0) + COALESCE(VT.advert_items_nf_cnt, 0) + COALESCE(VT.advert_items_fa_cnt, 0)
  ELSE NULL
  END AS advert_items_cnt,
  CASE
  WHEN VT.client_id IS NOT NULL
  THEN COALESCE(VT.advert_items_pv_cnt, 0)
  ELSE NULL
  END AS advert_items_pv_cnt,
  CASE
  WHEN VT.client_id IS NOT NULL
  THEN COALESCE(VT.advert_items_nf_cnt, 0)
  ELSE NULL
  END AS advert_items_nf_cnt,
  CASE
  WHEN VT.client_id IS NOT NULL
  THEN COALESCE(VT.advert_items_fa_cnt, 0)
  ELSE NULL
  END AS advert_items_fa_cnt,
 VT.stores_cnt,
 VT.receipts_cnt,
 VT.sales_net_val,
 VT.sales_buy_price_net_val,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 VTR.receipts_cnt AS rltd_receipts_cnt,
 VTR.sales_net_val AS rltd_sales_net_val,
 VTR.stores_cnt AS rltd_stores_cnt,
 VTR.total_receipts_cnt AS rltd_total_receipts_cnt,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS AWK
 INNER JOIN ldl_p_lew_core_ac.v_itemgroup_international_1 AS IGI ON AWK.client_id = IGI.client_id AND ROUND(SAFE_CAST(IGI
     .src_itemgrp_int_cd AS BIGNUMERIC), 0) > 0
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS RWK ON AWK.client_id = RWK.client_id AND AWK.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_itemgroup_int_1 AS VT ON AWK.client_id = VT.client_id AND AWK.adv_week_id
     = VT.adv_week_id AND IGI.item_grp_int_sid = VT.item_grp_int_sid
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_itemgroup_int_1 AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id
     = VTR.adv_week_id AND IGI.item_grp_int_sid = VTR.item_grp_int_sid
WHERE 43 = 43 -- Itemgroup_1  ( WGI )  Level
 -- Itemgroup_1  ( WGI )  Level

UNION ALL
SELECT AWK.client_id,
 AWK.adv_week_id,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 CAST(AWK.adv_week_id * 100 + AWK.client_id AS BIGNUMERIC) AS adv_week_sid,
 CAST(COALESCE(RWK.adv_week_id, - 1) * 100 + AWK.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 42 AS hier_level_id,
   LPAD(IGI.src_itemgrp_int_cd, 20, '0') || '#' || LPAD(SIG.src_subitemgrp_cd, 20, '0') AS sort_order_val,
 IGI.item_grp_int_sid,
 SIG.sub_item_grp_sid,
 CAST(IGI.item_grp_int_sid * 100 + VT.client_id AS BIGNUMERIC) AS item_grp_int_mstr_sid,
 CAST(SIG.sub_item_grp_sid * 100 + VT.client_id AS BIGNUMERIC) AS sub_item_grp_mstr_sid,
  CASE
  WHEN VT.client_id IS NOT NULL
  THEN COALESCE(VT.advert_items_pv_cnt, 0) + COALESCE(VT.advert_items_nf_cnt, 0) + COALESCE(VT.advert_items_fa_cnt, 0)
  ELSE NULL
  END AS advert_items_cnt,
  CASE
  WHEN VT.client_id IS NOT NULL
  THEN COALESCE(VT.advert_items_pv_cnt, 0)
  ELSE NULL
  END AS advert_items_pv_cnt,
  CASE
  WHEN VT.client_id IS NOT NULL
  THEN COALESCE(VT.advert_items_nf_cnt, 0)
  ELSE NULL
  END AS advert_items_nf_cnt,
  CASE
  WHEN VT.client_id IS NOT NULL
  THEN COALESCE(VT.advert_items_fa_cnt, 0)
  ELSE NULL
  END AS advert_items_fa_cnt,
 VT.stores_cnt,
 VT.receipts_cnt,
 VT.sales_net_val,
 VT.sales_buy_price_net_val,
 VT.total_receipts_cnt,
 VT.total_sales_net_val,
 VTR.receipts_cnt AS rltd_receipts_cnt,
 VTR.sales_net_val AS rltd_sales_net_val,
 VTR.stores_cnt AS rltd_stores_cnt,
 VTR.total_receipts_cnt AS rltd_total_receipts_cnt,
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS AWK
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_1 AS SIG ON AWK.client_id = SIG.client_id AND ROUND(SAFE_CAST(SIG.src_subitemgrp_cd
      AS BIGNUMERIC), 0) > 0 AND SUBSTR(SIG.sub_item_grp_name, 1, 7) <> '!STORNO'
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist_1 AS SGH ON SIG.client_id = SGH.client_id AND SIG.sub_item_grp_sid = SGH
     .sub_item_grp_sid AND CURRENT_DATE BETWEEN SGH.dwh_valid_from AND SGH.dwh_valid_to AND SGH.deleted_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_itemgroup_international_1 AS IGI ON SGH.client_id = IGI.client_id AND SGH.item_grp_int_sid
     = IGI.item_grp_int_sid AND ROUND(SAFE_CAST(IGI.src_itemgrp_int_cd AS BIGNUMERIC), 0) > 0
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS RWK ON AWK.client_id = RWK.client_id AND AWK.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_subitemgroup_1 AS VT ON AWK.client_id = VT.client_id AND AWK.adv_week_id
     = VT.adv_week_id AND SIG.sub_item_grp_sid = VT.sub_item_grp_sid
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_subitemgroup_1 AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id
     = VTR.adv_week_id AND SIG.sub_item_grp_sid = VTR.sub_item_grp_sid
WHERE 42 = 42 -- Sub Itemgroup_1  ( UWG )  Level
 -- Sub Itemgroup_1  ( UWG )  Level
;