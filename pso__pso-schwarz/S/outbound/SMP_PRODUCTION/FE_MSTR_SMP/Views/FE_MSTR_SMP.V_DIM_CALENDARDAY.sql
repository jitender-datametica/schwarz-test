CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_calendarday (cal_dt, cy, cy_week, cy_month, busyear,
cal_dt_swday_prev_1y, cy_day_seq) AS SELECT cal_dt,
 cy,
 cy_week,
 cy_month,
 busyear,
 cal_dt_swday_prev_1y,
 cy_day_seq
FROM smp_production_data_shared_ldl.p_lew_core_t_cal_calendarday;