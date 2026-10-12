/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.t_msi_ejr_lp_threshold_cumulation
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  17.01.2018    Wieber.Harald            Release 2.2
#  1.3  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.4  31.01.2018    Wieber.Harald            Release 2.3
#  1.5  31.01.2018    Wieber,Harald            Release 2.3
#  1.6  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column return_freq_same_checker
#  1.7  08.12.2021    Wandtke,Andrzej          AP0085915_ZKP_SHOW_PRICE add column PRICE_SSQ_DAYS_QTY_PAST_3M
#  1.8  02.08.2022    Rekovsky,Marvin          AP0105940_ZKP_Pfandbon_manuell+rein: Add columns deposit_noitm_qty_trans_past_3m and deposit_noitm_days_qty_past_3m
#  1.9  17.03.2023    Wandtke,Andrzej          AP0152808 : Add column return_no_receipt_qty
#  2.0  13.04.2023    Wandtke,Andrzej          AP0170366 : Add column return_many_itm_qty
#  2.1  27.03.2024    Szewczyk,Milosz          AP0188368 : Add column plus_days
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation (
client_id BIGNUMERIC(38,0),
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
void_qty_trans_past_3mth NUMERIC(18,4),
void_qty_trans_random_1w NUMERIC(18,4),
susp_qty_trans_past_3mth NUMERIC(18,4),
susp_qty_trans_random_1w NUMERIC(18,4),
return_qty_trans_past_3mth NUMERIC(18,4),
return_freq_same_item_in_1w NUMERIC(18,4),
ret_threshold_qty_week_in_3m NUMERIC(18,4),
return_s2_qty_trans_past_3m NUMERIC(18,4),
return_qty_trans_random_1w NUMERIC(18,4),
deposit_qty_trans_past_3mth NUMERIC(18,4),
deposit_ean_qty_trans_past_3m NUMERIC(18,4),
deposit_noitm_qty_trans_past_3m NUMERIC(18,4),
deposit_noitm_days_qty_past_3m NUMERIC(18,4),
deposit_1itm_qty_trans_past_3m NUMERIC(18,4),
deposit_1itm_qty_trans_rand_1w NUMERIC(18,4),
deposit_amt_qty_trans_past_3m NUMERIC(18,4),
deposit_amt_qty_trans_rand_1w NUMERIC(18,4),
price_ssq_days_qty_past_3m NUMERIC(18,4),
price_ssq_qty_trans_past_3m NUMERIC(18,4),
price_ssq_qty_trans_randm_1w NUMERIC(18,4),
susp_qty_trans_past_3mth_mc NUMERIC(18,4),
susp_qty_trans_random_1w_mc NUMERIC(18,4),
deposit_qty_total_past_3mth NUMERIC(18,4),
price_series_qty_past_3m NUMERIC(18,4),
ret_qty_store_same_rec_past_3m NUMERIC(18,4),
ret_qty_not_authorised_past_3m NUMERIC(18,4),
return_freq_same_checker NUMERIC(18,4),
return_no_receipt_qty NUMERIC(18,4),
return_many_itm_qty NUMERIC(18,4),
plus_days NUMERIC(18,4),
requesting_user STRING(128) COLLATE 'und:ci' DEFAULT SESSION_USER() NOT NULL,
timestamp_request DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
approval_fg BIGNUMERIC(38,0) NOT NULL,
approval_user STRING(128) COLLATE 'und:ci',
timestamp_approval DATETIME,
approval2_user STRING(128) COLLATE 'und:ci',
timestamp_approval2 DATETIME
);