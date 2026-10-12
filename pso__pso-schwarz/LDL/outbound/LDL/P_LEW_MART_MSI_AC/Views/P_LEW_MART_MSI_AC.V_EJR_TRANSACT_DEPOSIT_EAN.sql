CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_transact_deposit_ean (client_id, store_id, pos_terminal_id,
time_receipt_ejr, dat_formdate, orig_receipt_nr_ejr, checker_id, barcode, pfand_ean, cnt_all_deposit_ean_cnt,
cnt_man_deposit_ean, cnt_all_deposit_ean) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_transact_deposit_ean;