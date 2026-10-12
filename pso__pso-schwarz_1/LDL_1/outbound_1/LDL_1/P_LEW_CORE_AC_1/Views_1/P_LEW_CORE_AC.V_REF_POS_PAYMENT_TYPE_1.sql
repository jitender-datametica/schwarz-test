CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_pos_payment_type_1 (payment_type_id, payment_type_descr, dwh_load_id,
dwh_created, dwh_updated) AS SELECT payment_type_id,
 payment_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_pos_payment_type_1;