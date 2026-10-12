CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_lidlplus_correction_receiptheader_log_2 (client_id, yearmonth, wh_id,
orig_store_nr, dwh_cal_dt, number_of_updated_rows, dwh_created) AS SELECT client_id,
 yearmonth,
 wh_id,
 orig_store_nr,
 dwh_cal_dt,
 number_of_updated_rows,
 dwh_created
FROM ldl_p_lew_process.t_lidlplus_correction_receiptheader_log_2;