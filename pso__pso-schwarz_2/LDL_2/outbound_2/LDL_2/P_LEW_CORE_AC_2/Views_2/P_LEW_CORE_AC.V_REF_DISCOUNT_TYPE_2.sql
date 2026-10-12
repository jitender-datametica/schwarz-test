CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_discount_type_2 (discount_type_cd, discount_type_short_descr,
discount_type_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT discount_type_cd,
 discount_type_short_descr,
 discount_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_discount_type_2;