/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_VOID_TRANSACTION_ADV_1
#----------------------------------------------------------------------------
# History:
#  1.0  28.11.2023    Szewczyk,Milosz         Storno Beguenstigungen AP0182639 Based on a T_MSI_EJR_VOID_TRANSACTION_1 table
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_void_transaction_adv_1 (
client_id BIGNUMERIC(38,0),
st_loc_sid BIGNUMERIC(38,0),
pos_terminal_id BIGNUMERIC(38,0),
time_receipt_ejr TIME,
dat_formdate DATE,
orig_receipt_nr_ejr BIGNUMERIC(38,0),
wh_loc_sid BIGNUMERIC(38,0),
checker_id BIGNUMERIC(38,0),
is_voided_after_subtotal BIGNUMERIC(38,0),
cnt_void_after_subtotal BIGNUMERIC(38,0),
is_voided_item_innext BIGNUMERIC(38,0),
total_value_void NUMERIC(18,4),
is_pay_exact BIGNUMERIC(38,0),
is_subtotal_bef_storno BIGNUMERIC(38,0),
is_void_not_authorised BIGNUMERIC(38,0),
is_highest_val BIGNUMERIC(38,0),
is_alk_tab BIGNUMERIC(38,0),
is_voided_value_aft_subtotal_2 BIGNUMERIC(38,0),
is_1_itm_2 BIGNUMERIC(38,0),
is_outside_hours BIGNUMERIC(38,0),
is_man_discount BIGNUMERIC(38,0),
cnt_void_ejr BIGNUMERIC(38,0),
is_man_discount_item BIGNUMERIC(38,0)
);