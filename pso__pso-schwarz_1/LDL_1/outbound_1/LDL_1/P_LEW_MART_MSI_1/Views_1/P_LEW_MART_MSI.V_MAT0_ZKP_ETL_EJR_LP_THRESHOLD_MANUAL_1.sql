/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT0_ZKP_ETL_EJR_LP_THRESHOLD_MANUAL_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New columns for discount (Rabatt) metrics
#  1.3  28.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Change to n_ view
#  1.4  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  1.5  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  1.6  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New column mreturn_no_orig_receipt_cnt_checker for metrics Money return with no original receipt
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_threshold_manual_1 AS SELECT client_id,
 dat_rec_start,
 dat_rec_end,
 mvoid_quote_cnt_checker,
 mvoid_per100_trans_cnt_checker,
 mvoid_val_cnt_checker,
 mabo_qty_trans_cnt_checker,
 mabo_val_cnt_checker,
 msusp_qty_trans_cnt_checker,
 mreturn_quote_cnt_checker,
 mreturn_val_cnt_checker,
 mret_amount_trans_cnt_checker,
 mdeposit_quote_cnt_checker,
 mdeposit_man_val_cnt_checker,
 mdeposit_all_val_cnt_checker,
 mothers_qty_lowval_cnt_checker,
 mothers_qty_login_cnt_checker,
 msusp_aborted_receipt_val,
 mothers_low_receipt_val,
 mvoid_same_item_cnt,
 mvoid_item_val,
 mreceipt_void_val,
 mreturn_manual_cnt_checker,
 mdiscount_cnt_checker,
 mdiscount_quote_checker,
 mdiscount_cnt_receipt,
 mdiscount_val_receipt,
 mreturn_no_orig_receipt_cnt_checker,
 requesting_user,
 timestamp_request,
 approval_fg,
 approval_user,
 timestamp_approval,
 approval2_user,
 timestamp_approval2
FROM ldl_p_lew_mart_msi.t_msi_ejr_lp_threshold_manual_1;