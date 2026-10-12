CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_RECEIPTLINE_EXTRACT_1
AS	
   SELECT	
     rcl.store_id,	
   rcl.client_id,	
   rcl.pos_terminal_id,	
   rcl.dat_formdate,	
   rcl.time_receipt_ejr,	
   rcl.orig_receipt_nr_ejr,	
   rcl.orig_receipt_serial_nr_ejr,	
   rcl.timezone_cd,	
   rcl.dat_dayend,	
   rcl.checker_id,	
   rcl.transactiontype_id,	
   rcl.barcode,	
   rcl.item_id,	
   rcl.mainitemgroup_id,	
   rcl.weight_item_fg,	
   rcl.mis_weight_fg,	
   rcl.price_retail_ejr,	
   rcl.price_retail_adjstd_ejr,	
   rcl.price_type_ejr,	
   rcl.qty_piece_ejr,	
   rcl.qty_weight_ejr,	
   rcl.val_retail_ejr,	
   rcl.val_discount_ejr,	
   rcl.pct_vat_ejr,	
   rcl.val_vat_ejr,	
   rcl.type_vat_ejr,	
   rcl.discount_sid,	
   rcl.val_retail_orig_ejr,	
   rcl.val_discount_base_ejr,	
   rcl.qty_discount_pos_ejr,	
   rcl.qty_discount_hq_ejr,	
   rcl.return_reason_cd_ejr,	
   rcl.timestamp_begin_ejr,	
   rcl.timestamp_end_ejr,	
   rcl.item_entry_method_cd_ejr,	
   rcl.price_entry_method_cd_ejr,	
   rcl.parent_line_nr_ejr,	
   rcl.voided_by_line_nr_ejr,	
   rcl.authority_id,	
   rcl.accounting_disposition_cd_ejr,	
   rcl.original_orig_store_nr_ejr,	
   rcl.original_dat_formdate_ejr,	
   rcl.original_orig_receipt_nr_ejr,	
   rcl.original_pos_terminal_id_ejr,	
   itm.subitemgroup_id,	
   rcl.load_id	
   FROM  p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_1 rcl	
   INNER JOIN  p_lew_mart_msi.v_mat_itm_item_1 itm	
   ON rcl.item_id = itm.item_id	
   AND rcl.client_id = itm.client_id	
   INNER JOIN  p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 sst	
   ON rcl.client_id = sst.client_id	
   AND rcl.store_id = sst.store_id	
 WHERE rcl.dat_formdate BETWEEN sst.dat_formdate_from   AND sst.dat_formdate_until	
 -- The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).	
   AND rcl.dat_formdate >= (SELECT Min(d_min.dat_calendar) FROM  p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 d_min)	
   AND rcl.dat_formdate <= (SELECT Max(d_max.dat_calendar) FROM  p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk_1 d_max)	
;