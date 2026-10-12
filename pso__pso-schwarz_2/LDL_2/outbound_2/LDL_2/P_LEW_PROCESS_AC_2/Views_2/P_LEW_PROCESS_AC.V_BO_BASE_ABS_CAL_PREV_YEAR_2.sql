CREATE OR REPLACE VIEW ldl_p_lew_process_ac.v_bo_base_abs_cal_prev_year_2 (cal_dt, cy_week, cy_week_seq, cy_month) AS
SELECT cal_dt,
 cy_week,
 cy_week_seq,
 cy_month
FROM ldl_p_lew_process.t_bo_base_abs_cal_prev_year_2;