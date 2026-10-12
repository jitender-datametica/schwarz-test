/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_ALL_TRANSACT_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  18.06.2021    Wandtke,Andrzej          AP0090657_zkp_transall REP1-14602 20210608_2859_ZKP_TransAll remove table v_wawi_ref_client_currency_rate_1, use v_exchange_rate_known_hist.
#  1.4  03.10.2023    Wandtke,Andrzej          INC6475954 use table v_ref_currency_1 as to eliminate duplicates in case of 2 currencies valid in one country_1 during transition period
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_ALL_TRANSACT_1 AS
   SELECT	
   x.store_id
  ,x.client_id
  ,x.pos_terminal_id
  ,x.dat_formdate
  ,x.time_receipt_ejr
  ,x.orig_receipt_nr_ejr
  ,x.timezone_cd
  ,x.dat_dayend
  ,x.checker_id
  ,x.transactiontype_id
  ,x.cnt_receiptline_ejr
  ,x.cnt_selling_position_ejr
  ,x.cnt_discount_ejr
  ,x.cnt_deposit_ejr
  ,x.cnt_return_ejr
  ,x.cnt_void_ejr
  ,x.cnt_ean_ejr
  ,x.cnt_item_ejr
  ,x.cnt_item_weight_ejr
  ,x.cnt_mainitemgroup_ejr
  ,x.qty_piece_ejr
  ,x.val_retail_ejr
  ,x.val_retail_pos_ejr
  ,x.val_deposit_ejr
  ,x.val_discount_ejr
  ,x.val_discount_net_ejr
  ,cry.to_currency_iso_cd AS tcurrency_desc
  ,cry.rate_currency_exchange AS exchange_rate_tcurrency_eur
  ,cry.currency_iso_cd AS eur_desc
  ,x.resumed_trans_store_id_ejr
  ,x.resumed_trans_terminal_id_ejr
  ,x.resumed_trans_date_ejr
  ,x.resumed_trans_receipt_nr_ejr
  ,x.dur_service_time_ejr
  ,x.dur_pay_change_time_ejr
  ,x.val_retail_net_ejr
  ,x.timestamp_begin_ejr
  ,x.timestamp_end_ejr
  ,x.next_transactiontype_id
  ,x.rank_login_nr
  ,x.rank_logoff_nr
  ,x.next_orig_receipt_nr_ejr
  ,x.next_val_retail_ejr
  ,x.prev_orig_receipt_nr_ejr
  ,x.next_time_receipt_ejr
  ,x.prev_time_receipt_ejr
  ,x.cnt_all_deposit_back
  ,x.cnt_ke_deposit_back
  ,x.cnt_sc_deposit_back
  ,x.val_all_deposit_back
  ,x.val_all_deposit_back_net
  ,x.val_ke_deposit_back
  ,x.val_ke_deposit_back_net
  ,x.val_sc_deposit_back
  ,x.cnt_all_deposit_sell
  ,x.cnt_ke_deposit_sell
  ,x.cnt_sc_deposit_sell
  ,x.val_all_deposit_sell
  ,x.val_all_deposit_sell_net
  ,x.val_ke_deposit_sell
  ,x.val_sc_deposit_sell
  ,x.cnt_wo_deposit_voided_line
  ,x.amt_sell_item
  ,x.cnt_sell_item
  ,x.cnt_voided_line
  ,x.amt_voided_item
  ,x.val_voided_line
  ,x.val_voided_line_net
  ,x.is_voided_gt_4
  ,x.is_implausible_deposit
  ,x.is_implausible_depositv1
  ,x.is_implausible_depositv2
  ,x.is_deposit_1itm
  ,x.is_deposit_1itmv
  ,x.is_deposit_1itmc
  ,x.qty_return_ejr
  ,x.rank_terminal_login_nr
  ,x.rank_terminal_logoff_nr
  ,x.turnover_relevant_fg
  ,x.scenario_id
  ,x.cnt_all_voided_line
  ,x.implausible_depositv1_val
  ,x.implausible_depositv2_val
  ,x.is_aborted_gt10_fg
  ,x.is_lowval_fg
  ,x.is_voided_gt10_fg
  ,x.val_all_voided_line
  ,x.val_all_voided_line_net
  ,x.amt_all_voided_item
  ,x.val_sell_item
  ,x.cy_week
  ,x.cy_month
  ,x.authority_id
  ,x.qty_ke_return_ejr
  ,x.qty_sc_return_ejr
  ,x.val_ke_return_ejr
  ,x.val_sc_return_ejr
  ,x.prev_transactiontype_id
  ,cry.currency_iso_cd AS currency_iso_cd
  FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 x	

  INNER JOIN p_lew_mart_msi.v_ref_currency_1 AS cry 
  ON  x.client_id = cry.client_id 

  WHERE
  ( 
  (cry.currency_iso_cd = 'EUR' AND cry.to_currency_iso_cd = 'EUR') 
  OR 
  (cry.currency_iso_cd <> cry.to_currency_iso_cd) 
  )
;
