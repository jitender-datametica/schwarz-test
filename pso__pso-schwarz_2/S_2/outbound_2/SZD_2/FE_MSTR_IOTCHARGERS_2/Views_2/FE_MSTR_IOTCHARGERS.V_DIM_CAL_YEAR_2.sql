CREATE OR REPLACE VIEW szd_fe_mstr_iotchargers.v_dim_cal_year_2 (cy, cy_offset) AS SELECT DISTINCT cy,
 cy_offset
FROM szd_core.t_dim_cal_month_2;