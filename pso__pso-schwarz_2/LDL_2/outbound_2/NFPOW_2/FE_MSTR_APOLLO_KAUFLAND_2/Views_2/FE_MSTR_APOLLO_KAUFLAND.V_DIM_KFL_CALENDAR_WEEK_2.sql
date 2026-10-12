CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo_kaufland.v_dim_kfl_calendar_week_2 (cal_week, cal_week_begin_dt,
cal_week_end_dt, kfl_prev_1y_cal_week, kfl_prev_2y_cal_week, kfl_bus_week, kfl_prev_1y_bus_week, kfl_cal_week_offset,
kfl_completed_cal_week_offset) AS SELECT cal_week,
 cal_week_begin_dt,
 cal_week_end_dt,
 kfl_prev_1y_cal_week,
 kfl_prev_2y_cal_week,
 kfl_bus_week,
 kfl_prev_1y_bus_week,
 kfl_cal_week_offset,
 kfl_completed_cal_week_offset
FROM nfpow_core.t_dim_kfl_calendar_week_2;