CREATE OR REPLACE VIEW szd_fe_mstr_iotchargers.v_dim_cal_month (cy_month, cy, cy_month_offset) AS SELECT cy_month,
 cy,
 cy_month_offset
FROM szd_core.t_dim_cal_month;