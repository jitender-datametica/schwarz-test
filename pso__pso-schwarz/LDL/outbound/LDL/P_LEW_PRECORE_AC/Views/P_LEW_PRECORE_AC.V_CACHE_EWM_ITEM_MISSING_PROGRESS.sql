CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_ewm_item_missing_progress (client_id, item_missing_id, orig_item_nr
, case_size, item_sid, loc_sid, storage_loc_cd, missing_state_cd, missing_reason_cd, creation_dttm, change_dttm,
dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_missing_id,
 orig_item_nr,
 case_size,
 item_sid,
 loc_sid,
 storage_loc_cd,
 missing_state_cd,
 missing_reason_cd,
 creation_dttm,
 change_dttm,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_ewm_item_missing_progress;