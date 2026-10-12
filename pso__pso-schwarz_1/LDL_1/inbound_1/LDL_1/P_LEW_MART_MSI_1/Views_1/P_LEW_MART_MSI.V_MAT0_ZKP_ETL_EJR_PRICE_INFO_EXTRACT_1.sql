CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_ZKP_ETL_EJR_PRICE_INFO_EXTRACT_1 as
   SELECT	
      st_loc_sid AS store_id,	
   client_id,	
   pos_terminal_id,	
   dat_formdate,	
   time_receipt_ejr,	
   orig_receipt_nr_ejr,	
   timezone_cd,	
   dat_dayend,	
   checker_id,	
   transactiontype_id,	
   timestamp_begin_ejr,	
   timestamp_end_ejr,	
   authority_id,	
   item_sid AS item_id,	
   price_retail_ejr,	
   mainitemgroup_id,	
   item_takeover_fg,	
   load_id	
   FROM p_lew_mart_msi.t_msi_ejr_price_info_extract_1	
;