/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_EJR_LP_THRESHOLD_MANUAL_2
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
#  2.0  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Attribute mshow_price_val_cnt_checker & mshow_price_low_nxt_receipt_val
#  2.1  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New columns for discount (Rabatt) metrics
#  2.2  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  2.3  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: New column mreturn_no_orig_receipt_cnt_checker for metrics Money return with no original receipt
#  2.3  07.07.2023    Kowalik, Aleksander      AP0122629 Anpassung Kennzahlen Preisanzeige: Two new columns for threshold metrics: mshow_price_val_nf_low and mshow_price_cnt_vg_infolge_low
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_lp_threshold_manual_2 (client_id, store_id, checker_id,
mvoid_quote_cnt_checker, mvoid_per100_trans_cnt_checker, mvoid_val_cnt_checker, mabo_qty_trans_cnt_checker,
mabo_val_cnt_checker, msusp_qty_trans_cnt_checker, mreturn_quote_cnt_checker, mreturn_val_cnt_checker,
mret_amount_trans_cnt_checker, mdeposit_quote_cnt_checker, mdeposit_man_val_cnt_checker, mdeposit_all_val_cnt_checker,
mothers_qty_lowval_cnt_checker, mothers_qty_login_cnt_checker, msusp_aborted_receipt_val, mothers_low_receipt_val,
mvoid_same_item_cnt, mvoid_item_val, mreceipt_void_val, mreturn_manual_cnt_checker, mshow_price_val_cnt_checker,
mshow_price_low_nxt_receipt_val, mshow_price_val_nf_low, mshow_price_cnt_vg_infolge_low, mdiscount_cnt_checker,
mdiscount_quote_checker, mdiscount_cnt_receipt, mdiscount_val_receipt, mreturn_no_orig_receipt_cnt_checker) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_lp_threshold_manual_2;