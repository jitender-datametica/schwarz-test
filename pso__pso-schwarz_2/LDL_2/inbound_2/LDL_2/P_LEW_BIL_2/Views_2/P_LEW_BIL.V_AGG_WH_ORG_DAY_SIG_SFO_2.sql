CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_WH_ORG_DAY_SIG_SFO_2 as
   SELECT
      client_id,
   loc_sid_wh_aspect1_asis               AS loc_sid_wh,
   1::BYTEINT                      AS aspect_id  -- Amend from Max(1) PatchNo: 2383 (ver 1.2)
   ,
   booking_dat,
   cy_month,
   sub_item_grp_sid_asis                 AS sub_item_grp_sid,
   sfotype_id,
   Sum(sfo_total_qty)                    AS sfo_total_qty,
   Sum(sfo_wrtoff_zero_qty)              AS sfo_wrtoff_zero_qty,
   Sum(sfo_total_rtl_rl_val)             AS sfo_total_rtl_rl_val,
   Sum(sfo_total_rtl_rl_net_val)         AS sfo_total_rtl_rl_net_val,
   Sum(sfo_wrtoff_zero_rtl_rl_val)       AS sfo_wrtoff_zero_rtl_rl_val,
   Sum(sfo_wrtoff_zero_rtl_rl_net_val)   AS sfo_wrtoff_zero_rtl_rl_net_val,
   Sum(val_pr_diff_sfo)                  AS val_pr_diff_sfo,
   Sum(val_pr_diff_net_sfo)              AS val_pr_diff_net_sfo,
   Sum(sfo_total_qty)                    AS sfo_total_fa_qty,
   Sum(sfo_wrtoff_zero_qty)              AS sfo_wrtoff_zero_fa_qty,
   Sum(sfo_total_rtl_rl_val)             AS sfo_total_rtl_rl_fa_val,
   Sum(sfo_total_rtl_rl_net_val)         AS sfo_total_rtl_rl_net_fa_val,
   Sum(sfo_wrtoff_zero_rtl_rl_val)       AS sfo_wrtoff_zero_rtl_rl_fa_val,
   Sum(sfo_wrtoff_zero_rtl_rl_net_val)   AS sfo_wrtoff_zero_rtl_rl_net_fa_val,
   Sum(val_pr_diff_sfo)                  AS val_pr_diff_fa_sfo,
   Sum(val_pr_diff_net_sfo)              AS val_pr_diff_net_fa_sfo
   FROM p_lew_bil.t_agg_store_day_item_sfo_2 sfo
   WHERE aspect_id = 1 -- New for PatchNo: 2383 (ver 1.2)
   GROUP BY
      client_id
     ,loc_sid_wh
     ,booking_dat
     ,cy_month
     ,sub_item_grp_sid
     ,sfotype_id

   UNION ALL

   SELECT
      client_id,
   loc_sid_wh_aspect2_asis               AS loc_sid_wh,
   2::BYTEINT                      AS aspect_id  -- Amend from Max(2) PatchNo: 2383 (ver 1.2)
   ,
   booking_dat,
   cy_month,
   sub_item_grp_sid_asis                 AS sub_item_grp_sid,
   sfotype_id,
   Sum(sfo_total_qty)                    AS sfo_total_qty,
   Sum(sfo_wrtoff_zero_qty)              AS sfo_wrtoff_zero_qty,
   Sum(sfo_total_rtl_rl_val)             AS sfo_total_rtl_rl_val,
   Sum(sfo_total_rtl_rl_net_val)         AS sfo_total_rtl_rl_net_val,
   Sum(sfo_wrtoff_zero_rtl_rl_val)       AS sfo_wrtoff_zero_rtl_rl_val,
   Sum(sfo_wrtoff_zero_rtl_rl_net_val)   AS sfo_wrtoff_zero_rtl_rl_net_val,
   Sum(val_pr_diff_sfo)                  AS val_pr_diff_sfo,
   Sum(val_pr_diff_net_sfo)              AS val_pr_diff_net_sfo,
   Sum(sfo_total_qty)                    AS sfo_total_fa_qty,
   Sum(sfo_wrtoff_zero_qty)              AS sfo_wrtoff_zero_fa_qty,
   Sum(sfo_total_rtl_rl_val)             AS sfo_total_rtl_rl_fa_val,
   Sum(sfo_total_rtl_rl_net_val)         AS sfo_total_rtl_rl_net_fa_val,
   Sum(sfo_wrtoff_zero_rtl_rl_val)       AS sfo_wrtoff_zero_rtl_rl_fa_val,
   Sum(sfo_wrtoff_zero_rtl_rl_net_val)   AS sfo_wrtoff_zero_rtl_rl_net_fa_val,
   Sum(val_pr_diff_sfo)                  AS val_pr_diff_fa_sfo,
   Sum(val_pr_diff_net_sfo)              AS val_pr_diff_net_fa_sfo
   FROM p_lew_bil.t_agg_store_day_item_sfo_2 sfo
   WHERE aspect_id = 2 -- New for PatchNo: 2383 (ver 1.2)
   GROUP BY
      client_id
     ,loc_sid_wh
     ,booking_dat
     ,cy_month
     ,sub_item_grp_sid
     ,sfotype_id
   ;