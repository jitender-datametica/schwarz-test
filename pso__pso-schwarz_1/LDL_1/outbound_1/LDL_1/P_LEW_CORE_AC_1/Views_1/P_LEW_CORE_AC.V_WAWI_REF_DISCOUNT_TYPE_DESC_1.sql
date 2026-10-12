CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_discount_type_desc_1 (discount_type_id, discount_type_desc,
language_id, load_id) AS SELECT discount_type_id,
 discount_type_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_discount_type_desc_1;