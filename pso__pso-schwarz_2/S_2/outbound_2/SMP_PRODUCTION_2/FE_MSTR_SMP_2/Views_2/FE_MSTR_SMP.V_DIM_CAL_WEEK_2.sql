CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_cal_week_2 (cy_week, cy_week_seq) AS SELECT DISTINCT cy_week,
 cy_week_seq
FROM smp_production_data_shared_ldl.p_lew_core_t_cal_calendarday_2;