CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_all_transactlines (store_id, client_id, pos_terminal_id, dat_formdate
, time_receipt_ejr, orig_receipt_nr_ejr, orig_receipt_serial_nr_ejr, timezone_cd, dat_dayend, checker_id,
transactiontype_id, barcode, item_id, mainitemgroup_id, time_halfhour_id, qty_piece_ejr, qty_weight_ejr,
price_retail_ejr, price_retail_adjstd_ejr, price_retail_net_adjstd_ejr, price_type_ejr, mis_weight_fg, val_retail_ejr,
val_retail_net_ejr, val_discount_ejr, val_discount_net_ejr, discount_id, val_retail_orig_ejr, val_discount_base_ejr,
qty_discount_pos_ejr, qty_discount_hq_ejr, return_reason_cd_ejr, timestamp_begin_ejr, timestamp_end_ejr,
item_entry_method_cd_ejr, price_entry_method_cd_ejr, parent_line_nr_ejr, voided_by_line_nr_ejr, val_vat_base_ejr,
val_vat_ejr, pct_vat_ejr, cnt_payment_ejr, currency_iso_cd, header_transactiontype_id, scenario_id, tendertype_cd_ejr,
cy_week, cy_month, original_orig_store_nr_ejr, original_dat_formdate_ejr, original_orig_receipt_nr_ejr,
original_pos_terminal_id_ejr, authority_id) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_all_transactlines;