CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_orig_discount_type (orig_discount_type_sid, orig_discount_type_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT orig_discount_type_sid,
 orig_discount_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_orig_discount_type;