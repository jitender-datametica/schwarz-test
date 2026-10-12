CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_cal_five_prev_weeks_py (cy_week, prev_week, prev_week_py,
diff_week_sequence) AS SELECT *
FROM ldl_p_lew_mart_msi.v_cal_five_prev_weeks_py;