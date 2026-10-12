/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_ejr_show_price_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): Neue Felder - is_kleinstbon_man & is_abmeld_man.
#  1.4  08.12.2021    Wandtke,Andrzej          AP0085915_ZKP_SHOW_PRICE add column PR_SHOW_ORIG_RECEIPT_NR_EJR
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_SHOW_PRICE_2
(	
  orig_receipt_nr_ejr
, pr_show_orig_receipt_nr_ejr
, store_id	
, dat_formdate	
, pos_terminal_id	
, client_id	
, time_receipt_ejr	
, checker_id	
, next_val_retail_ejr	
, val_retail_ejr	
, next_orig_receipt_nr_ejr	
, next_time_receipt_ejr	
, transactiontype_id	
, next_transactiontype_id	
, rank_login_nr	
, is_kleinstbon	
, is_abmeldung	
, is_show_price_series	
, cnt_same_transactiontype	
, is_kleinstbon_man	
, is_abmeld_man	
)
AS	
   SELECT	
   orig_receipt_nr_ejr
,  pr_show_orig_receipt_nr_ejr
,  st_loc_sid AS store_id
,  dat_formdate
,  pos_terminal_id
,  client_id
,  time_receipt_ejr
,  checker_id
,  next_val_retail_ejr
,  val_retail_ejr
,  next_orig_receipt_nr_ejr
,  next_time_receipt_ejr
,  transactiontype_id
,  next_transactiontype_id
,  rank_login_nr
,  is_kleinstbon
,  is_abmeldung
,  is_show_price_series
,  cnt_same_transactiontype
,  is_kleinstbon_man
,  is_abmeld_man
  FROM p_lew_mart_msi.t_msi_ejr_show_price_2	
;