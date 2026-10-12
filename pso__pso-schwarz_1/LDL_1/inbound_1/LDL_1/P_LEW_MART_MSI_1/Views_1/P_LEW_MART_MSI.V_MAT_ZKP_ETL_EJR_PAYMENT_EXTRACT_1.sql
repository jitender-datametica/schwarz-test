CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_PAYMENT_EXTRACT_1 as
   SELECT	
     paym.store_id,	
   paym.client_id,	
   paym.pos_terminal_id,	
   paym.dat_formdate,	
   paym.time_receipt_ejr,	
   paym.orig_receipt_nr_ejr,	
   paym.orig_receipt_serial_nr_ejr,	
   paym.timezone_cd,	
   paym.dat_dayend,	
   paym.checker_id,	
   paym.transactiontype_id,	
   paym.cnt_payment_ejr,	
   paym.val_retail_payment_ejr,	
   paym.tendertype_cd_ejr,	
   paym.load_id	
   FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_1 paym	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 sst	
   ON paym.client_id = sst.client_id	
   AND paym.store_id = sst.store_id	
   AND paym.dat_formdate BETWEEN sst.dat_formdate_from   AND sst.dat_formdate_until	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 revday	
   ON paym.dat_formdate = revday.dat_calendar	
   -- The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).	
   WHERE paym.dat_formdate >= (SELECT Min(d_min.dat_calendar) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 d_min)	
   AND paym.dat_formdate <= (SELECT Max(d_max.dat_calendar) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 d_max)	
;