CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_ejr_transactiontype_2 (client_id, recordtype_id, transactiontype_id,
transactiontype1_desc, transactiontype2_desc, transactiontype3_desc, language_id, load_id) AS SELECT client_id,
 recordtype_id,
 transactiontype_id,
 transactiontype1_desc,
 transactiontype2_desc,
 transactiontype3_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_ejr_transactiontype_2;