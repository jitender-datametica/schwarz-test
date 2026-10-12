CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_spaceman_case_orientation_2 AS SELECT case_orientation_cd,
 case_orientation_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_spaceman_case_orientation_2;