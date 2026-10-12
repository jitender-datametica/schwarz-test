/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_VOID_TRANSACTION_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  10.01.2018    Michael Ueding           Lkp Key Map fuer wh_id
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_1 mit V_WAREHOUSE_1 ersetzt
#  1.5  24.05.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: Add columns total_value_void, is_pay_exact, is_subtotal_bef_storno, is_void_not_authorised, is_highest_val, is_alk_tab, is_1_itm
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_void_transaction_1 (client_id, store_id, pos_terminal_id, time_receipt_ejr
, dat_formdate, orig_receipt_nr_ejr, wh_id, checker_id, last_void_line_nr, is_voided_after_subtotal,
cnt_void_after_subtotal, is_sale_after_subtotal, last_subtotal_line, voided_value_aft_subtotal,
is_voided_value_aft_subtotal, is_voided_item_innext, total_value_void, is_pay_exact, is_subtotal_bef_storno,
is_void_not_authorised, is_highest_val, is_alk_tab, is_1_itm) AS SELECT OW.client_id,
 OW.st_loc_sid AS store_id,
 OW.pos_terminal_id,
 OW.time_receipt_ejr,
 OW.dat_formdate,
 OW.orig_receipt_nr_ejr,
 WH.src_wh_id AS wh_id,
 OW.checker_id,
 OW.last_void_line_nr,
 OW.is_voided_after_subtotal,
 OW.cnt_void_after_subtotal,
 OW.is_sale_after_subtotal,
 OW.last_subtotal_line,
 OW.voided_value_aft_subtotal,
 OW.is_voided_value_aft_subtotal,
 OW.is_voided_item_innext,
 OW.total_value_void,
 OW.is_pay_exact,
 OW.is_subtotal_bef_storno,
 OW.is_void_not_authorised,
 OW.is_highest_val,
 OW.is_alk_tab,
 OW.is_1_itm
FROM ldl_p_lew_mart_msi.t_msi_ejr_void_transaction_1 AS OW
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON OW.client_id = WH.client_id AND OW.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1;