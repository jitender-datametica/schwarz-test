CREATE OR REPLACE VIEW production_production_fe_mstr_bge_palettierer.v_rel_cal_start_dt_to_cal_end_dt (cal_start_dt,
cal_end_dt) AS SELECT A1.cal_dt AS cal_start_dt,
 B1.cal_dt AS cal_end_dt
FROM (SELECT cal_dt
  FROM szd_production_core.t_dim_cal_day
  WHERE cal_dt >= DATE_ADD(CURRENT_DATE, INTERVAL - 1 YEAR)
   AND cal_dt <= CURRENT_DATE) AS A1
 INNER JOIN (SELECT cal_dt
  FROM szd_production_core.t_dim_cal_day
  WHERE cal_dt >= DATE_ADD(CURRENT_DATE, INTERVAL - 1 YEAR)
   AND cal_dt <= CURRENT_DATE) AS B1 ON A1.cal_dt <= B1.cal_dt;