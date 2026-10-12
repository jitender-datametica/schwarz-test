CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_RECEIPTLINE_NTR_EXTRACT_2 as
   SELECT	
     rlntr.store_id,	
   rlntr.client_id,	
   rlntr.pos_terminal_id,	
   rlntr.dat_formdate,	
   rlntr.time_receipt_ejr,	
   rlntr.orig_receipt_nr_ejr,	
   rlntr.orig_receipt_serial_nr_ejr,	
   rlntr.timezone_cd,	
   rlntr.dat_dayend,	
   rlntr.checker_id,	
   rlntr.transactiontype_id,	
   rlntr.barcode,	
   rlntr.item_id,	
   rlntr.mainitemgroup_id,	
   rlntr.weight_item_fg,	
   rlntr.mis_weight_fg,	
   rlntr.price_retail_ejr,	
   rlntr.price_retail_adjstd_ejr,	
   rlntr.price_type_ejr,	
   rlntr.qty_piece_ejr,	
   rlntr.qty_weight_ejr,	
   rlntr.val_retail_ejr,	
   rlntr.val_discount_ejr,	
   rlntr.pct_vat_ejr,	
   rlntr.val_vat_ejr,	
   rlntr.type_vat_ejr,	
   rlntr.discount_sid,	
   rlntr.val_retail_orig_ejr,	
   rlntr.val_discount_base_ejr,	
   rlntr.qty_discount_pos_ejr,	
   rlntr.qty_discount_hq_ejr,	
   rlntr.return_reason_cd_ejr,	
   rlntr.timestamp_begin_ejr,	
   rlntr.timestamp_end_ejr,	
   rlntr.item_entry_method_cd_ejr,	
   rlntr.price_entry_method_cd_ejr,	
   rlntr.parent_line_nr_ejr,	
   rlntr.voided_by_line_nr_ejr,	
   rlntr.authority_id,	
   rlntr.load_id	
   FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_ntr_2 rlntr	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 sst	
   ON rlntr.client_id = sst.client_id	
   AND rlntr.store_id = sst.store_id	
 WHERE rlntr.dat_formdate BETWEEN sst.dat_formdate_from   AND sst.dat_formdate_until	
;