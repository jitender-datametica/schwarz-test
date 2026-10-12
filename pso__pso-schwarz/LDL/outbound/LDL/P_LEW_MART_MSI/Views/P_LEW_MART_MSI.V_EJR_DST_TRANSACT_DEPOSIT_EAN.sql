CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_dst_transact_deposit_ean AS SELECT DISTINCT client_id,
 store_id,
 pos_terminal_id,
 time_receipt_ejr,
 dat_formdate,
 orig_receipt_nr_ejr,
 checker_id,
 pfand_ean
FROM ldl_p_lew_mart_msi.v_ejr_transact_deposit_ean;