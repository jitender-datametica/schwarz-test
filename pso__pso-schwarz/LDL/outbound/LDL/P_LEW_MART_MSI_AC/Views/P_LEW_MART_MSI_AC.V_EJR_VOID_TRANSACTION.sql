/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_EJR_VOID_TRANSACTION
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
#  2.0  24.05.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: Add columns total_value_void, is_pay_exact, is_subtotal_bef_storno, is_void_not_authorised, is_highest_val, is_alk_tab, is_1_itm
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_void_transaction (client_id, store_id, pos_terminal_id,
time_receipt_ejr, dat_formdate, orig_receipt_nr_ejr, wh_id, checker_id, last_void_line_nr, is_voided_after_subtotal,
cnt_void_after_subtotal, is_sale_after_subtotal, last_subtotal_line, voided_value_aft_subtotal,
is_voided_value_aft_subtotal, is_voided_item_innext, total_value_void, is_pay_exact, is_subtotal_bef_storno,
is_void_not_authorised, is_highest_val, is_alk_tab, is_1_itm) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_void_transaction;