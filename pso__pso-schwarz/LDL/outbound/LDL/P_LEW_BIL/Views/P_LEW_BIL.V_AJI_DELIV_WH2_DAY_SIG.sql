CREATE OR REPLACE VIEW ldl_p_lew_bil.v_aji_deliv_wh2_day_sig AS SELECT client_id,
 loc_sid_wh_aspect2_asis,
 sub_item_grp_sid_asis,
 dat_formdate,
 cy_month,
 deliverytype_id,
 CAST(SUM(qty_total_del) AS BIGNUMERIC) AS qty_total_del,
 CAST(SUM(val_rtl_rl_del) AS BIGNUMERIC) AS val_rtl_rl_del,
 CAST(SUM(val_rtl_rl_net_del) AS BIGNUMERIC) AS val_rtl_rl_net_del,
 CAST(SUM(qty_piece_del_agg) AS BIGNUMERIC) AS qty_piece_del,
 CAST(SUM(val_piece_del) AS BIGNUMERIC) AS val_piece_del,
 CAST(SUM(val_piece_net_del) AS BIGNUMERIC) AS val_piece_net_del,
 ROUND(CAST(SUM(val_pr_diff_del) AS BIGNUMERIC), 5) AS val_pr_diff_del,
 ROUND(CAST(SUM(val_pr_diff_net_del) AS BIGNUMERIC), 5) AS val_pr_diff_net_del,
 CAST(SUM(CASE
    WHEN foodaction_fg = 1 AND qty_total_del IS NOT NULL
    THEN qty_total_del
    WHEN src_fg = 1
    THEN 0
    ELSE NULL
    END) AS BIGNUMERIC) AS qty_total_fa_del,
 CAST(SUM(CASE
    WHEN foodaction_fg = 1 AND val_rtl_rl_del IS NOT NULL
    THEN val_rtl_rl_del
    WHEN src_fg = 1
    THEN 0
    ELSE NULL
    END) AS BIGNUMERIC) AS val_rtl_rl_fa_del,
 CAST(SUM(CASE
    WHEN foodaction_fg = 1 AND val_rtl_rl_net_del IS NOT NULL
    THEN val_rtl_rl_net_del
    WHEN src_fg = 1
    THEN 0
    ELSE NULL
    END) AS BIGNUMERIC) AS val_rtl_rl_net_fa_del,
 CAST(SUM(CASE
    WHEN foodaction_fg = 1 AND qty_piece_del_agg IS NOT NULL
    THEN qty_piece_del_agg
    WHEN src_fg = 1
    THEN 0
    ELSE NULL
    END) AS BIGNUMERIC) AS qty_piece_fa_del,
 CAST(SUM(CASE
    WHEN foodaction_fg = 1 AND val_piece_del IS NOT NULL
    THEN val_piece_del
    WHEN src_fg = 1
    THEN 0
    ELSE NULL
    END) AS BIGNUMERIC) AS val_piece_fa_del,
 CAST(SUM(CASE
    WHEN foodaction_fg = 1 AND val_piece_net_del IS NOT NULL
    THEN val_piece_net_del
    WHEN src_fg = 1
    THEN 0
    ELSE NULL
    END) AS BIGNUMERIC) AS val_piece_net_fa_del,
 CAST(SUM(CASE
    WHEN foodaction_fg = 1
    THEN val_pr_diff_del
    ELSE NULL
    END) AS BIGNUMERIC) AS val_pr_diff_fa_del,
 CAST(SUM(CASE
    WHEN foodaction_fg = 1
    THEN val_pr_diff_net_del
    ELSE NULL
    END) AS BIGNUMERIC) AS val_pr_diff_net_fa_del
FROM ldl_p_lew_bil.t_agg_deliv_base AS A
GROUP BY client_id,
 loc_sid_wh_aspect2_asis,
 sub_item_grp_sid_asis,
 dat_formdate,
 cy_month,
 deliverytype_id;