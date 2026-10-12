CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_lil_assort_category (client_id, assort_cat_sid, src_assort_parent_cat_cd,
src_assort_cat_cd, assort_parent_cat_name, assort_cat_name, assort_cat_level, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 assort_cat_sid,
 src_assort_parent_cat_cd,
 src_assort_cat_cd,
 assort_parent_cat_name,
 assort_cat_name,
 assort_cat_level,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_lil_assort_category;