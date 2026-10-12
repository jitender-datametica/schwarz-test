CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_age_range AS SELECT age_range_cd,
 age_range_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_age_range;