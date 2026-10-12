CREATE OR REPLACE view P_LEW_BIL.V_AGG_DELIV_WH_DAY_ITEM_ASPECT_2 as
   SELECT
     a.client_id,
   wh.src_wh_id,
   a.item_sid,
   a.dat_formdate,
   a.deliverytype_id,
   all_mer.aspect_id,
   Sum(a.qty_total_del)                                                        AS qty_total_del,
   Sum(a.val_rtl_rl_del)                                                       AS val_rtl_rl_del,
   Sum(a.val_rtl_rl_net_del)                                                   AS val_rtl_rl_net_del,
   Sum(a.qty_piece_del_agg)                                                    AS qty_piece_del,
   Sum(a.val_piece_del)                                                        AS val_piece_del,
   Sum(a.val_piece_net_del)                                                    AS val_piece_net_del,
   Sum(a.val_pr_diff_del)                                                      AS val_pr_diff_del,
   Sum(a.val_pr_diff_net_del)                                                  AS val_pr_diff_net_del,
   Sum(CASE WHEN a.foodaction_fg = 1 THEN a.qty_total_del ELSE  NULL END )     AS qty_total_fa_del,
   Sum(CASE WHEN a.foodaction_fg = 1 THEN a.val_rtl_rl_del ELSE NULL END)      AS val_rtl_rl_fa_del,
   Sum(CASE WHEN a.foodaction_fg = 1 THEN a.val_rtl_rl_net_del ELSE NULL END)  AS val_rtl_rl_net_fa_del,
   Sum(CASE WHEN a.foodaction_fg = 1 THEN a.qty_piece_del_agg ELSE NULL END)   AS qty_piece_fa_del,
   Sum(CASE WHEN a.foodaction_fg = 1 THEN a.val_piece_del ELSE NULL END)       AS val_piece_fa_del,
   Sum(CASE WHEN a.foodaction_fg = 1 THEN a.val_piece_net_del ELSE NULL END)   AS val_piece_net_fa_del,
   Sum(CASE WHEN a.foodaction_fg = 1 THEN a.val_pr_diff_del ELSE NULL END)     AS val_pr_diff_fa_del,
   Sum(CASE WHEN a.foodaction_fg = 1 THEN a.val_pr_diff_net_del ELSE NULL END) AS val_pr_diff_net_fa_del
   FROM p_lew_bil.t_agg_deliv_base_2 a
   INNER JOIN p_lew_core_ac.v_wawi_org_store_merge_act_2 mer
   ON  a.client_id = mer.client_id
   AND a.loc_sid_store = mer.st_loc_sid
   INNER JOIN p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS all_mer
   ON  mer.aspect_id = all_mer.aspect_id
   AND mer.client_id = all_mer.client_id
   AND mer.move_to_st_loc_sid = all_mer.move_to_st_loc_sid
   INNER JOIN p_lew_bil.v_warehouse_2 AS wh
   ON  all_mer.client_id = wh.client_id
   AND all_mer.wh_loc_sid = wh.loc_sid_wh
   AND wh.dwh_actual_fg = 1

GROUP BY a.client_id
, wh.src_wh_id
, a.item_sid
, a.dat_formdate
, a.deliverytype_id
, all_mer.aspect_id
   ;