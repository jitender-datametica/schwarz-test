CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_cash_register_type_1 AS SELECT cash_register_type_cd,
 cash_register_type_name,
 cash_register_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_cash_register_type_1;