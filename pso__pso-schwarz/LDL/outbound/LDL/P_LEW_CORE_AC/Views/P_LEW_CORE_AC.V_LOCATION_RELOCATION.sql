CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_location_relocation (client_id, loc_sid, loc_sid_following, dwh_cal_dt,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 loc_sid,
 loc_sid_following,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_location_relocation;