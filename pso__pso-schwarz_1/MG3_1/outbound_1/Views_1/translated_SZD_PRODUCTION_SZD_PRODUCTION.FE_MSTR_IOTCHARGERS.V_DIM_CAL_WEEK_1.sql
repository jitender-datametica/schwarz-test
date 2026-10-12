CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_dim_cal_week_1 (cy_week, cy_week_offset, cy) AS SELECT cy_week
 ,
 cy_week_offset,
 CAST((cy_week - week_of_year) / 100 AS BIGNUMERIC) AS cy
FROM szd_production_core.t_dim_cal_week_1;