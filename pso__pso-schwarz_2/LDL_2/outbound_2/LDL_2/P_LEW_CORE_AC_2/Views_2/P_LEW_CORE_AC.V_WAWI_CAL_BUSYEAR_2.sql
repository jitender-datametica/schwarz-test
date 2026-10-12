CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_busyear_2 (busyear, busyear_begin_month, busyear_end_month,
busyear_calculator, cy_by_sequence) AS SELECT busyear,
 busyear_begin_month,
 busyear_end_month,
 busyear_calculator,
 cy_by_sequence
FROM ldl_p_lew_core.t_wawi_cal_busyear_2;