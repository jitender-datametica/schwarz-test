CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ejr_receiptheader_2 (client_id, store_id, header_collection,
pos_terminal_id, time_receipt_ejr, time_halfhour_id, time_hour_id, receipt_for_count_id, orig_receipt_nr_ejr,
orig_receipt_serial_nr_ejr, timezone_cd, dat_dayend, dat_formdate, checker_id, transactiontype_id, cnt_receiptline_ejr,
cnt_selling_position_ejr, cnt_discount_ejr, cnt_deposit_ejr, cnt_return_ejr, cnt_void_ejr, cnt_ean_ejr, cnt_item_ejr,
cnt_item_weight_ejr, cnt_mainitemgroup_ejr, qty_piece_ejr, val_retail_ejr, val_retail_net_ejr, val_retail_pos_ejr,
val_retail_net_pos_ejr, val_deposit_ejr, val_deposit_net_ejr, val_discount_ejr, val_discount_net_ejr,
resumed_trans_store_id_ejr, resumed_trans_terminal_id_ejr, resumed_trans_date_ejr, resumed_trans_receipt_nr_ejr,
dur_service_time_ejr, dur_pay_change_time_ejr, timestamp_begin_ejr, timestamp_end_ejr, currency_iso_cd, customer_nr,
lidlplus_customer_cd, lidlplus_ident_type_cd) AS SELECT *
FROM ldl_p_lew_mart_lead.v_ejr_receiptheader_2;