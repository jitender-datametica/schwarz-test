CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_PAYMENT_NTR_EXTRACT_2 as
   SELECT	
     payntr.store_id,	
   payntr.client_id,	
   payntr.pos_terminal_id,	
   payntr.dat_formdate,	
   payntr.time_receipt_ejr,	
   payntr.orig_receipt_nr_ejr,	
   payntr.orig_receipt_serial_nr_ejr,	
   payntr.timezone_cd,	
   payntr.dat_dayend,	
   payntr.checker_id,	
   payntr.transactiontype_id,	
   payntr.cnt_payment_ejr,	
   payntr.val_retail_payment_ejr,	
   payntr.tendertype_cd_ejr,	
   payntr.load_id	
   FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_ntr_2 payntr	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 sst	
   ON payntr.client_id = sst.client_id	
   AND payntr.store_id = sst.store_id	
   AND payntr.dat_formdate BETWEEN sst.dat_formdate_from   AND sst.dat_formdate_until	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 revday	
   ON payntr.dat_formdate = revday.dat_calendar	
;