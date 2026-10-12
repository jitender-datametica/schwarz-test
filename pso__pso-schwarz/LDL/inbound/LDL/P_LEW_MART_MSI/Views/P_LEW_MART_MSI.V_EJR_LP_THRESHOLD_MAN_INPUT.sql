/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_LP_THRESHOLD_MAN_INPUT
#----------------------------------------------------------------------------
# History:
#  1.0  18.10.2017    -                        Generiert aus Teradata
#  1.1  09.11.2017    Arnold,Arne              Tabellenreferenz fuer Daten korrigiert. Vorher war noch F_MSI_VIEW referenziert.
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder -  mshow_price_val_cnt_checker & mshow_price_low_nxt_receipt_val.
#  1.5  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New columns for discount (Rabatt) metrics
#  1.6  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  1.7  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  1.8  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New column mreturn_no_orig_receipt_cnt_checker for metrics Money return with no original receipt
#  1.9  07.07.2023    Kowalik, Aleksander      AP0122629 Anpassung Kennzahlen Preisanzeige: Two new columns for threshold metrics: MSHOW_PRICE_VAL_NF_LOW and MSHOW_PRICE_CNT_VG_INFOLGE_LOW
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_LP_THRESHOLD_MAN_INPUT
(
	CLIENT_ID
	,DAT_REC_START
	,DAT_REC_END
	,MVOID_QUOTE_CNT_CHECKER
	,MVOID_PER100_TRANS_CNT_CHECKER
	,MVOID_VAL_CNT_CHECKER
	,MABO_QTY_TRANS_CNT_CHECKER
	,MABO_VAL_CNT_CHECKER
	,MSUSP_QTY_TRANS_CNT_CHECKER
	,MRETURN_QUOTE_CNT_CHECKER
	,MRETURN_VAL_CNT_CHECKER
	,MRET_AMOUNT_TRANS_CNT_CHECKER
	,MDEPOSIT_QUOTE_CNT_CHECKER
	,MDEPOSIT_MAN_VAL_CNT_CHECKER
	,MDEPOSIT_ALL_VAL_CNT_CHECKER
	,MOTHERS_QTY_LOWVAL_CNT_CHECKER
	,MOTHERS_QTY_LOGIN_CNT_CHECKER
	,MSUSP_ABORTED_RECEIPT_VAL
	,MOTHERS_LOW_RECEIPT_VAL
	,MVOID_SAME_ITEM_CNT
	,MVOID_ITEM_VAL
	,MRECEIPT_VOID_VAL
	,MRETURN_MANUAL_CNT_CHECKER
	,MSHOW_PRICE_VAL_CNT_CHECKER
	,MSHOW_PRICE_LOW_NXT_RECEIPT_VAL
	,MSHOW_PRICE_VAL_NF_LOW
	,MSHOW_PRICE_CNT_VG_INFOLGE_LOW
	,MDISCOUNT_CNT_CHECKER
	,MDISCOUNT_QUOTE_CHECKER
	,MDISCOUNT_CNT_RECEIPT
	,MDISCOUNT_VAL_RECEIPT
	,MRETURN_NO_ORIG_RECEIPT_CNT_CHECKER
	,REQUESTING_USER
	,TIMESTAMP_REQUEST
	,APPROVAL_USER
	,APPROVAL_FG
	,TIMESTAMP_APPROVAL
) AS
   SELECT
   client_id	
   ,dat_rec_start	
   ,dat_rec_end	
   ,mvoid_quote_cnt_checker	
   ,mvoid_per100_trans_cnt_checker	
   ,mvoid_val_cnt_checker	
   ,mabo_qty_trans_cnt_checker	
   ,mabo_val_cnt_checker	
   ,msusp_qty_trans_cnt_checker	
   ,mreturn_quote_cnt_checker	
   ,mreturn_val_cnt_checker	
   ,mret_amount_trans_cnt_checker	
   ,mdeposit_quote_cnt_checker	
   ,mdeposit_man_val_cnt_checker	
   ,mdeposit_all_val_cnt_checker	
   ,mothers_qty_lowval_cnt_checker	
   ,mothers_qty_login_cnt_checker	
   ,msusp_aborted_receipt_val	
   ,mothers_low_receipt_val	
   ,mvoid_same_item_cnt	
   ,mvoid_item_val	
   ,mreceipt_void_val	
   ,mreturn_manual_cnt_checker	
   ,mshow_price_val_cnt_checker	
   ,mshow_price_low_nxt_receipt_val
   ,mshow_price_val_nf_low
   ,mshow_price_cnt_vg_infolge_low
   ,mdiscount_cnt_checker
   ,mdiscount_quote_checker 
   ,mdiscount_cnt_receipt
   ,mdiscount_val_receipt
   ,mreturn_no_orig_receipt_cnt_checker  
   ,requesting_user	
   ,timestamp_request	
   ,approval_user	
   ,approval_fg	
   ,timestamp_approval	
    FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_manual	
    WHERE dat_rec_end = DATE'9999-12-31'	
    AND approval_fg = 1	
	
    UNION ALL	
	
    SELECT	
    client_id	
   ,dat_rec_start	
   ,dat_rec_end	
   ,mvoid_quote_cnt_checker	
   ,mvoid_per100_trans_cnt_checker	
   ,mvoid_val_cnt_checker	
   ,mabo_qty_trans_cnt_checker	
   ,mabo_val_cnt_checker	
   ,msusp_qty_trans_cnt_checker	
   ,mreturn_quote_cnt_checker	
   ,mreturn_val_cnt_checker	
   ,mret_amount_trans_cnt_checker	
   ,mdeposit_quote_cnt_checker	
   ,mdeposit_man_val_cnt_checker	
   ,mdeposit_all_val_cnt_checker	
   ,mothers_qty_lowval_cnt_checker	
   ,mothers_qty_login_cnt_checker	
   ,msusp_aborted_receipt_val	
   ,mothers_low_receipt_val	
   ,mvoid_same_item_cnt	
   ,mvoid_item_val	
   ,mreceipt_void_val	
   ,mreturn_manual_cnt_checker	
   ,mshow_price_val_cnt_checker	
   ,mshow_price_low_nxt_receipt_val
   ,mshow_price_val_nf_low
   ,mshow_price_cnt_vg_infolge_low
   ,mdiscount_cnt_checker
   ,mdiscount_quote_checker 
   ,mdiscount_cnt_receipt
   ,mdiscount_val_receipt 
   ,mreturn_no_orig_receipt_cnt_checker
   ,requesting_user	
   ,timestamp_request	
   ,approval_user	
   ,-1 AS approval_fg	
   ,timestamp_approval	
    FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_manual	
    WHERE dat_rec_end = DATE'9999-12-31'	
    QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY approval_fg ASC) = 1	
;