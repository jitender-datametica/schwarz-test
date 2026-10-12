/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.T_MSI_EJR_RETURN_TRANSACT_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  05.01.2017    Michael Ueding           Change Primary Index
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.5  31.01.2018    Wieber.Harald            Release 2.3
#  1.6  31.01.2018    Wieber,Harald            Release 2.3
#  1.7  12.07.2018    Wandtke,Andrzej          20180711_1760_Add_New_Column_Rep1 Add return_seq
#  1.8  03.07.2019    Morris, Michael          20190703_2143_ZKP_MFRGB: Add column val_return_same_receipt
#  1.9  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column is_return_same_checker
#  2.0  06.03.2020    Cheryl Barlow            Removal of MVC - Patch No:2408 IDMO: 2786-20200226_2408_MVC_SMALL_18_DWH20
#  2.1  26.05.2020    Wandtke,Andrzej          20200526_2482_ZKP_Einzelbedienerbericht: Add columns is_return_not_dv, is_return_dv, is_return_orig_same_checker, is_return_orig_same_checker_day, is_return_no_orig_receipt
#  2.2  13.05.2021    Wandtke,Andrzej          AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: Add column is_return_sc
#  2.3  20.03.2023    Wandtke,Andrzej          AP0152808 : Add column is_return_no_orig_receipt_man
#  2.4  13.04.2023    Wandtke,Andrzej          AP0170366 : Add columns is_return_many_itm, is_return_same_itm_nb
#  2.5  28.08.2023    Kowalik,Aleksander       AP0170990 : Add column is_return_orig_same_checker_day_not_dv_man
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_return_transact_1 (
client_id BIGNUMERIC(38,0),
st_loc_sid BIGNUMERIC(38,0),
pos_terminal_id BIGNUMERIC(38,0),
dat_formdate DATE,
time_receipt_ejr TIME,
orig_receipt_nr_ejr BIGNUMERIC(38,0),
checker_id BIGNUMERIC(38,0),
s_client_id_ejr BIGNUMERIC(38,0),
s_orig_store_nr_ejr BIGNUMERIC(38,0),
s_dat_formdate_ejr DATE,
s_orig_receipt_nr_ejr BIGNUMERIC(38,0),
s_pos_terminal_id_ejr BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
cnt_return_item BIGNUMERIC(38,0),
dat_last_returndate DATE,
cnt_sale_item BIGNUMERIC(38,0),
is_returned_wo_bon_per_day BIGNUMERIC(38,0),
is_returned_gt_original BIGNUMERIC(38,0),
cnt_returned_gt_original BIGNUMERIC(38,0),
cnt_return_same_receipt NUMERIC(18,4),
is_return_not_authorised BIGNUMERIC(38,0),
return_seq BIGNUMERIC(38,0),
val_return_same_receipt NUMERIC(18,4),
is_return_same_checker BIGNUMERIC(38,0),
is_return_not_dv BIGNUMERIC(38,0),
is_return_dv BIGNUMERIC(38,0),
is_return_orig_same_checker BIGNUMERIC(38,0),
is_return_orig_same_checker_day BIGNUMERIC(38,0),
is_return_no_orig_receipt BIGNUMERIC(38,0),
is_return_sc BIGNUMERIC(38,0),
is_return_no_orig_receipt_man BIGNUMERIC(38,0),
is_return_many_itm BIGNUMERIC(38,0),
is_return_same_itm_nb BIGNUMERIC(38,0),
is_return_orig_same_checker_day_not_dv_man BIGNUMERIC(38,0)
);