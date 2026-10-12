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


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_lp_threshold_manual_1 (client_id, store_id, checker_id,
mvoid_quote_cnt_checker, mvoid_per100_trans_cnt_checker, mvoid_val_cnt_checker, mabo_qty_trans_cnt_checker,
mabo_val_cnt_checker, msusp_qty_trans_cnt_checker, mreturn_quote_cnt_checker, mreturn_val_cnt_checker,
mret_amount_trans_cnt_checker, mdeposit_quote_cnt_checker, mdeposit_man_val_cnt_checker, mdeposit_all_val_cnt_checker,
mothers_qty_lowval_cnt_checker, mothers_qty_login_cnt_checker, msusp_aborted_receipt_val, mothers_low_receipt_val,
mvoid_same_item_cnt, mvoid_item_val, mreceipt_void_val, mreturn_manual_cnt_checker, mshow_price_val_cnt_checker,
mshow_price_low_nxt_receipt_val, mshow_price_val_nf_low, mshow_price_cnt_vg_infolge_low, mdiscount_cnt_checker,
mdiscount_quote_checker, mdiscount_cnt_receipt, mdiscount_val_receipt, mreturn_no_orig_receipt_cnt_checker) AS SELECT TM
 .client_id,
 CHK.store_id,
 CHK.checker_id,
 TM.mvoid_quote_cnt_checker,
 TM.mvoid_per100_trans_cnt_checker,
 TM.mvoid_val_cnt_checker,
 TM.mabo_qty_trans_cnt_checker,
 TM.mabo_val_cnt_checker,
 TM.msusp_qty_trans_cnt_checker,
 TM.mreturn_quote_cnt_checker,
 TM.mreturn_val_cnt_checker,
 TM.mret_amount_trans_cnt_checker,
 TM.mdeposit_quote_cnt_checker,
 TM.mdeposit_man_val_cnt_checker,
 TM.mdeposit_all_val_cnt_checker,
 TM.mothers_qty_lowval_cnt_checker,
 TM.mothers_qty_login_cnt_checker,
 TM.msusp_aborted_receipt_val,
 TM.mothers_low_receipt_val,
 TM.mvoid_same_item_cnt,
 TM.mvoid_item_val,
 TM.mreceipt_void_val,
 TM.mreturn_manual_cnt_checker,
 TM.mshow_price_val_cnt_checker,
 TM.mshow_price_low_nxt_receipt_val,
 TM.mshow_price_val_nf_low,
 TM.mshow_price_cnt_vg_infolge_low,
 TM.mdiscount_cnt_checker,
 TM.mdiscount_quote_checker,
 TM.mdiscount_cnt_receipt,
 TM.mdiscount_val_receipt,
 TM.mreturn_no_orig_receipt_cnt_checker
FROM ldl_p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_1 AS TM
 INNER JOIN ldl_p_lew_mart_msi.v_ejr_org_checker_1 AS CHK ON TM.client_id = CHK.client_id
WHERE CURRENT_DATE BETWEEN TM.dat_rec_start AND TM.dat_rec_end
 AND TM.approval_fg = 1;