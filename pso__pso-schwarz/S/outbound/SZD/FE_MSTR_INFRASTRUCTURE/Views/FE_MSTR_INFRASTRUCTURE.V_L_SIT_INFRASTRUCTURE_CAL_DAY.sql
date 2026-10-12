CREATE OR REPLACE VIEW szd_fe_mstr_infrastructure.v_l_sit_infrastructure_cal_day AS SELECT cal_dt,
 cal_dt_offset,
 cy_month,
 cy
FROM szd_core.t_dim_cal_day;