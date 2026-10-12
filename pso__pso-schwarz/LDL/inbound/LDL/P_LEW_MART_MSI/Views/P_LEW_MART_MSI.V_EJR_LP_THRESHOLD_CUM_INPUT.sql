/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_ejr_lp_threshold_cum_input
#----------------------------------------------------------------------------
# History:
#  1.0  18.10.2017    -                        Generiert aus Teradata
#  1.1  09.11.2017    Arnold,Arne              Tabellenreferenz fuer Daten korrigiert. Vorher war noch F_MSI_VIEW referenziert.
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column return_freq_same_checker
#  1.5  09.12.2021    Wandtke,Andrzej          AP0085915_ZKP_SHOW_PRICE add column PRICE_SSQ_DAYS_QTY_PAST_3M
#  1.6  02.08.2022    Rekovsky,Marvin          AP0105940_ZKP_Pfandbon_manuell+rein: Add columns deposit_noitm_qty_trans_past_3m and deposit_noitm_days_qty_past_3m
#  1.7  17.03.2023    Wandtke,Andrzej          AP0152808 : Add column return_no_receipt_qty
#  1.8  13.04.2023    Wandtke,Andrzej          AP0170366 : Add column return_many_itm_qty
#  1.9  12.03.2024    Szewczyk,Milosz          AP0188368 : Add column plus_days
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_LP_THRESHOLD_CUM_INPUT AS
SELECT	
 client_id
,dat_rec_start
,dat_rec_end
,void_qty_trans_past_3mth
,void_qty_trans_random_1w
,susp_qty_trans_past_3mth
,susp_qty_trans_random_1w
,return_qty_trans_past_3mth
,return_freq_same_item_in_1w
,ret_threshold_qty_week_in_3m
,return_s2_qty_trans_past_3m
,return_qty_trans_random_1w
,deposit_qty_trans_past_3mth
,deposit_ean_qty_trans_past_3m
,deposit_noitm_qty_trans_past_3m
,deposit_noitm_days_qty_past_3m
,deposit_1itm_qty_trans_past_3m
,deposit_1itm_qty_trans_rand_1w
,deposit_amt_qty_trans_past_3m
,deposit_amt_qty_trans_rand_1w
,price_ssq_days_qty_past_3m
,price_ssq_qty_trans_past_3m
,price_ssq_qty_trans_randm_1w
,susp_qty_trans_past_3mth_mc
,susp_qty_trans_random_1w_mc
,deposit_qty_total_past_3mth
,price_series_qty_past_3m
,ret_qty_store_same_rec_past_3m
,ret_qty_not_authorised_past_3m
,return_freq_same_checker
,return_no_receipt_qty
,return_many_itm_qty
,plus_days
,requesting_user
,timestamp_request
,approval_user
,approval_fg
,timestamp_approval	
FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation	
WHERE dat_rec_end = DATE'9999-12-31'	
AND approval_fg = 1	
	
UNION ALL	
	
SELECT	
 client_id
,dat_rec_start
,dat_rec_end
,void_qty_trans_past_3mth
,void_qty_trans_random_1w
,susp_qty_trans_past_3mth
,susp_qty_trans_random_1w
,return_qty_trans_past_3mth
,return_freq_same_item_in_1w
,ret_threshold_qty_week_in_3m
,return_s2_qty_trans_past_3m
,return_qty_trans_random_1w
,deposit_qty_trans_past_3mth
,deposit_ean_qty_trans_past_3m
,deposit_noitm_qty_trans_past_3m
,deposit_noitm_days_qty_past_3m
,deposit_1itm_qty_trans_past_3m
,deposit_1itm_qty_trans_rand_1w
,deposit_amt_qty_trans_past_3m
,deposit_amt_qty_trans_rand_1w
,price_ssq_days_qty_past_3m
,price_ssq_qty_trans_past_3m
,price_ssq_qty_trans_randm_1w
,susp_qty_trans_past_3mth_mc
,susp_qty_trans_random_1w_mc
,deposit_qty_total_past_3mth
,price_series_qty_past_3m
,ret_qty_store_same_rec_past_3m
,ret_qty_not_authorised_past_3m
,return_freq_same_checker
,return_no_receipt_qty
,return_many_itm_qty
,plus_days
,requesting_user
,timestamp_request
,approval_user
,-1 AS approval_fg
,timestamp_approval	
FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_cumulation	
WHERE dat_rec_end = DATE'9999-12-31'	
QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY approval_fg ASC) = 1	
;