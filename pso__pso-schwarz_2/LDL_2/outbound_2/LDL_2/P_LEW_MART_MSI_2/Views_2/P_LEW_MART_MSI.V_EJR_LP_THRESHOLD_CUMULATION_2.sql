/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_ejr_lp_threshold_cumulation_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  10.11.2017    Toth,Gabriel             Changed to match the coex counterpart
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  11.01.2018    Meister,Ulrich           CROSS JOIN adjusted from LEFT OUTER to INNER
#  1.4  17.01.2018    Wieber,Harald            Release 2.2
#  1.5  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column return_freq_same_checker
#  1.6  08.12.2021    Wandtke,Andrzej          AP0085915_ZKP_SHOW_PRICE add column PRICE_SSQ_DAYS_QTY_PAST_3M
#  1.7  02.08.2022    Rekovsky,Marvin          AP0105940_ZKP_Pfandbon_manuell+rein: Add columns deposit_noitm_qty_trans_past_3m and deposit_noitm_days_qty_past_3m
#  1.8  17.03.2023    Wandtke,Andrzej          AP0152808 : Add column return_no_receipt_qty
#  1.9  13.04.2023    Wandtke,Andrzej          AP0170366 : Add column return_many_itm_qty
#  2.0  12.03.2024    Szewczyk,Milosz          AP0188368 : Add column plus_days
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_lp_threshold_cumulation_2 (client_id, void_qty_trans_past_3mth,
void_qty_trans_random_1w, susp_qty_trans_past_3mth, susp_qty_trans_random_1w, return_qty_trans_past_3mth,
return_freq_same_item_in_1w, ret_threshold_qty_week_in_3m, return_s2_qty_trans_past_3m, return_qty_trans_random_1w,
deposit_qty_trans_past_3mth, deposit_ean_qty_trans_past_3m, deposit_noitm_qty_trans_past_3m,
deposit_noitm_days_qty_past_3m, deposit_1itm_qty_trans_past_3m, deposit_1itm_qty_trans_rand_1w,
deposit_amt_qty_trans_past_3m, deposit_amt_qty_trans_rand_1w, price_ssq_days_qty_past_3m, price_ssq_qty_trans_past_3m,
price_ssq_qty_trans_randm_1w, susp_qty_trans_past_3mth_mc, susp_qty_trans_random_1w_mc, deposit_qty_total_past_3mth,
price_series_qty_past_3m, ret_qty_store_same_rec_past_3m, ret_qty_not_authorised_past_3m, return_freq_same_checker,
return_no_receipt_qty, return_many_itm_qty, plus_days, store_id, checker_id) AS SELECT TC.client_id,
 TC.void_qty_trans_past_3mth,
 TC.void_qty_trans_random_1w,
 TC.susp_qty_trans_past_3mth,
 TC.susp_qty_trans_random_1w,
 TC.return_qty_trans_past_3mth,
 TC.return_freq_same_item_in_1w,
 TC.ret_threshold_qty_week_in_3m,
 TC.return_s2_qty_trans_past_3m,
 TC.return_qty_trans_random_1w,
 TC.deposit_qty_trans_past_3mth,
 TC.deposit_ean_qty_trans_past_3m,
 TC.deposit_noitm_qty_trans_past_3m,
 TC.deposit_noitm_days_qty_past_3m,
 TC.deposit_1itm_qty_trans_past_3m,
 TC.deposit_1itm_qty_trans_rand_1w,
 TC.deposit_amt_qty_trans_past_3m,
 TC.deposit_amt_qty_trans_rand_1w,
 TC.price_ssq_days_qty_past_3m,
 TC.price_ssq_qty_trans_past_3m,
 TC.price_ssq_qty_trans_randm_1w,
 TC.susp_qty_trans_past_3mth_mc,
 TC.susp_qty_trans_random_1w_mc,
 TC.deposit_qty_total_past_3mth,
 TC.price_series_qty_past_3m,
 TC.ret_qty_store_same_rec_past_3m,
 TC.ret_qty_not_authorised_past_3m,
 TC.return_freq_same_checker,
 TC.return_no_receipt_qty,
 TC.return_many_itm_qty,
 TC.plus_days,
 CHK.store_id,
 CHK.checker_id
FROM ldl_p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_2 AS TC
 INNER JOIN ldl_p_lew_mart_msi.v_ejr_org_checker_2 AS CHK ON TC.client_id = CHK.client_id
WHERE CURRENT_DATE BETWEEN TC.dat_rec_start AND TC.dat_rec_end
 AND TC.approval_fg = 1;