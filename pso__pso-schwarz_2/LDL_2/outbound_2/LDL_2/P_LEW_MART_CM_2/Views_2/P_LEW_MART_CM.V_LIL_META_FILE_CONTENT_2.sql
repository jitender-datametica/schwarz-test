CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_meta_file_content_2 (client_id, file_id, region_id, period_id,
src_assort_parent_cat_cd, dwh_created, dwh_updated) AS SELECT CON.client_id,
 CON.file_id,
 REG.region_id,
 PER.period_id,
 CON.src_assort_parent_cat_cd,
 CON.dwh_created,
 CON.dwh_updated
FROM ldl_p_lew_process_mstr_ac.v_lil_file_content_2 AS CON
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region_2 AS REG ON CON.region_sid = REG.region_sid
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_period_2 AS PER ON CON.period_sid = PER.period_sid;