/* DescStart
$Revision: 8040 $, $LastChangedBy: mlysik $
SubjectAreas: Anliefermenge
DescEnd */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_deliv_base_2 AS SELECT b.client_id,
 b.item_sid,
 b.dat_formdate,
 b.loc_sid_store,
 b.loc_sid_wh_asis,
 b.deliverytype_id,
 b.orig_store_nr,
 b.cy_month,
 b.sub_item_grp_sid_asis,
 b.foodaction_fg,
 b.qty_total_del,
 b.val_rtl_rl_del,
 b.val_rtl_rl_net_del,
 b.qty_piece_del_agg,
 b.val_piece_del,
 b.val_piece_net_del,
 b.val_pr_diff_del,
 b.val_pr_diff_net_del,
 b.src_fg,
 ALL_ASPECT1.wh_loc_sid AS loc_sid_wh_aspect1_asis,
 ALL_ASPECT2.wh_loc_sid AS loc_sid_wh_aspect2_asis,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM (SELECT client_id,
   item_sid,
   dat_formdate,
   loc_sid_store,
   MAX(loc_sid_wh) AS loc_sid_wh_asis,
   deliverytype_id,
   MAX(orig_store_nr) AS orig_store_nr,
   MAX(cy_month) AS cy_month,
   MAX(sub_item_grp_sid) AS sub_item_grp_sid_asis,
   MAX(foodaction_fg) AS foodaction_fg,
   SUM(qty_total_del) AS qty_total_del,
   SUM(val_rtl_rl_del) AS val_rtl_rl_del,
   SUM(val_rtl_rl_net_del) AS val_rtl_rl_net_del,
   SUM(qty_piece_del_agg) AS qty_piece_del_agg,
   SUM(val_piece_del) AS val_piece_del,
   SUM(val_piece_net_del) AS val_piece_net_del,
   SUM(val_pr_diff_del) AS val_pr_diff_del,
   SUM(val_pr_diff_net_del) AS val_pr_diff_net_del,
   MAX(src_fg) AS src_fg
  FROM (SELECT *
     FROM ldl_p_lew_bil.v_mat0_deliv_base_core_2
     UNION ALL
     SELECT client_id,
      item_sid,
      dat_formdate,
      loc_sid_store,
      loc_sid_wh,
      deliverytype_id,
      orig_store_nr,
      ROUND(CAST(cy_month AS BIGNUMERIC), 0) AS cy_month,
      sub_item_grp_sid,
      foodaction_fg,
      qty_total_del,
      val_rtl_rl_del,
      val_rtl_rl_net_del,
      qty_piece_del_agg,
      val_piece_del,
      val_piece_net_del,
      val_pr_diff_del,
      val_pr_diff_net_del,
      src_fg
     FROM ldl_p_lew_bil.v_mat0_wawi_mov_item_delivery_2
     UNION ALL
     SELECT client_id,
      item_sid,
      dat_formdate,
      loc_sid_store,
      loc_sid_wh,
      deliverytype_id,
      orig_store_nr,
      ROUND(CAST(cy_month AS BIGNUMERIC), 0) AS cy_month,
      sub_item_grp_sid,
      foodaction_fg,
      qty_total_del,
      val_rtl_rl_del,
      val_rtl_rl_net_del,
      qty_piece_del,
      val_piece_del,
      val_piece_net_del,
      val_pr_diff_del,
      val_pr_diff_net_del,
      src_fg
     FROM ldl_p_lew_bil.v_mat0_wawi_mov_item_dir_delivery_2
     UNION ALL
     SELECT client_id,
      item_sid,
      dat_formdate,
      loc_sid_store,
      loc_sid_wh,
      deliverytype_id,
      orig_store_nr,
      ROUND(CAST(cy_month AS BIGNUMERIC), 0) AS cy_month,
      sub_item_grp_sid,
      foodaction_fg,
      qty_total_del,
      val_rtl_rl_del,
      val_rtl_rl_net_del,
      qty_piece_del_agg,
      val_piece_del,
      val_piece_net_del,
      val_pr_diff_del,
      val_pr_diff_net_del,
      src_fg
     FROM ldl_p_lew_bil.v_mat0_wawi_mov_item_fv_delivery_2) AS a
  GROUP BY client_id,
   item_sid,
   dat_formdate,
   loc_sid_store,
   deliverytype_id) AS b
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_merge_act_2 AS ASPECT1 ON b.client_id = ASPECT1.client_id AND b.loc_sid_store
     = ASPECT1.st_loc_sid AND ASPECT1.aspect_id = 1
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS ALL_ASPECT1 ON ASPECT1.aspect_id = ALL_ASPECT1.aspect_id
   AND ASPECT1.client_id = ALL_ASPECT1.client_id AND ASPECT1.move_to_st_loc_sid = ALL_ASPECT1.move_to_st_loc_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_merge_act_2 AS ASPECT2 ON b.client_id = ASPECT2.client_id AND b.loc_sid_store
     = ASPECT2.st_loc_sid AND ASPECT2.aspect_id = 2
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS ALL_ASPECT2 ON ASPECT2.aspect_id = ALL_ASPECT2.aspect_id
   AND ASPECT2.client_id = ALL_ASPECT2.client_id AND ASPECT2.move_to_st_loc_sid = ALL_ASPECT2.move_to_st_loc_sid;