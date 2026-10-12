CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_dim_cal_day (cal_dt, cy_month, cy_week, cal_dt_offset, cy)
AS SELECT cal_dt,
 cy_month,
 cy_week,
 cal_dt_offset,
 cy
FROM szd_production_core.t_dim_cal_day;