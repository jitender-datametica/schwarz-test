CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_ejr_code_mappings (recordtype, transactiontype_id, description,
dest_script, dest_table, dat_lastedit, dat_rec_start, dat_rec_end) AS SELECT recordtype,
 transactiontype_id,
 description,
 dest_script,
 dest_table,
 dat_lastedit,
 dat_rec_start,
 dat_rec_end
FROM ldl_p_lew_core.t_wawi_ref_ejr_code_mappings;