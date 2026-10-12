CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_PRICE_INFO_EXTRACT_1 as
   SELECT	
     prc.store_id,	
   prc.client_id,	
   prc.pos_terminal_id,	
   prc.dat_formdate,	
   prc.time_receipt_ejr,	
   prc.orig_receipt_nr_ejr,	
   prc.timezone_cd,	
   prc.dat_dayend,	
   prc.checker_id,	
   prc.transactiontype_id,	
   prc.timestamp_begin_ejr,	
   prc.timestamp_end_ejr,	
   prc.authority_id,	
   prc.item_id,	
   prc.price_retail_ejr,	
   prc.mainitemgroup_id,	
   prc.item_takeover_fg,	
   prc.load_id	
   FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_price_info_1 prc	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 sst	
   ON prc.client_id = sst.client_id	
   AND prc.store_id = sst.store_id	
   AND prc.dat_formdate BETWEEN sst.dat_formdate_from   AND sst.dat_formdate_until	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 revday	
   ON prc.dat_formdate = revday.dat_calendar	
;