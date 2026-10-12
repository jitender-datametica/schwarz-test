CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_missing_1 (client_id, item_missing_id, item_sid, loc_sid, storage_loc_cd,
dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_missing_id,
 item_sid,
 loc_sid,
 storage_loc_cd,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_missing_1;