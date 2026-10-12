/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_VOID_TRANSACTION_ADV_2
#----------------------------------------------------------------------------
# History:
#  1.0  11.01.2024    Szewczyk, Milosz        AP0182639
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_void_transaction_adv_2 (client_id, store_id, pos_terminal_id,
time_receipt_ejr, dat_formdate, orig_receipt_nr_ejr, wh_id, checker_id, is_voided_after_subtotal,
cnt_void_after_subtotal, is_voided_item_innext, total_value_void, is_pay_exact, is_subtotal_bef_storno,
is_void_not_authorised, is_highest_val, is_alk_tab, is_voided_value_aft_subtotal_2, is_1_itm_2, is_outside_hours,
is_man_discount, cnt_void_ejr, is_man_discount_item) AS SELECT OW.client_id,
 OW.st_loc_sid AS store_id,
 OW.pos_terminal_id,
 OW.time_receipt_ejr,
 OW.dat_formdate,
 OW.orig_receipt_nr_ejr,
 WH.src_wh_id AS wh_id,
 OW.checker_id,
 OW.is_voided_after_subtotal,
 OW.cnt_void_after_subtotal,
 OW.is_voided_item_innext,
 OW.total_value_void,
 OW.is_pay_exact,
 OW.is_subtotal_bef_storno,
 OW.is_void_not_authorised,
 OW.is_highest_val,
 OW.is_alk_tab,
 OW.is_voided_value_aft_subtotal_2,
 OW.is_1_itm_2,
 OW.is_outside_hours,
 OW.is_man_discount,
 OW.cnt_void_ejr,
 OW.is_man_discount_item
FROM ldl_p_lew_mart_msi.t_msi_ejr_void_transaction_adv_2 AS OW
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON OW.client_id = WH.client_id AND OW.wh_loc_sid = WH.src_wh_id AND WH.dwh_actual_fg
    = 1;