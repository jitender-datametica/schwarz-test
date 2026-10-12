CREATE OR REPLACE VIEW P_LEW_BIL.V_AJI_DELIV_STORE_DAY_ITEM_1 as

   /*
   #DescStart#
   #$Revision: 6283 $, $LastChangedBy: hwieber $
   #SubjectAreas#: Anliefermenge
   #DescEnd#
   */
   SELECT
     a.client_id,
   a.loc_sid_store,
   a.item_sid,
   a.dat_formdate,
   a.cy_month,
   a.deliverytype_id,
   a.orig_store_nr,
   a.foodaction_fg,
   SUM(a.qty_total_del)                           AS qty_total_del,
   SUM(a.val_rtl_rl_del)                          AS val_rtl_rl_del,
   SUM(a.val_rtl_rl_net_del)                      AS val_rtl_rl_net_del,
   SUM(a.qty_piece_del_agg)                       AS qty_piece_del,
   SUM(a.val_piece_del)                           AS val_piece_del,
   SUM(a.val_piece_net_del)                       AS val_piece_net_del,
   SUM(a.val_pr_diff_del)                         AS val_pr_diff_del,
   SUM(a.val_pr_diff_net_del)                     AS val_pr_diff_net_del
   FROM p_lew_bil.t_agg_deliv_base_1 a
   GROUP BY 1,2,3,4,5,6,7,8;