/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.t_msi_ejr_lp_threshold_receipt_2
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

CREATE TABLE P_LEW_MART_MSI.T_MSI_EJR_LP_THRESHOLD_RECEIPT_2
(
CLIENT_ID SMALLINT,
DAT_REC_START DATE NOT NULL,
DAT_REC_END DATE NOT NULL,
VOID_TOT_VAL_AFT_SUBTOT DECIMAL(18,4),
SUSP_TOT_VAL DECIMAL(18,4),
SUSP_SUBSEQUENT_TRANS_LOW_VAL DECIMAL(18,4),
SUSP_VOIDED_EXP_LAST_VOID_VAL DECIMAL(18,4),
RETURN_ITEM_PRICE DECIMAL(18,4),
RETURN_TOT_VAL DECIMAL(18,4),
RETURN_VALUE DECIMAL(18,4),
RETURN_TOT_VAL_NF DECIMAL(18,4),
DEPOSIT_SCANNED_VALUE DECIMAL(18,4),
DEPOSIT_SCANNED_QTY_INTEGER DECIMAL(18,4),
DEPOSIT_1ITM_PLUS_EMPTY_RET DECIMAL(18,4),
DEPOSIT_AMT_PLUS_EMPTY_RET DECIMAL(18,4),
PRICE_SUBSEQ_TRANS_LOW_VAL DECIMAL(18,4),
SUSP_VOIDED_EXP_LAST_VOID_VAL2 DECIMAL(18,4),
DEPOSIT_1ITM_RECEIPT_VAL DECIMAL(18,4),
DEPOSIT_1ITM_ITEM_VAL DECIMAL(18,4),
DEPOSIT_NOITM_TOT_VAL NUMBER(18,4),
PRICE_SERIES_RECEIPT_CNT DECIMAL(18,4),
PRICE_SERIES_RECEIPT_TOTAL_VAL DECIMAL(18,4),
RETURN_SAME_RECEIPT_QTY DECIMAL(18,4),
RETURN_SAME_RECEIPT_VAL DECIMAL(18,4),
RETURN_NOT_AUTHORISED_VAL DECIMAL(18,4),
RETURN_NOT_AUTHORISED_VAL2 DECIMAL(18,4),
PRICE_SUBSEQ_TRANS_LOW_VAL2 DECIMAL(18,4),
SUSP_SUBSEQENT_TRANS_LOW_VAL_MC DECIMAL(18,4),
RETURN_SAME_CHECKER_VAL DECIMAL(18,4),
VOID_1ITM_RECEIPT_VAL DECIMAL(18,4),
RETURN_NO_RECEIPT_VAL DECIMAL(18,4),
RETURN_MANY_ITM_CNT NUMBER(18,4),
RETURN_MANY_ITM_VAL NUMBER(18,4),
REQUESTING_USER VARCHAR(128) COLLATE 'en-ci' DEFAULT CURRENT_USER NOT NULL ,
TIMESTAMP_REQUEST TIMESTAMP_NTZ(9) DEFAULT CURRENT_TIMESTAMP() NOT NULL,
APPROVAL_FG BYTEINT NOT NULL,
APPROVAL_USER VARCHAR(128) COLLATE 'en-ci',
TIMESTAMP_APPROVAL TIMESTAMP_NTZ(9),
APPROVAL2_USER VARCHAR(128) COLLATE 'en-ci',
TIMESTAMP_APPROVAL2 TIMESTAMP_NTZ(9),
RETURN_SAME_CHECKER_VAL_EBB_M NUMBER(18,4),
RETURN_SAME_CHECKER_VAL_EBB_L NUMBER(18,4),
VOID_ITM_CNT DECIMAL(18,4),
VOID_TOT_VAL_CNT DECIMAL(18,4),
VOID_TOT_ITM_IN_RECEIPT	DECIMAL(18,4),
VOID_RECEIPT_CNT DECIMAL(18,4),
VOID_1ITM_RECEIPT_VAL_2 DECIMAL(18,4),
PLUS_REC_MONTH DECIMAL(18,4),
PLUS_REC_DAY DECIMAL(18,4),
SUSP_ABORTED_TOT_QTY NUMBER(18,4),
SUSP_ABORTED_TOT_VAL NUMBER(18,4),
SUSP_ABORTED_SUBSEQUENT_TRANS_LOW_VAL NUMBER(18,4)
);