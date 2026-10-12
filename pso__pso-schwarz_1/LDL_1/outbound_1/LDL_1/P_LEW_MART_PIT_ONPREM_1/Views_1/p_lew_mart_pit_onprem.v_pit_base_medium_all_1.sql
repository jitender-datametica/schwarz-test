CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_base_medium_all_1 AS SELECT AWK.client_id,
 AWK.adv_week_id,
 CAST(AWK.adv_week_id * 100 + AWK.client_id AS BIGNUMERIC) AS adv_week_sid,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 CAST(RWK.adv_week_id * 100 + RWK.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 23 AS hier_level_id,
  TRIM(CAST(COALESCE(MDG.adv_medium_grp_sort_val, 0) AS STRING FORMAT '009')) || '000' AS sort_order_val,
 CAST(- 2 * MDG.adv_medium_grp_sid * MDG.client_id AS BIGNUMERIC) AS adv_medium_sid,
 CAST(- 2 * MDG.adv_medium_grp_sid * MDG.client_id * 100 + MDG.client_id AS BIGNUMERIC) AS adv_medium_mstr_sid,
 CAST(MDG.adv_medium_grp_sid * 100 + MDG.client_id AS BIGNUMERIC) AS adv_medium_grp_mstr_sid,
 MDG.adv_medium_grp_descr AS advert_medium_grp_descr,
  'TOT - ' || MDG.adv_medium_grp_descr AS advert_medium_descr,
 MDG.adv_medium_grp_sort_val AS adv_medium_grp_disp_order_nbr,
 0 AS adv_medium_disp_order_nbr,
 MDG.adv_medium_grp_sid,
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
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(AWK.client_id AS STRING), CAST(AWK.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS AWK
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_advert_medium_group_1 AS MDG ON AWK.client_id = MDG.client_id
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS RWK ON AWK.client_id = RWK.client_id AND AWK.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_medium_grp_1 AS VT ON AWK.client_id = VT.client_id AND AWK.adv_week_id
    = VT.adv_week_id AND MDG.adv_medium_grp_sid = VT.adv_medium_grp_sid
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_medium_grp_1 AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id
     = VTR.adv_week_id AND MDG.adv_medium_grp_sid = VTR.adv_medium_grp_sid
WHERE 23 = 23
 AND (MDG.adv_medium_grp_alw_vis_fg = 1 OR VT.client_id IS NOT NULL)
 AND MDG.adv_medium_grp_ignore_fg = 0
UNION ALL
SELECT VT.client_id,
 VT.adv_week_id,
 CAST(VT.adv_week_id * 100 + VT.client_id AS BIGNUMERIC) AS adv_week_sid,
 COALESCE(RWK.adv_week_id, - 1) AS rltd_adv_week_id,
 CAST(RWK.adv_week_id * 100 + VT.client_id AS BIGNUMERIC) AS rltd_adv_week_sid,
 22 AS hier_level_id,
  TRIM(CAST(COALESCE(MD.advert_medium_group_sort_val, 0) AS STRING FORMAT '009')) || TRIM(CAST(COALESCE(MD.advert_medium_sort_val, 0) AS STRING FORMAT '009')
   ) AS sort_order_val,
 VT.adv_medium_sid,
 CAST(VT.adv_medium_sid * 100 + VT.client_id AS BIGNUMERIC) AS adv_medium_mstr_sid,
 CAST(MD.advert_medium_group_sid * 100 + MD.client_id AS BIGNUMERIC) AS adv_medium_grp_mstr_sid,
 MD.advert_medium_group AS advert_medium_grp_descr,
 MD.advert_medium AS advert_medium_descr,
 COALESCE(MD.advert_medium_group_sort_val, 127) AS adv_medium_grp_disp_order_nbr,
 COALESCE(MD.advert_medium_sort_val, 0) AS adv_medium_disp_order_nbr,
 MD.advert_medium_group_sid AS adv_medium_grp_sid,
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
  CASE
  WHEN (RANK() OVER (PARTITION BY CAST(VT.client_id AS STRING), CAST(VT.adv_week_id AS STRING) ORDER BY COALESCE(RWK.adv_week_id
        , - 1) IS NULL, COALESCE(RWK.adv_week_id, - 1))) = 1
  THEN 1
  ELSE 0
  END AS nearest_rltd_adv_week_fg
FROM ldl_p_lew_mart_pit_onprem.t_advert_week_medium_1 AS VT
 INNER JOIN ldl_p_lew_mart_pit_onprem.t_pit_apt_advert_medium_client_1 AS MD ON VT.client_id = MD.client_id AND VT.adv_medium_sid
    = MD.advert_medium_sid
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_1 AS RWK ON VT.client_id = RWK.client_id AND VT.adv_week_id > RWK.adv_week_id
   
 LEFT JOIN ldl_p_lew_mart_pit_onprem.t_advert_week_medium_1 AS VTR ON RWK.client_id = VTR.client_id AND RWK.adv_week_id =
    VTR.adv_week_id AND VT.adv_medium_sid = VTR.adv_medium_sid
WHERE 22 = 22
 AND MD.advert_medium_ignore_fg = 0;