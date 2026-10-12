CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_meta_file_content (client_id, file_id, region_id, period_id,
src_assort_parent_cat_cd, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_meta_file_content;