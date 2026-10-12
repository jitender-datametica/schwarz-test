CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_gender_2 AS SELECT gender_cd,
 gender_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_gender_2;