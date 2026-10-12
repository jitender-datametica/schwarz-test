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

CREATE TABLE P_LEW_MART_MSI.T_MSI_EJR_LP_THRESHOLD_CUMULATION (
 CLIENT_ID NUMBER(38,0),
 DAT_REC_START DATE NOT NULL,
 DAT_REC_END DATE NOT NULL,
 VOID_QTY_TRANS_PAST_3MTH NUMBER(18,4),
 VOID_QTY_TRANS_RANDOM_1W NUMBER(18,4),
 SUSP_QTY_TRANS_PAST_3MTH NUMBER(18,4),
 SUSP_QTY_TRANS_RANDOM_1W NUMBER(18,4),
 RETURN_QTY_TRANS_PAST_3MTH NUMBER(18,4),
 RETURN_FREQ_SAME_ITEM_IN_1W NUMBER(18,4),
 RET_THRESHOLD_QTY_WEEK_IN_3M NUMBER(18,4),
 RETURN_S2_QTY_TRANS_PAST_3M NUMBER(18,4),
 RETURN_QTY_TRANS_RANDOM_1W NUMBER(18,4),
 DEPOSIT_QTY_TRANS_PAST_3MTH NUMBER(18,4),
 DEPOSIT_EAN_QTY_TRANS_PAST_3M NUMBER(18,4),
 DEPOSIT_NOITM_QTY_TRANS_PAST_3M NUMBER(18,4),
 DEPOSIT_NOITM_DAYS_QTY_PAST_3M NUMBER(18,4),
 DEPOSIT_1ITM_QTY_TRANS_PAST_3M NUMBER(18,4),
 DEPOSIT_1ITM_QTY_TRANS_RAND_1W NUMBER(18,4),
 DEPOSIT_AMT_QTY_TRANS_PAST_3M NUMBER(18,4),
 DEPOSIT_AMT_QTY_TRANS_RAND_1W NUMBER(18,4),
 PRICE_SSQ_DAYS_QTY_PAST_3M NUMBER(18,4),
 PRICE_SSQ_QTY_TRANS_PAST_3M NUMBER(18,4),
 PRICE_SSQ_QTY_TRANS_RANDM_1W NUMBER(18,4),
 SUSP_QTY_TRANS_PAST_3MTH_MC NUMBER(18,4),
 SUSP_QTY_TRANS_RANDOM_1W_MC NUMBER(18,4),
 DEPOSIT_QTY_TOTAL_PAST_3MTH NUMBER(18,4),
 PRICE_SERIES_QTY_PAST_3M NUMBER(18,4),
 RET_QTY_STORE_SAME_REC_PAST_3M NUMBER(18,4),
 RET_QTY_NOT_AUTHORISED_PAST_3M NUMBER(18,4),
 RETURN_FREQ_SAME_CHECKER NUMBER(18,4),
 RETURN_NO_RECEIPT_QTY NUMBER(18,4),
 RETURN_MANY_ITM_QTY NUMBER(18,4),
 PLUS_DAYS NUMBER(18,4),
 REQUESTING_USER VARCHAR(128) NOT NULL COLLATE 'en-ci' DEFAULT CURRENT_USER(),
 TIMESTAMP_REQUEST TIMESTAMP_NTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP(),
 APPROVAL_FG NUMBER(38,0) NOT NULL,
 APPROVAL_USER VARCHAR(128) COLLATE 'en-ci',
 TIMESTAMP_APPROVAL TIMESTAMP_NTZ(9),
 APPROVAL2_USER VARCHAR(128) COLLATE 'en-ci',
 TIMESTAMP_APPROVAL2 TIMESTAMP_NTZ(9)
);