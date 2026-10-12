CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_cal_month_1 (cy_month, busyear_qtr, month_id,
cy_month_prev_1m, cy_month_prev_1y, cy_month_prev_2y, cy, busyear, cy_month_seq, dwh_load_id, dwh_created, dwh_updated)
AS SELECT cy_month,
 busyear_qtr,
 month_id,
 cy_month_prev_1m,
 cy_month_prev_1y,
 cy_month_prev_2y,
 cy,
 busyear,
 cy_month_seq,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_cal_month_1;