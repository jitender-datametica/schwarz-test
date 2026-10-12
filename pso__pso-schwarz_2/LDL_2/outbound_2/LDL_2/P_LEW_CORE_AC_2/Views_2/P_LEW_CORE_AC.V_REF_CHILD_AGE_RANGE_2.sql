CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_child_age_range_2 AS SELECT child_age_range_cd,
 child_age_range_name,
 child_age_range_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_child_age_range_2;