CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_agc_core_table_update_location (core_table_name, client_id, dwh_cal_dt,
loc_sid, recalc_fg, create_timestamp, dwh_load_id) AS SELECT *
FROM ldl_p_lew_process.v_agc_core_table_update_location;