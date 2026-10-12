CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_ZKP_ETL_EJR_PAYMENT_EXTRACT as
      SELECT	
         st_loc_sid AS store_id,	
      client_id,	
      pos_terminal_id,	
      dat_formdate,	
      time_receipt_ejr,	
      orig_receipt_nr_ejr,	
      orig_receipt_serial_nr_ejr,	
      timezone_cd,	
      dat_dayend,	
      checker_id,	
      transactiontype_id,	
      cnt_payment_ejr,	
      val_retail_payment_ejr,	
      tendertype_cd_ejr,	
      load_id	
      FROM p_lew_mart_msi.t_msi_ejr_payment_extract	
;