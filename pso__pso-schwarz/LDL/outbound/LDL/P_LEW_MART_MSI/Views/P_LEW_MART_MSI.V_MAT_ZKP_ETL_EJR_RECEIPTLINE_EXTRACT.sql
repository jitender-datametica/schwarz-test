CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_receiptline_extract AS SELECT RCL.store_id,
 RCL.client_id,
 RCL.pos_terminal_id,
 RCL.dat_formdate,
 RCL.time_receipt_ejr,
 RCL.orig_receipt_nr_ejr,
 RCL.orig_receipt_serial_nr_ejr,
 RCL.timezone_cd,
 RCL.dat_dayend,
 RCL.checker_id,
 RCL.transactiontype_id,
 RCL.barcode,
 RCL.item_id,
 RCL.mainitemgroup_id,
 RCL.weight_item_fg,
 RCL.mis_weight_fg,
 RCL.price_retail_ejr,
 RCL.price_retail_adjstd_ejr,
 RCL.price_type_ejr,
 RCL.qty_piece_ejr,
 RCL.qty_weight_ejr,
 RCL.val_retail_ejr,
 RCL.val_discount_ejr,
 RCL.pct_vat_ejr,
 RCL.val_vat_ejr,
 RCL.type_vat_ejr,
 RCL.discount_sid,
 RCL.val_retail_orig_ejr,
 RCL.val_discount_base_ejr,
 RCL.qty_discount_pos_ejr,
 RCL.qty_discount_hq_ejr,
 RCL.return_reason_cd_ejr,
 RCL.timestamp_begin_ejr,
 RCL.timestamp_end_ejr,
 RCL.item_entry_method_cd_ejr,
 RCL.price_entry_method_cd_ejr,
 RCL.parent_line_nr_ejr,
 RCL.voided_by_line_nr_ejr,
 RCL.authority_id,
 RCL.accounting_disposition_cd_ejr,
 RCL.original_orig_store_nr_ejr,
 RCL.original_dat_formdate_ejr,
 RCL.original_orig_receipt_nr_ejr,
 RCL.original_pos_terminal_id_ejr,
 ITM.subitemgroup_id,
 RCL.load_id
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline AS RCL
 INNER JOIN ldl_p_lew_mart_msi.v_mat_itm_item AS ITM ON RCL.item_id = ITM.item_id AND RCL.client_id = ITM.client_id
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS SST ON RCL.client_id = SST.client_id AND
   RCL.store_id = SST.store_id
WHERE RCL.dat_formdate BETWEEN SST.dat_formdate_from AND SST.dat_formdate_until
  -- The following condition is optional for better performance. It uses IPE (Incremental Planning   AND Execution) to use DPE (Dynamic Partition Elimination ).

  
 AND RCL.dat_formdate >= (SELECT MIN(dat_calendar)
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS D_MIN)
 AND RCL.dat_formdate <= (SELECT MAX(dat_calendar)
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_day_wrk AS D_MAX);