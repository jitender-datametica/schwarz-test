CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_lil_period_per_region_2 (client_id, period_sid, region_sid, start_dt, end_dt,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 period_sid,
 region_sid,
 start_dt,
 end_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_lil_period_per_region_2;