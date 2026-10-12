CREATE OR REPLACE VIEW ldl_p_lew_bil.v_agg_deliv_wh_day_item_aspect_2 AS SELECT A.client_id,
 WH.src_wh_id,
 A.item_sid,
 A.dat_formdate,
 A.deliverytype_id,
 ALL_MER.aspect_id,
 SUM(A.qty_total_del) AS qty_total_del,
 SUM(A.val_rtl_rl_del) AS val_rtl_rl_del,
 SUM(A.val_rtl_rl_net_del) AS val_rtl_rl_net_del,
 SUM(A.qty_piece_del_agg) AS qty_piece_del,
 SUM(A.val_piece_del) AS val_piece_del,
 SUM(A.val_piece_net_del) AS val_piece_net_del,
 SUM(A.val_pr_diff_del) AS val_pr_diff_del,
 SUM(A.val_pr_diff_net_del) AS val_pr_diff_net_del,
 SUM(CASE
   WHEN A.foodaction_fg = 1
   THEN A.qty_total_del
   ELSE NULL
   END) AS qty_total_fa_del,
 SUM(CASE
   WHEN A.foodaction_fg = 1
   THEN A.val_rtl_rl_del
   ELSE NULL
   END) AS val_rtl_rl_fa_del,
 SUM(CASE
   WHEN A.foodaction_fg = 1
   THEN A.val_rtl_rl_net_del
   ELSE NULL
   END) AS val_rtl_rl_net_fa_del,
 SUM(CASE
   WHEN A.foodaction_fg = 1
   THEN A.qty_piece_del_agg
   ELSE NULL
   END) AS qty_piece_fa_del,
 SUM(CASE
   WHEN A.foodaction_fg = 1
   THEN A.val_piece_del
   ELSE NULL
   END) AS val_piece_fa_del,
 SUM(CASE
   WHEN A.foodaction_fg = 1
   THEN A.val_piece_net_del
   ELSE NULL
   END) AS val_piece_net_fa_del,
 SUM(CASE
   WHEN A.foodaction_fg = 1
   THEN A.val_pr_diff_del
   ELSE NULL
   END) AS val_pr_diff_fa_del,
 SUM(CASE
   WHEN A.foodaction_fg = 1
   THEN A.val_pr_diff_net_del
   ELSE NULL
   END) AS val_pr_diff_net_fa_del
FROM ldl_p_lew_bil.t_agg_deliv_base_2 AS A
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_merge_act_2 AS MER ON A.client_id = MER.client_id AND A.loc_sid_store = MER
   .st_loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS ALL_MER ON MER.aspect_id = ALL_MER.aspect_id AND MER.client_id
     = ALL_MER.client_id AND MER.move_to_st_loc_sid = ALL_MER.move_to_st_loc_sid
 INNER JOIN ldl_p_lew_bil.v_warehouse_2 AS WH ON ALL_MER.client_id = WH.client_id AND ALL_MER.wh_loc_sid = WH.loc_sid_wh
  AND WH.dwh_actual_fg = 1
GROUP BY A.client_id,
 WH.src_wh_id,
 A.item_sid,
 A.dat_formdate,
 A.deliverytype_id,
 ALL_MER.aspect_id;