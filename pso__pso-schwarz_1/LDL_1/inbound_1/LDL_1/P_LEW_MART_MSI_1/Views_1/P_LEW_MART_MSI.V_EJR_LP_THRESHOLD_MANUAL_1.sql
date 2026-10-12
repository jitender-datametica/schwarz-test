/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_LP_THRESHOLD_MANUAL_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  17.10.2017    Toth,Gabriel             Added store_id, checker_id and removed some columns
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder - mshow_price_val_cnt_checker & mshow_price_low_nxt_receipt_val.
#  1.5  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New columns for discount (Rabatt) metrics
#  1.6  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  1.7  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  1.8  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New column mreturn_no_orig_receipt_cnt_checker for metrics Money return with no original receipt
#  1.9  07.07.2023    Kowalik, Aleksander      AP0122629 Anpassung Kennzahlen Preisanzeige: Two new columns for threshold metrics: MSHOW_PRICE_VAL_NF_LOW and MSHOW_PRICE_CNT_VG_INFOLGE_LOW
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_LP_THRESHOLD_MANUAL_1
(
	CLIENT_ID
	,STORE_ID
	,CHECKER_ID
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
) AS	
   SELECT	
   tm.client_id	
   ,chk.store_id	
   ,chk.checker_id	
   ,tm.mvoid_quote_cnt_checker	
   ,tm.mvoid_per100_trans_cnt_checker	
   ,tm.mvoid_val_cnt_checker	
   ,tm.mabo_qty_trans_cnt_checker	
   ,tm.mabo_val_cnt_checker	
   ,tm.msusp_qty_trans_cnt_checker	
   ,tm.mreturn_quote_cnt_checker	
   ,tm.mreturn_val_cnt_checker	
   ,tm.mret_amount_trans_cnt_checker	
   ,tm.mdeposit_quote_cnt_checker	
   ,tm.mdeposit_man_val_cnt_checker	
   ,tm.mdeposit_all_val_cnt_checker	
   ,tm.mothers_qty_lowval_cnt_checker	
   ,tm.mothers_qty_login_cnt_checker	
   ,tm.msusp_aborted_receipt_val	
   ,tm.mothers_low_receipt_val	
   ,tm.mvoid_same_item_cnt	
   ,tm.mvoid_item_val	
   ,tm.mreceipt_void_val	
   ,tm.mreturn_manual_cnt_checker	
   ,tm.mshow_price_val_cnt_checker	
   ,tm.mshow_price_low_nxt_receipt_val
   ,tm.mshow_price_val_nf_low
   ,tm.mshow_price_cnt_vg_infolge_low
   ,tm.mdiscount_cnt_checker
   ,tm.mdiscount_quote_checker
   ,tm.mdiscount_cnt_receipt
   ,tm.mdiscount_val_receipt
   ,tm.mreturn_no_orig_receipt_cnt_checker
   FROM p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_1 AS tm	
   INNER JOIN p_lew_mart_msi.v_ejr_org_checker_1 AS chk	
   ON tm.client_id   = chk.client_id	
   WHERE CURRENT_DATE BETWEEN tm.dat_rec_start AND tm.dat_rec_end	
     AND tm.approval_fg = 1	
;