CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.mv_l_lifecycle_rvm_cal_week_1 AS SELECT cy_week,
 week_of_year,
 cy_week_begin_week_part,
 cy_week_end_week_part,
 cy_week_begin_dt,
 cy_week_end_dt,
 cy_week_week_part_cnt,
 cy_week_prev_1w,
 CONCAT(EXTRACT(YEAR FROM DATE_ADD(cy_week_begin_dt, INTERVAL - 2 WEEK)), EXTRACT(ISOWEEK FROM DATE_ADD(cy_week_begin_dt
    ,INTERVAL - 2 WEEK))) AS cy_week_prev_2w,
 CONCAT(EXTRACT(YEAR FROM DATE_ADD(cy_week_begin_dt, INTERVAL - 3 WEEK)), EXTRACT(ISOWEEK FROM DATE_ADD(cy_week_begin_dt
    ,INTERVAL - 3 WEEK))) AS cy_week_prev_3w,
 CONCAT(EXTRACT(YEAR FROM DATE_ADD(cy_week_begin_dt, INTERVAL - 4 WEEK)), EXTRACT(ISOWEEK FROM DATE_ADD(cy_week_begin_dt
    ,INTERVAL - 4 WEEK))) AS cy_week_prev_4w,
 cy_week_prev_1y,
 cy_week_prev_2y,
 cy_week_prev_3y,
 cy_week_prev_4y,
 cy_week_prev_5y,
 IF(DATE_ADD(DATE_ADD(LAST_DAY(CURRENT_DATE, ISOWEEK), INTERVAL 1 DAY), INTERVAL - 1 WEEK) = CURRENT_DATE OR DATE_ADD(DATE_ADD(LAST_DAY(CURRENT_DATE
       , ISOWEEK), INTERVAL 2 DAY), INTERVAL - 1 WEEK) = CURRENT_DATE, cy_week_offset - 1, cy_week_offset) AS
 cy_week_offset,
 cy_week_short_name,
 cy_week_name,
 dwh_src_file_name,
 dwh_created_tmsp AS dwh_updated_tmsp
FROM szd_core.t_dim_cal_week_1
WHERE cy_week <= CAST(IF(LENGTH(SUBSTR(SAFE_CAST(EXTRACT(ISOWEEK FROM CURRENT_DATE) as STRING), 1, 10)) = 1, CONCAT(EXTRACT(YEAR FROM CURRENT_DATE), '0', EXTRACT(ISOWEEK FROM CURRENT_DATE)), CONCAT(EXTRACT(YEAR FROM CURRENT_DATE), EXTRACT(ISOWEEK FROM CURRENT_DATE))) AS FLOAT64)
  
ORDER BY cy_week DESC NULLS FIRST;