CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_TAX_EXTRACT_2 as
   SELECT	
     tax.store_id,	
   tax.client_id,	
   tax.pos_terminal_id,	
   tax.dat_formdate,	
   tax.time_receipt_ejr,	
   tax.orig_receipt_nr_ejr,	
   tax.orig_receipt_serial_nr_ejr,	
   tax.timezone_cd,	
   tax.dat_dayend,	
   tax.checker_id,	
   tax.transactiontype_id,	
   tax.val_vat_base_ejr,	
   tax.val_vat_ejr,	
   tax.pct_vat_ejr,	
   tax.load_id	
   FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_tax_2 tax	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 sst	
   ON tax.client_id = sst.client_id	
   AND tax.store_id = sst.store_id	
   AND tax.dat_formdate BETWEEN sst.dat_formdate_from   AND sst.dat_formdate_until	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_2 revday	
   ON tax.dat_formdate = revday.dat_calendar	
;