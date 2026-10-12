/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_ejr_return_transact
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  12.07.2018    Wandtke,Andrzej          20180711_1760_Add_New_Column_Rep1 Add return_seq
#  1.4  03.07.2019    Morris, Michael          20190703_2143_ZKP_MFRGB Add new column val_return_same_receipt
#  1.5  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) New column is_return_same_checker
#  1.6  26.05.2020    Wandtke,Andrzej          20200526_2482_ZKP_Einzelbedienerbericht: Add columns is_return_not_dv, is_return_dv, is_return_orig_same_checker, is_return_orig_same_checker_day, is_return_no_orig_receipt
#  1.7  13.05.2021    Wandtke,Andrzej          AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: Add column is_return_sc
#  1.8  20.03.2023    Wandtke,Andrzej          AP0152808 : Add column is_return_no_orig_receipt_man
#  1.9  13.04.2023    Wandtke,Andrzej          AP0170366 : Add columns is_return_many_itm, is_return_same_itm_nb
#  2.0  28.08.2023    Kowalik,Aleksander       AP0170990 : Add column is_return_orig_same_checker_day_not_dv_man
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_RETURN_TRANSACT
   (
   client_id
   , store_id
   , pos_terminal_id
   , dat_formdate
   , time_receipt_ejr
   , orig_receipt_nr_ejr
   , checker_id
   , s_client_id_ejr
   , s_orig_store_nr_ejr
   , s_dat_formdate_ejr
   , s_orig_receipt_nr_ejr
   , s_pos_terminal_id_ejr
   , item_id
   , cnt_return_item
   , dat_last_returndate
   , cnt_sale_item
   , is_returned_wo_bon_per_day
   , is_returned_gt_original
   , cnt_returned_gt_original
   , cnt_return_same_receipt
   , is_return_not_authorised
   , return_seq
   , val_return_same_receipt
   , is_return_same_checker
   , is_return_not_dv
   , is_return_dv
   , is_return_orig_same_checker
   , is_return_orig_same_checker_day
   , is_return_no_orig_receipt
   , is_return_sc
   , is_return_no_orig_receipt_man
   , is_return_many_itm
   , is_return_same_itm_nb
   , is_return_orig_same_checker_day_not_dv_man)
   AS
      SELECT
       client_id
      ,st_loc_sid AS store_id
      ,pos_terminal_id
      ,dat_formdate
      ,time_receipt_ejr
      ,orig_receipt_nr_ejr
      ,checker_id
      ,s_client_id_ejr
      ,s_orig_store_nr_ejr
      ,s_dat_formdate_ejr
      ,s_orig_receipt_nr_ejr
      ,s_pos_terminal_id_ejr
      ,item_sid AS item_id
      ,cnt_return_item
      ,dat_last_returndate
      ,cnt_sale_item
      ,is_returned_wo_bon_per_day
      ,is_returned_gt_original
      ,cnt_returned_gt_original
      ,cnt_return_same_receipt
      ,is_return_not_authorised
      ,return_seq
      ,val_return_same_receipt
      ,is_return_same_checker
      ,is_return_not_dv
      ,is_return_dv
      ,is_return_orig_same_checker
      ,is_return_orig_same_checker_day
      ,is_return_no_orig_receipt
      ,is_return_sc
      ,is_return_no_orig_receipt_man
	  ,is_return_many_itm
	  ,is_return_same_itm_nb
	  ,is_return_orig_same_checker_day_not_dv_man
      FROM p_lew_mart_msi.t_msi_ejr_return_transact
;