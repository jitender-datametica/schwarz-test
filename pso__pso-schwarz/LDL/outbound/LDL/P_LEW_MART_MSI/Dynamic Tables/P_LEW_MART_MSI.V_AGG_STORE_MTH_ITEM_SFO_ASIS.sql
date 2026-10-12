CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_agg_store_mth_item_sfo_asis AS
SELECT SFO.client_id,
 SFO.loc_sid_store AS store_id,
 SFO.src_orig_store_nr AS orig_store_nr,
 SFO.cy_month AS month_id,
 ITMP.item_sid_map AS item_id,
 SFO.sfotype_id,
 SFO.pcwo_reason_id,
 SUM(SFO.sfo_total_qty_asis) AS qty_total_sfo_asis,
 SUM(CASE
   WHEN SFO.sfotype_id IN (182, 192) AND SFO.pcwo_reason_id IN (21, 23, 24, 22, 126, 28, 27, 26, 132, 29, 31, 103, 104,
        123, 124, 30, 105, 106, 107, 108, 109, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 125, 133, 25, 112, 138
        , 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 153, 154, 156, 157) OR SFO.sfotype_id IN (137, 147
        ) AND SFO.pcwo_reason_id IN (2, 9, 10, 11, 128, 1, 127, 134, 135, 5, 3, 7, 130, 131, 4, 101, 102, 110, 111, 129
        , 8, 136, 137, 152, 155) OR SFO.sfotype_id IN (181, 191) AND SFO.pcwo_reason_id IN (82, 83, 84)
   THEN SFO.sfo_total_qty_asis
   ELSE NULL
   END) AS qty_total_wtof_sfo_asis,
 SUM(SFO.sfo_wrtoff_zero_qty_asis) AS qty_total_sfo_wrtoff_zero_asis,
 SUM(SFO.sfo_total_rtl_rl_val_asis / CRY.exchange_rate) AS val_rtl_rcptline_sfo_asis,
 SUM(SFO.sfo_total_rtl_rl_net_val_asis / CRY.exchange_rate) AS val_rtl_rl_net_sfo_asis,
 SUM(SFO.sfo_wrtoff_zero_rtl_rl_val_asis / CRY.exchange_rate) AS val_wrtoff_zero_asis,
 SUM(SFO.sfo_wrtoff_zero_rtl_rl_net_val_asis / CRY.exchange_rate) AS val_wrtoff_zero_net_asis,
 SUM(SFO.val_pr_diff_sfo_asis / CRY.exchange_rate) AS val_pr_diff_sfo_asis,
 SUM(SFO.val_pr_diff_net_sfo_asis / CRY.exchange_rate) AS val_pr_diff_net_sfo_asis,
 SUM(SFO.sfo_total_fa_qty_asis) AS qty_total_fa_sfo_asis,
 SUM(SFO.sfo_wrtoff_zero_fa_qty_asis) AS qty_tot_sfo_wrtoff_zr_fa_asis,
 SUM(SFO.sfo_total_rtl_rl_fa_val_asis / CRY.exchange_rate) AS val_rtl_rcptline_fa_sfo_asis,
 SUM(SFO.sfo_total_rtl_rl_net_fa_val_asis / CRY.exchange_rate) AS val_rtl_rl_net_fa_sfo_asis,
 SUM(SFO.sfo_wrtoff_zero_rtl_rl_fa_val_asis / CRY.exchange_rate) AS val_wrtoff_zero_fa_asis,
 SUM(SFO.sfo_wrtoff_zero_rtl_rl_net_fa_val_asis / CRY.exchange_rate) AS val_wrtoff_zero_net_fa_asis,
 SUM(SFO.val_pr_diff_fa_sfo_asis / CRY.exchange_rate) AS val_pr_diff_fa_sfo_asis,
 SUM(SFO.val_pr_diff_net_fa_sfo_asis / CRY.exchange_rate) AS val_pr_diff_net_fa_sfo_asis,
 CRY.curr_cd_from AS currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_store_day_item_sfo_asis AS SFO
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON SFO.client_id = ITMP.client_id AND SFO.item_sid = ITMP.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS CRY ON SFO.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE'
GROUP BY SFO.client_id,
 store_id,
 orig_store_nr,
 month_id,
 item_id,
 SFO.sfotype_id,
 SFO.pcwo_reason_id,
 currency_iso_cd;