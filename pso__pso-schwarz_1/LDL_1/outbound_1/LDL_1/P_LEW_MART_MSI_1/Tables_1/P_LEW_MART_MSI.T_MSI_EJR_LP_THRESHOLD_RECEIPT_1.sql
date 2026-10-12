/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.t_msi_ejr_lp_threshold_receipt_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  17.01.2018    Wieber.Harald            Release 2.2
#  1.3  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.4  31.01.2018    Wieber.Harald            Release 2.3
#  1.5  31.01.2018    Wieber,Harald            Release 2.3
#  1.6  24.04.2018    Wandtke,Andrzej          20180419_1646_ZKP_Creation_Threshold_Team1 Add 2 columns
#  1.7  21.10.2019    Morris, Michael          20191021_2259_ZKP_BBT_272_398 (Jira: LEAD-7462): New Attribute susp_subseqent_trans_low_val_mc
#  1.8  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column return_same_checker_val
#  1.9  24.05.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: Add column void_1itm_receipt_val
#  2.0  02.08.2022    Rekovsky,Marvin          AP0105940_ZKP_Pfandbon_manuell+rein: Add column deposit_noitm_tot_val 
#  2.1  17.03.2023    Wandtke,Andrzej          AP0152808 : Add column return_no_receipt_val
#  2.2  13.04.2023    Wandtke,Andrzej          AP0170366 : Add columns return_many_itm_cnt, return_many_itm_val
#  2.3  28.08.2023    Kowalik,Aleksander       AP0177990 : Add columns return_same_checker_val_ebb_m number, return_same_checker_val_ebb_l
#  2.4  11.01.2024    Szewczyk,Milosz          AP0182639 : Add columns void_itm_cnt, void_tot_val_cnt, void_tot_itm_in_receipt, void_receipt_cnt, void_1itm_receipt_val_2
#  2.5  27.03.2024    Szewczyk,Milosz          AP0188368 : Add columns plus_rec_month, plus_rec_day
#  2.6  22.04.2024    Kowalik,Aleksander       AP0198132 : Add columns susp_aborted (x3) for Bonabbruch AP
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt_1 (
client_id INTEGER,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
void_tot_val_aft_subtot NUMERIC(18,4),
susp_tot_val NUMERIC(18,4),
susp_subsequent_trans_low_val NUMERIC(18,4),
susp_voided_exp_last_void_val NUMERIC(18,4),
return_item_price NUMERIC(18,4),
return_tot_val NUMERIC(18,4),
return_value NUMERIC(18,4),
return_tot_val_nf NUMERIC(18,4),
deposit_scanned_value NUMERIC(18,4),
deposit_scanned_qty_integer NUMERIC(18,4),
deposit_1itm_plus_empty_ret NUMERIC(18,4),
deposit_amt_plus_empty_ret NUMERIC(18,4),
price_subseq_trans_low_val NUMERIC(18,4),
susp_voided_exp_last_void_val2 NUMERIC(18,4),
deposit_1itm_receipt_val NUMERIC(18,4),
deposit_1itm_item_val NUMERIC(18,4),
deposit_noitm_tot_val NUMERIC(18,4),
price_series_receipt_cnt NUMERIC(18,4),
price_series_receipt_total_val NUMERIC(18,4),
return_same_receipt_qty NUMERIC(18,4),
return_same_receipt_val NUMERIC(18,4),
return_not_authorised_val NUMERIC(18,4),
return_not_authorised_val2 NUMERIC(18,4),
price_subseq_trans_low_val2 NUMERIC(18,4),
susp_subseqent_trans_low_val_mc NUMERIC(18,4),
return_same_checker_val NUMERIC(18,4),
void_1itm_receipt_val NUMERIC(18,4),
return_no_receipt_val NUMERIC(18,4),
return_many_itm_cnt NUMERIC(18,4),
return_many_itm_val NUMERIC(18,4),
requesting_user STRING(128) COLLATE 'und:ci' DEFAULT SESSION_USER() NOT NULL,
timestamp_request DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL,
approval_fg INTEGER NOT NULL,
approval_user STRING(128) COLLATE 'und:ci',
timestamp_approval DATETIME,
approval2_user STRING(128) COLLATE 'und:ci',
timestamp_approval2 DATETIME,
return_same_checker_val_ebb_m NUMERIC(18,4),
return_same_checker_val_ebb_l NUMERIC(18,4),
void_itm_cnt NUMERIC(18,4),
void_tot_val_cnt NUMERIC(18,4),
void_tot_itm_in_receipt NUMERIC(18,4),
void_receipt_cnt NUMERIC(18,4),
void_1itm_receipt_val_2 NUMERIC(18,4),
plus_rec_month NUMERIC(18,4),
plus_rec_day NUMERIC(18,4),
susp_aborted_tot_qty NUMERIC(18,4),
susp_aborted_tot_val NUMERIC(18,4),
susp_aborted_subsequent_trans_low_val NUMERIC(18,4)
);