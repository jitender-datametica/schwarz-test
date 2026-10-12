CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_household_type AS SELECT household_type_id,
 household_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_household_type;