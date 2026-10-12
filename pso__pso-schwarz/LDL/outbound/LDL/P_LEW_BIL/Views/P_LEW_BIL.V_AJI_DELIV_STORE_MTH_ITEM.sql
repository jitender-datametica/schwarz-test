CREATE OR REPLACE VIEW ldl_p_lew_bil.v_aji_deliv_store_mth_item AS SELECT client_id,
 loc_sid_store,
 item_sid,
 cy_month,
 deliverytype_id,
 orig_store_nr,
 SUM(qty_total_del) AS qty_total_del,
 SUM(val_rtl_rl_del) AS val_rtl_rl_del,
 SUM(val_rtl_rl_net_del) AS val_rtl_rl_net_del,
 SUM(qty_piece_del_agg) AS qty_piece_del,
 SUM(val_piece_del) AS val_piece_del,
 SUM(val_piece_net_del) AS val_piece_net_del,
 SUM(val_pr_diff_del) AS val_pr_diff_del,
 SUM(val_pr_diff_net_del) AS val_pr_diff_net_del,
 SUM(CASE
   WHEN foodaction_fg = 1 AND qty_total_del IS NOT NULL
   THEN qty_total_del
   WHEN src_fg = 1
   THEN 0
   ELSE NULL
   END) AS qty_total_fa_del,
 SUM(CASE
   WHEN foodaction_fg = 1 AND val_rtl_rl_del IS NOT NULL
   THEN val_rtl_rl_del
   WHEN src_fg = 1
   THEN 0
   ELSE NULL
   END) AS val_rtl_rl_fa_del,
 SUM(CASE
   WHEN foodaction_fg = 1 AND val_rtl_rl_net_del IS NOT NULL
   THEN val_rtl_rl_net_del
   WHEN src_fg = 1
   THEN 0
   ELSE NULL
   END) AS val_rtl_rl_net_fa_del,
 SUM(CASE
   WHEN foodaction_fg = 1 AND qty_piece_del_agg IS NOT NULL
   THEN qty_piece_del_agg
   WHEN src_fg = 1
   THEN 0
   ELSE NULL
   END) AS qty_piece_fa_del,
 SUM(CASE
   WHEN foodaction_fg = 1 AND val_piece_del IS NOT NULL
   THEN val_piece_del
   WHEN src_fg = 1
   THEN 0
   ELSE NULL
   END) AS val_piece_fa_del,
 SUM(CASE
   WHEN foodaction_fg = 1 AND val_piece_net_del IS NOT NULL
   THEN val_piece_net_del
   WHEN src_fg = 1
   THEN 0
   ELSE NULL
   END) AS val_piece_net_fa_del,
 SUM(CASE
   WHEN foodaction_fg = 1
   THEN val_pr_diff_del
   ELSE NULL
   END) AS val_pr_diff_fa_del,
 SUM(CASE
   WHEN foodaction_fg = 1
   THEN val_pr_diff_net_del
   ELSE NULL
   END) AS val_pr_diff_net_fa_del
FROM ldl_p_lew_bil.t_agg_deliv_base AS A
GROUP BY client_id,
 loc_sid_store,
 item_sid,
 cy_month,
 deliverytype_id,
 orig_store_nr;