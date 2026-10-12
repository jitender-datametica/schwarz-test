CREATE OR REPLACE VIEW szd_fe_mstr_iotchargers.v_dim_cal_day_1 (cal_dt, cy_month, cy_week, cal_dt_offset, cy) AS SELECT
 cal_dt,
 cy_month,
 cy_week,
 cal_dt_offset,
 cy
FROM szd_core.t_dim_cal_day_1;