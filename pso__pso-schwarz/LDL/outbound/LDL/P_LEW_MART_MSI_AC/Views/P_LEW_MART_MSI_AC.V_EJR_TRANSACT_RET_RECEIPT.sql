CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_transact_ret_receipt (client_id, store_id, checker_id, dat_formdate,
orig_receipt_nr_ejr, pos_terminal_id, time_receipt_ejr, receipt_check_b1, receipt_check_b2, receipt_check_b3,
receipt_check_b4, receipt_check_b5, receipt_check_b6, receipt_check_b7) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_transact_ret_receipt;