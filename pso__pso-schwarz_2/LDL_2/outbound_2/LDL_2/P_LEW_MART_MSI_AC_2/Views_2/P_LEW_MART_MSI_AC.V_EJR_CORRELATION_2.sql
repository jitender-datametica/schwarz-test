CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_correlation_2 (store_id, client_id, pos_terminal_id, dat_formdate,
time_receipt_ejr, orig_receipt_nr_ejr, checker_id, authority_id, scenario_id, auth_type, val_authorised_retail_ejr,
cnt_authorised_receipt) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_correlation_2;