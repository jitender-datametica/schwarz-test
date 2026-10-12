CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STR_DAY_CAL_ITM_SFO_ASIS_2 as
     SELECT
        a.client_id,
     a.loc_sid_store                          AS store_id,
     a.src_orig_store_nr                      AS orig_store_nr,
     a.booking_dat dat_formdate,
     a.cy_week,
     a.cy_month,
     itmp.item_sid_map                        AS item_id,
     a.sfotype_id,
     a.pcwo_reason_id,
     a.sfo_total_qty_asis                     AS qty_total_sfo_asis,
     a.sfo_wrtoff_zero_qty_asis               AS qty_total_sfo_wrtoff_zero_asis,
     a.sfo_total_rtl_rl_val_asis              AS val_rtl_rcptline_sfo_asis,
     a.sfo_total_rtl_rl_net_val_asis          AS val_rtl_rl_net_sfo_asis,
     a.sfo_wrtoff_zero_rtl_rl_val_asis        AS val_wrtoff_zero_asis,
     a.sfo_wrtoff_zero_rtl_rl_net_val_asis    AS val_wrtoff_zero_net_asis,
     a.price_wh_sfo_asis,
     a.price_wh_net_sfo_asis,
     a.price_str_sfo_asis,
     a.price_str_net_sfo_asis,
     a.val_pr_diff_sfo_asis                   AS val_pr_diff_sfo_asis,
     a.val_pr_diff_net_sfo_asis               AS val_pr_diff_net_sfo_asis,
     a.sfo_total_fa_qty_asis                  AS qty_total_fa_sfo_asis,
     a.sfo_wrtoff_zero_fa_qty_asis            AS qty_tot_sfo_wrtoff_zr_fa_asis,
     a.sfo_total_rtl_rl_fa_val_asis           AS val_rtl_rcptline_fa_sfo_asis,
     a.sfo_total_rtl_rl_net_fa_val_asis       AS val_rtl_rl_net_fa_sfo_asis,
     a.sfo_wrtoff_zero_rtl_rl_fa_val_asis     AS val_wrtoff_zero_fa_asis,
     a.sfo_wrtoff_zero_rtl_rl_net_fa_val_asis AS val_wrtoff_zero_net_fa_asis,
     a.price_wh_fa_sfo_asis,
     a.price_wh_net_fa_sfo_asis,
     a.price_str_fa_sfo_asis,
     a.price_str_net_fa_sfo_asis,
     a.val_pr_diff_fa_sfo_asis                AS val_pr_diff_fa_sfo_asis,
     a.val_pr_diff_net_fa_sfo_asis            AS val_pr_diff_net_fa_sfo_asis,
     a.curr_cd_from                           AS currency_iso_cd,
     a.src_fg
     FROM p_lew_bil_ac.v_agg_str_day_cal_itm_sfo_asis_2 a
     INNER JOIN p_lew_core_ac.v_item_map_key_2 itmp
     ON itmp.client_id = a.client_id
     AND itmp.item_sid = a.item_sid
;