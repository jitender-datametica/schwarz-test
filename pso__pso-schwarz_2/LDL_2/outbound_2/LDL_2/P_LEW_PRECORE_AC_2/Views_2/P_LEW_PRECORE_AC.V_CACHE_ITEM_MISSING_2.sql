CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_item_missing_2 (client_id, item_missing_id, item_sid, loc_sid,
storage_loc_cd, dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_missing_id,
 item_sid,
 loc_sid,
 storage_loc_cd,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_item_missing_2;