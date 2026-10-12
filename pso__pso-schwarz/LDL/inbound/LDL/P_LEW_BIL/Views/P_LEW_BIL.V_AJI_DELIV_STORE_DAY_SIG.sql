CREATE OR REPLACE VIEW P_LEW_BIL.V_AJI_DELIV_STORE_DAY_SIG as

   /*
   DescStart
   $Revision: 7235 $, $LastChangedBy: mmurtenthaler $
   SubjectAreas: Anliefermenge
   DescEnd
   */
   SELECT
     a.client_id,
   a.loc_sid_store,
   a.sub_item_grp_sid_asis,
   a.dat_formdate,
   a.deliverytype_id,
   a.orig_store_nr,
   SUM(a.qty_total_del)       AS qty_total_del,
   SUM(a.val_rtl_rl_del)      AS val_rtl_rl_del,
   SUM(a.val_rtl_rl_net_del)  AS val_rtl_rl_net_del,
   SUM(a.qty_piece_del_agg)   AS qty_piece_del,
   SUM(a.val_piece_del)       AS val_piece_del,
   SUM(a.val_piece_net_del)   AS val_piece_net_del,
   SUM(a.val_pr_diff_del)     AS val_pr_diff_del,
   SUM(a.val_pr_diff_net_del) AS val_pr_diff_net_del,
   SUM(CASE WHEN a.foodaction_fg = 1 AND a.qty_total_del       IS NOT NULL THEN a.qty_total_del
              WHEN a.src_fg = 1                                              THEN 0
                                                                             ELSE NULL
         END) AS qty_total_fa_del,
   SUM(CASE WHEN a.foodaction_fg = 1 AND a.val_rtl_rl_del      IS NOT NULL THEN a.val_rtl_rl_del
              WHEN a.src_fg = 1                                              THEN 0
                                                                             ELSE NULL
         END) AS val_rtl_rl_fa_del,
   SUM(CASE WHEN a.foodaction_fg = 1 AND a.val_rtl_rl_net_del  IS NOT NULL THEN a.val_rtl_rl_net_del
              WHEN a.src_fg = 1                                              THEN 0
                                                                             ELSE NULL
         END) AS val_rtl_rl_net_fa_del,
   SUM(CASE WHEN a.foodaction_fg = 1 AND a.qty_piece_del_agg   IS NOT NULL THEN a.qty_piece_del_agg
              WHEN a.src_fg = 1                                              THEN 0
                                                                             ELSE NULL
         END) AS qty_piece_fa_del,
   SUM(CASE WHEN a.foodaction_fg = 1 AND a.val_piece_del       IS NOT NULL THEN a.val_piece_del
              WHEN a.src_fg = 1                                              THEN 0
                                                                             ELSE NULL
         END) AS val_piece_fa_del,
   SUM(CASE WHEN a.foodaction_fg = 1 AND a.val_piece_net_del   IS NOT NULL THEN a.val_piece_net_del
              WHEN a.src_fg = 1                                              THEN 0
                                                                             ELSE NULL
         END) AS val_piece_net_fa_del,
   SUM(CASE WHEN a.foodaction_fg = 1 THEN a.val_pr_diff_del
         END) AS val_pr_diff_fa_del,
   SUM(CASE WHEN a.foodaction_fg = 1 THEN a.val_pr_diff_net_del
         END) AS val_pr_diff_net_fa_del
   FROM p_lew_bil.t_agg_deliv_base a
   GROUP BY 1,2,3,4,5,6
;