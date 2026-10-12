CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_lil_assort_category_descr_2 (client_id, assort_cat_sid, lang_cd,
assort_parent_cat_name, assort_cat_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 assort_cat_sid,
 lang_cd,
 assort_parent_cat_name,
 assort_cat_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_lil_assort_category_descr_2;