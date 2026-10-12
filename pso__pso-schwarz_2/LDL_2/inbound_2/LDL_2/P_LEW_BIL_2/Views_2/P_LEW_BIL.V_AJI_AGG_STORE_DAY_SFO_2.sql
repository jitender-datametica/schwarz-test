CREATE OR REPLACE VIEW P_LEW_BIL.V_AJI_AGG_STORE_DAY_SFO_2 as
   /*
   #DescStart#
   #$Revision: 7759 $, $LastChangedBy: mueding $
   #SubjectAreas#: WAWI, SAP; Kleinbelege / Storeforms
   #DescEnd#
   */
   SELECT
      client_id,
   loc_sid_store,
   src_orig_store_nr,
   booking_dat,
   cy_month,
   sfotype_id,
   pcwo_reason_id,
   Sum(sfo_total_qty)                                                                 AS sfo_total_qty_asis,
   Sum(sfo_wrtoff_zero_qty)                                                           AS sfo_wrtoff_zero_qty_asis,
   Sum(sfo_total_rtl_rl_val)                                                          AS sfo_total_rtl_rl_val_asis,
   Sum(sfo_total_rtl_rl_net_val)                                                      AS sfo_total_rtl_rl_net_val_asis,
   Sum(sfo_wrtoff_zero_rtl_rl_val)                                                    AS sfo_wrtoff_zero_rtl_rl_val_asis,
   Sum(sfo_wrtoff_zero_rtl_rl_net_val)                                                AS sfo_wrtoff_zero_rtl_rl_net_val_asis,
   Sum(val_pr_diff_sfo)                                                               AS val_pr_diff_sfo_asis,
   Sum(val_pr_diff_net_sfo)                                                           AS val_pr_diff_net_sfo_asis,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_total_qty ELSE NULL END)                  AS sfo_total_fa_qty_asis,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_wrtoff_zero_qty ELSE NULL END)            AS sfo_wrtoff_zero_fa_qty_asis,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_total_rtl_rl_val ELSE NULL END)           AS sfo_total_rtl_rl_fa_val_asis,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_total_rtl_rl_net_val ELSE NULL END)       AS sfo_total_rtl_rl_net_fa_val_asis,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_wrtoff_zero_rtl_rl_val ELSE NULL END)     AS sfo_wrtoff_zero_rtl_rl_fa_val_asis,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN sfo_wrtoff_zero_rtl_rl_net_val ELSE NULL END) AS sfo_wrtoff_zero_rtl_rl_net_fa_val_asis,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN val_pr_diff_sfo ELSE NULL END)                AS val_pr_diff_fa_sfo_asis,
   Sum(CASE WHEN foodaction_fg_asis = 1 THEN val_pr_diff_net_sfo ELSE NULL END)            AS val_pr_diff_net_fa_sfo_asis,
   Cast(Current_Timestamp AS TIMESTAMP)                                            AS timestamp_mod
   FROM p_lew_bil.t_agg_store_day_item_sfo_2 AS agg

   GROUP BY
      client_id
     ,loc_sid_store
     ,src_orig_store_nr
     ,booking_dat
     ,cy_month
     ,sfotype_id
     ,pcwo_reason_id
;