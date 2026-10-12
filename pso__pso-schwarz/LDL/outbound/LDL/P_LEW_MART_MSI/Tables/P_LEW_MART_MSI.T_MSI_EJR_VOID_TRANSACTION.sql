/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_VOID_TRANSACTION
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  05.01.2017    Michael Ueding           Change Primary Index
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.5  31.01.2018    Wieber.Harald            Release 2.3
#  1.6  31.01.2018    Wieber,Harald            Release 2.3
#  1.7  24.05.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: Add columns total_value_void, is_pay_exact, is_subtotal_bef_storno, is_void_not_authorised, is_highest_val, is_alk_tab, is_1_itm
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_void_transaction (
client_id BIGNUMERIC(38,0),
st_loc_sid BIGNUMERIC(38,0),
pos_terminal_id BIGNUMERIC(38,0),
time_receipt_ejr TIME,
dat_formdate DATE,
orig_receipt_nr_ejr BIGNUMERIC(38,0),
wh_loc_sid BIGNUMERIC(38,0),
checker_id BIGNUMERIC(38,0),
last_void_line_nr BIGNUMERIC(38,0),
is_voided_after_subtotal BIGNUMERIC(38,0),
cnt_void_after_subtotal BIGNUMERIC(38,0),
is_sale_after_subtotal BIGNUMERIC(38,0),
last_subtotal_line BIGNUMERIC(38,0),
voided_value_aft_subtotal NUMERIC(18,4),
is_voided_value_aft_subtotal BIGNUMERIC(38,0),
is_voided_item_innext BIGNUMERIC(38,0),
total_value_void NUMERIC(18,4),
is_pay_exact BIGNUMERIC(38,0),
is_subtotal_bef_storno BIGNUMERIC(38,0),
is_void_not_authorised BIGNUMERIC(38,0),
is_highest_val BIGNUMERIC(38,0),
is_alk_tab BIGNUMERIC(38,0),
is_1_itm BIGNUMERIC(38,0)
);