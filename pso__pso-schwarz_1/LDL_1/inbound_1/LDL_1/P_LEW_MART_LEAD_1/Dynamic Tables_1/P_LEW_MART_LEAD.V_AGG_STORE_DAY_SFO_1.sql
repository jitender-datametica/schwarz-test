CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_AGG_STORE_DAY_SFO_1
(
      client_id
      ,store_id
      ,orig_store_nr
      ,dat_formdate
      ,cy_month
      ,sfotype_id
      ,pcwo_reason_id
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
      ,currency_iso_cd_asis
)
TARGET_LAG = '1 hour, 30 minutes'  -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD
AS
  SELECT
      agg.client_id
      ,agg.loc_sid_store                                              AS store_id
      ,agg.src_orig_store_nr                                          AS orig_store_nr
      ,agg.booking_dat                                                AS dat_formdate
      ,agg.cy_month
      ,agg.sfotype_id
      ,agg.pcwo_reason_id
      ,agg.sfo_total_qty_asis                                         AS qty_total_sfo_asis
      ,agg.sfo_wrtoff_zero_qty_asis                                   AS qty_total_sfo_wrtoff_zero_asis
      ,agg.sfo_total_rtl_rl_val_asis / cry.exchange_rate              AS val_rtl_rl_sfo_asis
      ,agg.sfo_total_rtl_rl_net_val_asis / cry.exchange_rate          AS val_rtl_rl_net_sfo_asis
      ,agg.sfo_wrtoff_zero_rtl_rl_val_asis / cry.exchange_rate        AS val_wrtoff_zero_asis
      ,agg.sfo_wrtoff_zero_rtl_rl_net_val_asis / cry.exchange_rate    AS val_wrtoff_zero_net_asis
      ,agg.val_pr_diff_sfo_asis / cry.exchange_rate                   AS val_pr_diff_sfo_asis
      ,agg.val_pr_diff_net_sfo_asis / cry.exchange_rate               AS val_pr_diff_net_sfo_asis
      ,agg.sfo_total_fa_qty_asis                                      AS qty_total_fa_sfo_asis
      ,agg.sfo_wrtoff_zero_fa_qty_asis                                AS qty_tot_sfo_wrtoff_zr_fa_asis
      ,agg.sfo_total_rtl_rl_fa_val_asis / cry.exchange_rate           AS val_rtl_rl_fa_sfo_asis
      ,agg.sfo_total_rtl_rl_net_fa_val_asis / cry.exchange_rate       AS val_rtl_rl_net_fa_sfo_asis
      ,agg.sfo_wrtoff_zero_rtl_rl_fa_val_asis / cry.exchange_rate     AS val_wrtoff_zero_fa_asis
      ,agg.sfo_wrtoff_zero_rtl_rl_net_fa_val_asis / cry.exchange_rate AS val_wrtoff_zero_net_fa_asis
      ,agg.val_pr_diff_fa_sfo_asis / cry.exchange_rate                AS val_pr_diff_fa_sfo_asis
      ,agg.val_pr_diff_net_fa_sfo_asis / cry.exchange_rate            AS val_pr_diff_net_fa_sfo_asis
      ,cry.curr_cd_from                                               AS currency_iso_cd_asis
   FROM p_lew_bil_ac.v_agg_store_day_sfo_1 agg
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
   ON agg.client_id = cry.client_id
   AND Current_Date BETWEEN cry.active_from_dt AND cry.active_to_dt
   AND Current_Date BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 c
   ON c.client_id = cry.client_id
   AND c.x_rate_type_sid = cry.x_rate_type_sid
   AND c.src_kurst = '@BEWE'
;