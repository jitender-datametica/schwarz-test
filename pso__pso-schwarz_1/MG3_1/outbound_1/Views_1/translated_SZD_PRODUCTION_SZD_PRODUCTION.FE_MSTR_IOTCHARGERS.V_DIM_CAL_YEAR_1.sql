CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_dim_cal_year_1 (cy, cy_offset) AS SELECT DISTINCT cy,
 cy_offset
FROM szd_production_core.t_dim_cal_month_1;