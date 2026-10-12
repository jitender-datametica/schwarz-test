CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_pos_record_type_1 (record_type_id, record_type_context_cd,
record_type_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT record_type_id,
 record_type_context_cd,
 record_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_pos_record_type_1;