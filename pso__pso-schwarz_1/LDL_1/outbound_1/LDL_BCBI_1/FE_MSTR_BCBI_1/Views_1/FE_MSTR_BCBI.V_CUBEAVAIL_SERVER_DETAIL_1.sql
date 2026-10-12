CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_cubeavail_server_detail_1 AS WITH CUBEAVAIL AS (SELECT DISTINCT T.job_id,
   EXP.day,
   CALWEEK.week_of_year AS week,
   CALWEEK.cy_week_short_name AS week_name,
   CALWEEK.cy_week AS week_id,
   EXP.month_of_year AS month,
   EXP.month_of_year_name AS month_name,
   EXP.cy_month AS month_id,
   EXP.cy AS year,
   EXP.bus_year,
   EXP.zone,
   EXP.project_id,
   EXP.project_name,
   EXP.cube_id,
   EXP.cube_name,
   EXP.subcube_id,
   EXP.subcube_name,
   T.cubeactionid,
    CASE
    WHEN T.cubeactionid IN (65536, 131073)
    THEN 'Cubing Server'
    ELSE 'Copy Server'
    END AS cubeaction,
   EXP.iserver_id,
   EXP.iserver_name,
   EXP.first_solution_id,
   EXP.first_solution_name,
   EXP.sec_solution_id,
   EXP.sec_solution_name,
   T.starttime AS start_time,
   T.finishtime AS end_time,
   T.job_duration_min,
   T.error_id,
   T.error_desc,
   T.result_rows,
   T.sql_passes,
    CASE
    WHEN T.starttime IS NULL AND T.finishtime IS NULL
    THEN 'Nicht Gestartet'
    WHEN T.starttime IS NOT NULL AND T.finishtime IS NULL AND T.error_id = 0
    THEN 'Gestartet'
    WHEN T.starttime IS NOT NULL AND T.error_id = 1
    THEN 'Abgebrochen'
    WHEN T.starttime IS NOT NULL AND T.error_id = 0 AND T.finishtime IS NOT NULL
    THEN 'Durchgelaufen'
    ELSE NULL
    END AS cubing_status,
    CASE
    WHEN CASE
      WHEN T.starttime IS NULL AND T.finishtime IS NULL
      THEN 'Nicht Gestartet'
      WHEN T.starttime IS NOT NULL AND T.finishtime IS NULL AND T.error_id = 0
      THEN 'Gestartet'
      WHEN T.starttime IS NOT NULL AND T.error_id = 1
      THEN 'Abgebrochen'
      WHEN T.starttime IS NOT NULL AND T.error_id = 0 AND T.finishtime IS NOT NULL
      THEN 'Durchgelaufen'
      ELSE NULL
      END = 'Durchgelaufen'
    THEN CASE
     WHEN EXP.zone = 'EU' AND TIME(T.finishtime) BETWEEN TIME(TIME '07:31:00') AND (TIME(TIME '13:00:00')) OR EXP.zone =
        'US' AND TIME(T.finishtime) BETWEEN TIME(TIME '13:30:00') AND (TIME(TIME '18:00:00'))
     THEN 'VVTA'
     WHEN EXP.zone = 'EU' AND TIME(T.finishtime) BETWEEN TIME(TIME '13:00:00') AND (TIME(TIME '22:00:00')) OR EXP.zone =
        'US' AND TIME(T.finishtime) BETWEEN TIME(TIME '18:00:00') AND (TIME(TIME '22:00:00'))
     THEN 'NVTA'
     WHEN EXP.zone = 'EU' AND TIME(T.finishtime) BETWEEN TIME(TIME '04:00:00') AND (TIME(TIME '07:31:00')) OR EXP.zone =
        'US' AND TIME(T.finishtime) BETWEEN TIME(TIME '10:20:00') AND (TIME(TIME '13:30:00'))
     THEN 'VTA'
     ELSE NULL
     END
    WHEN CASE
       WHEN T.starttime IS NULL AND T.finishtime IS NULL
       THEN 'Nicht Gestartet'
       WHEN T.starttime IS NOT NULL AND T.finishtime IS NULL AND T.error_id = 0
       THEN 'Gestartet'
       WHEN T.starttime IS NOT NULL AND T.error_id = 1
       THEN 'Abgebrochen'
       WHEN T.starttime IS NOT NULL AND T.error_id = 0 AND T.finishtime IS NOT NULL
       THEN 'Durchgelaufen'
       ELSE NULL
       END = 'Gestartet' AND (EXP.zone = 'EU' AND CURRENT_TIME > TIME(TIME '07:31:00') OR EXP.zone = 'US' AND
         CURRENT_TIME > TIME(TIME '13:30:00'))
    THEN 'NVTA'
    ELSE ''
    END AS vta_status
  FROM ldl_bcbi_fe_mstr_bcbi.v_cubeavail_expected_1 AS EXP
   LEFT JOIN (SELECT *
    FROM ldl_bcbi_fe_mstr_bcbi.v_cubeavail_1
    WHERE TIME(finishtime) BETWEEN TIME(TIME '04:00:00') AND (TIME(TIME '22:31:00'))) AS T ON EXP.zone = T.zone AND DATE(T
        .starttime) = EXP.day AND EXP.subcube_id = T.report_id AND EXP.iserver_name = T.servermachine
   LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_dim_cal_week_1 AS CALWEEK ON EXP.cy_week = CALWEEK.cy_week) (SELECT *
  FROM CUBEAVAIL
  WHERE (zone, day, project_name, cube_name, subcube_name, iserver_name, end_time) IN (SELECT (zone, day, project_name,
       cube_name, subcube_name, iserver_name, end_time)
     FROM (SELECT DISTINCT zone,
        day,
        project_name,
        cube_name,
        subcube_name,
        iserver_name,
        MIN(end_time) AS end_time
       FROM CUBEAVAIL
       WHERE error_id <> 1
       GROUP BY zone,
        day,
        project_name,
        cube_name,
        subcube_name,
        iserver_name,
        error_id) AS t11));