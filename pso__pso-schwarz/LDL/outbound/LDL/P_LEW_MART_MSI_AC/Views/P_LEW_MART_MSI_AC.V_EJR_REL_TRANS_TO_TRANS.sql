CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_rel_trans_to_trans (c_store_id, c_client_id, c_pos_terminal_id,
c_dat_formdate, c_time_receipt_ejr, c_orig_receipt_nr_ejr, c_checker_id, c_transaction_type_id, p_store_id, p_client_id
, p_pos_terminal_id, p_dat_formdate, p_time_receipt_ejr, p_proof_object_nr_ejr, p_checker_id, scenario_group_id,
resumed_trans_seqnr, p_timestamp_proof_ejr, p_val_retail_ejr) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_rel_trans_to_trans;