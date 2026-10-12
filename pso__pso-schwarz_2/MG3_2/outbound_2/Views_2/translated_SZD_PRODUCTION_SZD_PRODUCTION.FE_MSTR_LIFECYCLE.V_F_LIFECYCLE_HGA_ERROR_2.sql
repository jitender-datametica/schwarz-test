CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_f_lifecycle_hga_error_2 AS WITH arr_cte AS (SELECT DISTINCT
   hga_sid,
   error_tmsp,
   hga_error_cd,
   hga_error_type_id,
   error_status_fg,
   is_in_operation_fg,
   manufacturer_sid,
   dwh_created_tmsp,
   dwh_updated_tmsp,
   ROW_NUMBER() OVER (ORDER BY hga_sid IS NULL, hga_sid, error_tmsp IS NULL, error_tmsp, hga_error_cd IS NULL,
      hga_error_cd, error_status_fg IS NULL DESC, error_status_fg DESC, hga_error_type_id IS NULL, hga_error_type_id,
      is_in_operation_fg IS NULL, is_in_operation_fg, manufacturer_sid IS NULL, manufacturer_sid, dwh_created_tmsp
      IS NULL, dwh_created_tmsp, dwh_updated_tmsp IS NULL, dwh_updated_tmsp) AS row_sort
  FROM szd_production_core.t_fact_hga_error_2), errend_cte AS (SELECT hga_sid,
   hga_error_cd,
   manufacturer_sid,
   error_tmsp AS error_start_tmsp,
   row_sort,
   COALESCE(LEAD(error_tmsp) OVER (PARTITION BY CAST(manufacturer_sid AS STRING), CAST(hga_sid AS STRING), CAST(hga_error_type_id AS STRING)
       , hga_error_cd ORDER BY row_sort IS NULL, row_sort), CAST(CONCAT(DATE(error_tmsp), ' 23:59:59.999') AS TIMESTAMP)
    ) AS error_end_tmsp,
   error_status_fg,
   is_in_operation_fg,
   hga_error_type_id
  FROM arr_cte
  WHERE hga_error_cd NOT IN (SELECT hga_error_cd
     FROM szd_production_core.t_dim_hga_error_2
     WHERE UPPER(hga_error_descr) LIKE 'STANDBY')), err_cte AS (SELECT hga_sid,
   DATE(error_start_tmsp) AS error_date,
   hga_error_cd,
   manufacturer_sid,
   error_start_tmsp,
   error_end_tmsp,
   is_in_operation_fg
  FROM errend_cte
  WHERE error_status_fg) (SELECT t9.hga_sid,
   hgd1.cal_dt AS error_date,
   t9.hga_error_cd,
   t9.manufacturer_sid,
   t9.error_start_tmsp,
   t9.error_end_tmsp,
   EXTRACT(HOUR FROM t9.error_start_tmsp) AS start_hour,
   hgl1.hga_error_grp_sid,
    CASE
    WHEN NOT t9.is_in_operation_fg
    THEN 'ja'
    WHEN t9.is_in_operation_fg
    THEN 'nein'
    ELSE NULL
    END AS out_of_order,
    CASE
    WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_end_tmsp AS TIMESTAMP)) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_start_tmsp AS TIMESTAMP)
         ) AS DATETIME), DAY) + 1 = 1
    THEN ROUND(TIMESTAMP_DIFF(CAST(t9.error_end_tmsp AS DATETIME), CAST(t9.error_start_tmsp AS DATETIME), MILLISECOND) /
      1000)
    WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_end_tmsp AS TIMESTAMP)) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_start_tmsp AS TIMESTAMP)
          ) AS DATETIME), DAY) + 1 = 2 AND hgd1.cal_dt = DATE(t9.error_start_tmsp)
    THEN ROUND(TIMESTAMP_DIFF(CAST(CAST(CONCAT(DATE(t9.error_start_tmsp), ' 23:59:59.999') AS TIMESTAMP)
        AS DATETIME), CAST(t9.error_start_tmsp AS DATETIME), MILLISECOND) / 1000)
    WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_end_tmsp AS TIMESTAMP)) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_start_tmsp AS TIMESTAMP)
          ) AS DATETIME), DAY) + 1 = 2 AND hgd1.cal_dt = DATE(t9.error_end_tmsp)
    THEN ROUND(TIMESTAMP_DIFF(CAST(t9.error_end_tmsp AS DATETIME), CAST(CAST(CONCAT(DATE(t9.error_end_tmsp), ' 00:00:00.000') AS TIMESTAMP)
        AS DATETIME), MILLISECOND) / 1000)
    WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_end_tmsp AS TIMESTAMP)) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_start_tmsp AS TIMESTAMP)
          ) AS DATETIME), DAY) + 1 > 2 AND hgd1.cal_dt = DATE(t9.error_start_tmsp)
    THEN ROUND(TIMESTAMP_DIFF(CAST(CAST(CONCAT(DATE(t9.error_start_tmsp), ' 23:59:59.999') AS TIMESTAMP)
        AS DATETIME), CAST(t9.error_start_tmsp AS DATETIME), MILLISECOND) / 1000)
    WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_end_tmsp AS TIMESTAMP)) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_start_tmsp AS TIMESTAMP)
           ) AS DATETIME), DAY) + 1 > 2 AND hgd1.cal_dt <> DATE(t9.error_start_tmsp) AND hgd1.cal_dt <> DATE(t9.error_end_tmsp
       )
    THEN 86400
    WHEN DATETIME_DIFF(CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_end_tmsp AS TIMESTAMP)) AS DATETIME), CAST(FORMAT_TIMESTAMP('%F %H:%M:%E6S', CAST(t9.error_start_tmsp AS TIMESTAMP)
          ) AS DATETIME), DAY) + 1 > 2 AND hgd1.cal_dt = DATE(t9.error_end_tmsp)
    THEN ROUND(TIMESTAMP_DIFF(CAST(t9.error_end_tmsp AS DATETIME), CAST(CAST(CONCAT(DATE(t9.error_end_tmsp), ' 00:00:00.000') AS TIMESTAMP)
        AS DATETIME), MILLISECOND) / 1000)
    ELSE NULL
    END AS error_time
  FROM err_cte AS t9
   INNER JOIN szd_production_core.t_dim_cal_day_2 AS hgd1 ON hgd1.cal_dt >= DATE(t9.error_start_tmsp) AND hgd1.cal_dt <=
     DATE(t9.error_end_tmsp)
   LEFT JOIN szd_production_fe_mstr_lifecycle.v_l_lifecycle_hga_error_2 AS hgl1 ON t9.hga_error_cd = hgl1.hga_error_cd AND
     t9.manufacturer_sid = hgl1.manufacturer_sid);