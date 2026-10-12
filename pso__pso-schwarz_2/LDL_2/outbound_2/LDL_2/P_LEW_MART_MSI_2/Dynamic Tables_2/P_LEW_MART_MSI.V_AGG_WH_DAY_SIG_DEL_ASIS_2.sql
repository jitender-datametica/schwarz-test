CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_agg_wh_day_sig_del_asis_2
AS
SELECT aji.client_id,
 WH.src_wh_id AS wh_id,
 aji.aspect_id,
 ROUND(CAST(S.src_subitemgrp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
 aji.dat_formdate,
 aji.cy_month,
 aji.deliverytype_id,
 B.curr_cd_from AS currency_iso_cd,
 aji.qty_total_del_asis,
  aji.val_rtl_rl_del_asis / B.exchange_rate AS val_rtl_rl_del_asis,
  aji.val_rtl_rl_net_del_asis / B.exchange_rate AS val_rtl_rl_net_del_asis,
 aji.qty_piece_del_asis,
  aji.val_piece_del_asis / B.exchange_rate AS val_piece_del_asis,
  aji.val_piece_net_del_asis / B.exchange_rate AS val_piece_net_del_asis,
  aji.val_pr_diff_del_asis / B.exchange_rate AS val_pr_diff_del_asis,
  aji.val_pr_diff_net_del_asis / B.exchange_rate AS val_pr_diff_net_del_asis,
 aji.qty_total_fa_del_asis,
  aji.val_rtl_rl_fa_del_asis / B.exchange_rate AS val_rtl_rl_fa_del_asis,
  aji.val_rtl_rl_net_fa_del_asis / B.exchange_rate AS val_rtl_rl_net_fa_del_asis,
 aji.qty_piece_fa_del_asis,
  aji.val_piece_fa_del_asis / B.exchange_rate AS val_piece_fa_del_asis,
  aji.val_piece_net_fa_del_asis / B.exchange_rate AS val_piece_net_fa_del_asis,
  aji.val_pr_diff_fa_del_asis / B.exchange_rate AS val_pr_diff_fa_del_asis,
  aji.val_pr_diff_net_fa_del_asis / B.exchange_rate AS val_pr_diff_net_fa_del_asis
FROM (SELECT client_id,
    loc_sid_wh_aspect1_asis AS loc_sid_wh,
    MAX(1) AS aspect_id,
    sub_item_grp_sid_asis,
    dat_formdate,
    cy_month,
    deliverytype_id,
    SUM(qty_total_del) AS qty_total_del_asis,
    SUM(val_rtl_rl_del) AS val_rtl_rl_del_asis,
    SUM(val_rtl_rl_net_del) AS val_rtl_rl_net_del_asis,
    SUM(qty_piece_del_agg) AS qty_piece_del_asis,
    SUM(val_piece_del) AS val_piece_del_asis,
    SUM(val_piece_net_del) AS val_piece_net_del_asis,
    SUM(val_pr_diff_del) AS val_pr_diff_del_asis,
    SUM(val_pr_diff_net_del) AS val_pr_diff_net_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND qty_total_del IS NOT NULL
      THEN qty_total_del
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS qty_total_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND val_rtl_rl_del IS NOT NULL
      THEN val_rtl_rl_del
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS val_rtl_rl_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND val_rtl_rl_net_del IS NOT NULL
      THEN val_rtl_rl_net_del
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS val_rtl_rl_net_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND qty_piece_del_agg IS NOT NULL
      THEN qty_piece_del_agg
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS qty_piece_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND val_piece_del IS NOT NULL
      THEN val_piece_del
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS val_piece_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND val_piece_net_del IS NOT NULL
      THEN val_piece_net_del
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS val_piece_net_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1
      THEN val_pr_diff_del
      ELSE NULL
      END) AS val_pr_diff_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1
      THEN val_pr_diff_net_del
      ELSE NULL
      END) AS val_pr_diff_net_fa_del_asis
   FROM ldl_p_lew_bil_ac.v_agg_deliv_base_2 AS A
   WHERE client_id <> 18
    OR loc_sid_store NOT IN (SELECT loc_sid
      FROM ldl_p_lew_core_ac.v_location_2
      WHERE client_id = 18
       AND (src_orig_store_nr BETWEEN 7501 AND 7599 OR src_orig_store_nr = 9988))
   GROUP BY client_id,
    loc_sid_wh,
    sub_item_grp_sid_asis,
    dat_formdate,
    cy_month,
    deliverytype_id
   UNION ALL
   SELECT client_id,
    loc_sid_wh_aspect2_asis AS loc_sid_wh,
    MAX(2) AS aspect_id,
    sub_item_grp_sid_asis,
    dat_formdate,
    cy_month,
    deliverytype_id,
    SUM(qty_total_del) AS qty_total_del_asis,
    SUM(val_rtl_rl_del) AS val_rtl_rl_del_asis,
    SUM(val_rtl_rl_net_del) AS val_rtl_rl_net_del_asis,
    SUM(qty_piece_del_agg) AS qty_piece_del_asis,
    SUM(val_piece_del) AS val_piece_del_asis,
    SUM(val_piece_net_del) AS val_piece_net_del_asis,
    SUM(val_pr_diff_del) AS val_pr_diff_del_asis,
    SUM(val_pr_diff_net_del) AS val_pr_diff_net_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND qty_total_del IS NOT NULL
      THEN qty_total_del
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS qty_total_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND val_rtl_rl_del IS NOT NULL
      THEN val_rtl_rl_del
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS val_rtl_rl_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND val_rtl_rl_net_del IS NOT NULL
      THEN val_rtl_rl_net_del
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS val_rtl_rl_net_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND qty_piece_del_agg IS NOT NULL
      THEN qty_piece_del_agg
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS qty_piece_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND val_piece_del IS NOT NULL
      THEN val_piece_del
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS val_piece_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1 AND val_piece_net_del IS NOT NULL
      THEN val_piece_net_del
      WHEN src_fg = 1
      THEN 0
      ELSE NULL
      END) AS val_piece_net_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1
      THEN val_pr_diff_del
      ELSE NULL
      END) AS val_pr_diff_fa_del_asis,
    SUM(CASE
      WHEN foodaction_fg = 1
      THEN val_pr_diff_net_del
      ELSE NULL
      END) AS val_pr_diff_net_fa_del_asis
   FROM ldl_p_lew_bil_ac.v_agg_deliv_base_2 AS A
   WHERE client_id <> 18
    OR loc_sid_store NOT IN (SELECT loc_sid
      FROM ldl_p_lew_core_ac.v_location_2
      WHERE client_id = 18
       AND src_orig_store_nr BETWEEN 7501 AND 7599)
   GROUP BY client_id,
    loc_sid_wh,
    sub_item_grp_sid_asis,
    dat_formdate,
    cy_month,
    deliverytype_id) AS aji
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS B ON aji.client_id = B.client_id AND CURRENT_DATE BETWEEN B
     .active_from_dt AND B.active_to_dt AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to AND B.deleted_fg =
   0
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE'
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON aji.client_id = WH.client_id AND aji.loc_sid_wh = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 LEFT JOIN ldl_p_lew_core_ac.v_subitemgroup_2 AS S ON aji.client_id = S.client_id AND aji.sub_item_grp_sid_asis = S.sub_item_grp_sid;

