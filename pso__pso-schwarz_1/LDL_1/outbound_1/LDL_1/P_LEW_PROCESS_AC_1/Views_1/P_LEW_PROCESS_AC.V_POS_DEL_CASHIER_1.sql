CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_pos_del_cashier_1 (dwh_cal_dt_from, dwh_cal_dt_until, timestamp_start,
timestamp_end) AS SELECT dwh_cal_dt_from,
 dwh_cal_dt_until,
 timestamp_start,
 timestamp_end
FROM ldl_p_lew_process.t_pos_del_cashier_1;