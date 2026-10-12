CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_subtotal (store_id, client_id, pos_terminal_id, dat_formdate,
time_receipt_ejr, orig_receipt_nr_ejr, orig_receipt_serial_nr_ejr, timezone_cd, dat_dayend, checker_id,
transactiontype_id, timestamp_begin_ejr) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_subtotal;