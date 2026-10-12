CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_item_missing_progress_1 (client_id, item_missing_id,
item_missing_progress_id, missing_activity_cd, missing_state_cd, missing_state_prev_cd, missing_reason_cd,
missing_reason_prev_cd, creation_dttm, change_dttm, dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 item_missing_id,
 item_missing_progress_id,
 missing_activity_cd,
 missing_state_cd,
 missing_state_prev_cd,
 missing_reason_cd,
 missing_reason_prev_cd,
 creation_dttm,
 change_dttm,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_item_missing_progress_1;