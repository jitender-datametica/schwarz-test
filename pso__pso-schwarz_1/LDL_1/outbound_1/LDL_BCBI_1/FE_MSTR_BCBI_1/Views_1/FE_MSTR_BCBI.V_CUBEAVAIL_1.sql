CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_cubeavail_1 AS SELECT CASE
  WHEN EXTRACT(HOUR FROM starttime) < 10 OR EXTRACT(HOUR FROM starttime) = 10 AND EXTRACT(MINUTE FROM starttime) < 20
  THEN 'EU'
  ELSE 'US'
  END AS zone,
 rt_is_rep_job_id AS job_id,
 rt_is_proj_id AS project_id,
 rt_is_proj_name AS project_name,
 rt_is_rep_id AS report_id,
 rt_is_rep_name AS report_name,
 is_rep_loc AS report_location,
 cubereportguid,
 cubeactionid,
 servermachine,
 rt_is_rep_req_ts AS request_time_ts,
 starttime,
 finishtime,
 rt_is_error_ind_id AS error_id,
 rt_errormessage AS error_desc,
 rt_job_duration AS job_duration_ms,
 ROUND(CAST(rt_job_duration AS BIGNUMERIC) / 1000 / 60, 2) AS job_duration_min,
 rt_resultrows AS result_rows,
 rt_sqlpasses AS sql_passes,
 timestamp_load_bcbi
FROM (SELECT *
   FROM ldl_bcbi_fe_mstr_bcbi.t_cubestatistics_1
   WHERE user_flag = 1
   UNION ALL
   SELECT *
   FROM ldl_bcbi_fe_mstr_bcbi.t_cubestatistics_1 AS T1_1
   WHERE user_flag = 0
    AND EXISTS (SELECT 1
     FROM ldl_bcbi_fe_mstr_bcbi.t_cubestatistics_1 AS T2
     WHERE user_flag = 1
      AND T1.cubereportguid = cubereportguid)) AS U;