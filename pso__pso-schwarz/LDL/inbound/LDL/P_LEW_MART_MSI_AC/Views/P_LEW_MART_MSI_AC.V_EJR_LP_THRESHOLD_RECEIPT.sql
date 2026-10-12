/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.v_ejr_lp_threshold_receipt
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.6  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.7  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.8  03.05.2018    Wieber.Harald            Release 3.6
#  1.9  17.05.2018    Wieber,Harald            Update Release 3.8
#  2.0  26.04.2018    Wandtke,Andrzej          20180419_1646_ZKP_Creation_Threshold_Team1 Add 2 columns
#  2.1  21.10.2019    Morris, Michael          20191021_2259_ZKP_BBT_272_398 (Jira: LEAD-7462): New Attribute susp_subseqent_trans_low_val_mc
#  2.2  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column return_same_checker_val
#  2.3  24.05.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: Add column void_1itm_receipt_val
#  2.4  02.08.2022    Rekovsky,Marvin          AP0105940_ZKP_Pfandbon_manuell+rein: Add column deposit_noitm_tot_val 
#  2.5  17.03.2023    Wandtke,Andrzej          AP0152808 : Add column return_no_receipt_val
#  2.6  13.04.2023    Wandtke,Andrzej          AP0170366 : Add columns return_many_itm_cnt, return_many_itm_val
#  2.7  28.08.2023    Kowalik,Aleksander       AP0177990 : Add columns return_same_checker_val_ebb_m, return_same_checker_val_ebb_l
#  2.8  11.01.2024    Szewczyk,Milosz          AP0182639 : Add columns void_itm_cnt, void_tot_val_cnt, void_tot_itm_in, void_receipt_cnt, void_1itm_receipt_val_2
#  2.9  12.03.2024    Szewczyk,Milosz          AP0188368 : Add columns PLUS_REC_MONTH,PLUS_REC_DAY
#  3.0  22.04.2024    Kowalik,Aleksander       AP0198132 : Add columns susp_aborted (x3) for Bonabbruch AP
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_msi_ac.v_ejr_lp_threshold_receipt
(
client_id
,deposit_1itm_item_val
,deposit_1itm_plus_empty_ret
,deposit_1itm_receipt_val
,deposit_noitm_tot_val
,deposit_amt_plus_empty_ret
,deposit_scanned_qty_integer
,deposit_scanned_value
,price_series_receipt_cnt
,price_series_receipt_total_val
,price_subseq_trans_low_val
,return_item_price
,return_not_authorised_val
,return_same_receipt_qty
,return_same_receipt_val
,return_tot_val
,return_tot_val_nf
,return_value
,susp_subsequent_trans_low_val
,susp_tot_val
,susp_voided_exp_last_void_val
,susp_voided_exp_last_void_val2
,void_tot_val_aft_subtot
,return_not_authorised_val2
,price_subseq_trans_low_val2
,susp_subseqent_trans_low_val_mc
,return_same_checker_val
,return_same_checker_val_ebb_m
,return_same_checker_val_ebb_l
,void_1itm_receipt_val
,return_no_receipt_val
,return_many_itm_cnt
,return_many_itm_val
,void_itm_cnt
,void_tot_val_cnt
,void_tot_itm_in_receipt
,void_receipt_cnt
,void_1itm_receipt_val_2
,plus_rec_month
,plus_rec_day
,susp_aborted_tot_qty 
,susp_aborted_tot_val 
,susp_aborted_subsequent_trans_low_val
)
AS
SELECT
client_id
,deposit_1itm_item_val
,deposit_1itm_plus_empty_ret
,deposit_1itm_receipt_val
,deposit_noitm_tot_val
,deposit_amt_plus_empty_ret
,deposit_scanned_qty_integer
,deposit_scanned_value
,price_series_receipt_cnt
,price_series_receipt_total_val
,price_subseq_trans_low_val
,return_item_price
,return_not_authorised_val
,return_same_receipt_qty
,return_same_receipt_val
,return_tot_val
,return_tot_val_nf
,return_value
,susp_subsequent_trans_low_val
,susp_tot_val
,susp_voided_exp_last_void_val
,susp_voided_exp_last_void_val2
,void_tot_val_aft_subtot
,return_not_authorised_val2
,price_subseq_trans_low_val2
,susp_subseqent_trans_low_val_mc
,return_same_checker_val
,return_same_checker_val_ebb_m
,return_same_checker_val_ebb_l
,void_1itm_receipt_val
,return_no_receipt_val
,return_many_itm_cnt
,return_many_itm_val
,void_itm_cnt
,void_tot_val_cnt
,void_tot_itm_in_receipt
,void_receipt_cnt
,void_1itm_receipt_val_2
,plus_rec_month
,plus_rec_day
,susp_aborted_tot_qty 
,susp_aborted_tot_val 
,susp_aborted_subsequent_trans_low_val
FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_receipt

WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
AND approval_fg = 1
;