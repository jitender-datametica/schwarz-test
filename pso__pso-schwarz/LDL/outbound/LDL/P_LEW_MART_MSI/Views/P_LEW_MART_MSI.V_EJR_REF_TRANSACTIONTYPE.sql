CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_ref_transactiontype (transactiontype_id, trans_desc, trans_desc_en,
trans_ref, language_id) AS SELECT transactiontype_id,
 trans_desc,
 'N/A' AS trans_desc_en,
 trans_ref,
 language_id
FROM ldl_p_lew_mart_msi.t_msi_ejr_ref_transactiontype;