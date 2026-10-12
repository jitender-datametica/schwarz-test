CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_delete_day_store_log_1 AS SELECT client_id,
 orig_store_nr,
 dat_dayend,
 delete_area,
 user_input,
 request_no,
 done_fg,
 done_ts,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process.t_delete_day_store_log_1;