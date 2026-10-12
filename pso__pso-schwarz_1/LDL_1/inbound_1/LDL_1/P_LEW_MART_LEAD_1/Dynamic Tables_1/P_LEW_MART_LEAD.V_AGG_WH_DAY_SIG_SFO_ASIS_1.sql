CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_AGG_WH_DAY_SIG_SFO_ASIS_1
(
    client_id
   ,wh_id
   ,aspect_id
   ,dat_formdate
   ,cy_month
   ,subitemgroup_id
   ,sfotype_id
   ,qty_total_sfo_asis
   ,qty_total_sfo_wrtoff_zero_asis
   ,val_rtl_rl_sfo_asis
   ,val_rtl_rl_net_sfo_asis
   ,val_wrtoff_zero_asis
   ,val_wrtoff_zero_net_asis
   ,val_pr_diff_sfo_asis
   ,val_pr_diff_net_sfo_asis
   ,qty_total_fa_sfo_asis
   ,qty_tot_sfo_wrtoff_zr_fa_asis
   ,val_rtl_rl_fa_sfo_asis
   ,val_rtl_rl_net_fa_sfo_asis
   ,val_wrtoff_zero_fa_asis
   ,val_wrtoff_zero_net_fa_asis
   ,val_pr_diff_fa_sfo_asis
   ,val_pr_diff_net_fa_sfo_asis
   ,currency_iso_cd
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD
AS
   SELECT
      agg.client_id
   ,wh.src_wh_id AS wh_id
   ,agg.aspect_id
   ,agg.booking_dat                            AS dat_formdate
   ,agg.cy_month
   ,agg.subitemgroup_id
   ,agg.sfotype_id
   ,agg.sfo_total_qty_asis                     AS qty_total_sfo_asis
   ,agg.sfo_wrtoff_zero_qty_asis               AS qty_total_sfo_wrtoff_zero_asis
   ,agg.sfo_total_rtl_rl_val_asis              AS val_rtl_rl_sfo_asis
   ,agg.sfo_total_rtl_rl_net_val_asis          AS val_rtl_rl_net_sfo_asis
   ,agg.sfo_wrtoff_zero_rtl_rl_val_asis        AS val_wrtoff_zero_asis
   ,agg.sfo_wrtoff_zero_rtl_rl_net_val_asis    AS val_wrtoff_zero_net_asis
   ,agg.val_pr_diff_sfo_asis
   ,agg.val_pr_diff_net_sfo_asis
   ,agg.sfo_total_fa_qty_asis                  AS qty_total_fa_sfo_asis
   ,agg.sfo_wrtoff_zero_fa_qty_asis            AS qty_tot_sfo_wrtoff_zr_fa_asis
   ,agg.sfo_total_rtl_rl_fa_val_asis           AS val_rtl_rl_fa_sfo_asis
   ,agg.sfo_total_rtl_rl_net_fa_val_asis       AS val_rtl_rl_net_fa_sfo_asis
   ,agg.sfo_wrtoff_zero_rtl_rl_fa_val_asis     AS val_wrtoff_zero_fa_asis
   ,agg.sfo_wrtoff_zero_rtl_rl_net_fa_val_asis AS val_wrtoff_zero_net_fa_asis
   ,agg.val_pr_diff_fa_sfo_asis
   ,agg.val_pr_diff_net_fa_sfo_asis
   ,agg.curr_cd_from                             AS currency_iso_cd
   FROM p_lew_bil_ac.v_agg_wh_org_day_sig_sfo_asis_1 AS agg
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
   ON agg.client_id=wh.client_id
   AND agg.loc_sid_wh=wh.loc_sid_wh
   AND wh.dwh_actual_fg = 1
;