CREATE OR REPLACE VIEW szd_fe_mstr_infrastructure.v_l_sit_infrastructure_cal_month AS SELECT cy_month,
 month_of_year_name,
 month_of_year_short_name,
 cy_month_offset,
 cy,
 cy_month_prev_1m
FROM szd_core.t_dim_cal_month;