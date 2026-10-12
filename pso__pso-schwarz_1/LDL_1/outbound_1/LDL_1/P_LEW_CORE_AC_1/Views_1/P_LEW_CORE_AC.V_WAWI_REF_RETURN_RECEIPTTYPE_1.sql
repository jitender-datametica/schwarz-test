CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_return_receipttype_1 (return_receipttype_id, return_receipttype_desc,
language_id, load_id) AS SELECT return_receipttype_id,
 return_receipttype_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_return_receipttype_1;