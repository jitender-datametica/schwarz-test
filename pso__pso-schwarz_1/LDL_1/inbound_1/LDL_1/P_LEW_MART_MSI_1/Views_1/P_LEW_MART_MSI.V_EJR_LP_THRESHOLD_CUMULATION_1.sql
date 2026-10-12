/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_ejr_lp_threshold_cumulation_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  10.11.2017    Toth,Gabriel             Changed to match the coex counterpart
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  11.01.2018    Meister,Ulrich           JOIN adjusted from LEFT OUTER to INNER
#  1.4  17.01.2018    Wieber,Harald            Release 2.2
#  1.5  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column return_freq_same_checker
#  1.6  08.12.2021    Wandtke,Andrzej          AP0085915_ZKP_SHOW_PRICE add column PRICE_SSQ_DAYS_QTY_PAST_3M
#  1.7  02.08.2022    Rekovsky,Marvin          AP0105940_ZKP_Pfandbon_manuell+rein: Add columns deposit_noitm_qty_trans_past_3m and deposit_noitm_days_qty_past_3m
#  1.8  17.03.2023    Wandtke,Andrzej          AP0152808 : Add column return_no_receipt_qty
#  1.9  13.04.2023    Wandtke,Andrzej          AP0170366 : Add column return_many_itm_qty
#  2.0  12.03.2024    Szewczyk,Milosz          AP0188368 : Add column plus_days
#----------------------------------------------------------------------------
*/
 
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_LP_THRESHOLD_CUMULATION_1
  (	 
  client_id	
  , void_qty_trans_past_3mth	
  , void_qty_trans_random_1w	
  , susp_qty_trans_past_3mth	
  , susp_qty_trans_random_1w	
  , return_qty_trans_past_3mth	
  , return_freq_same_item_in_1w	
  , ret_threshold_qty_week_in_3m	
  , return_s2_qty_trans_past_3m	
  , return_qty_trans_random_1w	
  , deposit_qty_trans_past_3mth	
  , deposit_ean_qty_trans_past_3m
  , deposit_noitm_qty_trans_past_3m
  , deposit_noitm_days_qty_past_3m	
  , deposit_1itm_qty_trans_past_3m	
  , deposit_1itm_qty_trans_rand_1w	
  , deposit_amt_qty_trans_past_3m	
  , deposit_amt_qty_trans_rand_1w
  , price_ssq_days_qty_past_3m
  , price_ssq_qty_trans_past_3m	
  , price_ssq_qty_trans_randm_1w	
  , susp_qty_trans_past_3mth_mc	
  , susp_qty_trans_random_1w_mc	
  , deposit_qty_total_past_3mth	
  , price_series_qty_past_3m	
  , ret_qty_store_same_rec_past_3m	
  , ret_qty_not_authorised_past_3m	
  , return_freq_same_checker	
  , return_no_receipt_qty
  , return_many_itm_qty
  , plus_days
  , store_id	
  , checker_id	
  )	
  AS	
     SELECT	
       tc.client_id
	,tc.void_qty_trans_past_3mth
	,tc.void_qty_trans_random_1w
	,tc.susp_qty_trans_past_3mth
	,tc.susp_qty_trans_random_1w
	,tc.return_qty_trans_past_3mth
	,tc.return_freq_same_item_in_1w
	,tc.ret_threshold_qty_week_in_3m
	,tc.return_s2_qty_trans_past_3m
	,tc.return_qty_trans_random_1w
	,tc.deposit_qty_trans_past_3mth
	,tc.deposit_ean_qty_trans_past_3m
  ,tc.deposit_noitm_qty_trans_past_3m
  ,tc.deposit_noitm_days_qty_past_3m
	,tc.deposit_1itm_qty_trans_past_3m
	,tc.deposit_1itm_qty_trans_rand_1w
	,tc.deposit_amt_qty_trans_past_3m
	,tc.deposit_amt_qty_trans_rand_1w
	,tc.price_ssq_days_qty_past_3m
	,tc.price_ssq_qty_trans_past_3m
	,tc.price_ssq_qty_trans_randm_1w
	,tc.susp_qty_trans_past_3mth_mc
	,tc.susp_qty_trans_random_1w_mc
	,tc.deposit_qty_total_past_3mth
	,tc.price_series_qty_past_3m
	,tc.ret_qty_store_same_rec_past_3m
	,tc.ret_qty_not_authorised_past_3m
	,tc.return_freq_same_checker
	,tc.return_no_receipt_qty
	,tc.return_many_itm_qty
	,tc.plus_days
	,chk.store_id
	,chk.checker_id	
 FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation_1 tc	
     INNER JOIN p_lew_mart_msi.v_ejr_org_checker_1 AS chk	
     ON tc.client_id = chk.client_id	
     WHERE Current_Date BETWEEN tc.dat_rec_start AND tc.dat_rec_end	
     AND   tc.approval_fg = 1	
;