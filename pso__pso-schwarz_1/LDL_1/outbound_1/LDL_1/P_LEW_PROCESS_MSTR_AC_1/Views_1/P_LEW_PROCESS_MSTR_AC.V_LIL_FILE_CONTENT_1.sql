CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_lil_file_content_1 (client_id, file_id, region_sid, period_sid,
src_assort_parent_cat_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 file_id,
 region_sid,
 period_sid,
 src_assort_parent_cat_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_lil_file_content_1;