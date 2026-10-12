CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_lidlplus_config_client_1 (client_id, country_cd, rollout_start_dt,
full_client_rollout_dt, reporting_start_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 country_cd,
 rollout_start_dt,
 full_client_rollout_dt,
 reporting_start_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process.t_lidlplus_config_client_1;