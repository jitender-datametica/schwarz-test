CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_be_monitoring_1 (cycle_id, teilprojekt_id, teilprojekt_name,
teilprojekt_thema_id, tp_thema_name, prio, env, cfg, scr_name, job_name, aktiv_flag, loop_id, proc_type, proc_name,
script, file, file_line_count, utl_row_count, err, sql_type, status_1, status_detail, start_date_head,
start_date_head_year, start_date_head_month, start_date_head_day, end_date_head, end_date_head_year, end_date_head_month
, end_date_head_day, start_time_head, start_time_head_round, end_time_head, start_date_detail, start_date_detail_year,
start_date_detail_month, start_date_detail_day, end_date_detail, end_date_detail_year, end_date_detail_month,
end_date_detail_day, start_time_detail, end_time_detail, start_time_det_round, runtime_seconds_det,
runtime_minutes_detail_round, runtime_10minutes_detail_round, filter_zehn, filter_zehn_dreissig, filter_dreissig) AS
SELECT DISTINCT LOGMA.cycle_id,
 TP0.teilprojekt_id,
 TP0.teilprojekt_name,
 THEMA.teilprojekt_thema_id,
 THEMA.teilprojekt_thema_name AS tp_thema_name,
 THEMA.prio_kz AS prio,
 LOGMA.env_file_name AS env,
 LOGMA.cfg_file_name AS cfg,
 chk.scr_name,
 LOGDET.job_name,
 fig.aktiv_fg AS aktiv_flag,
 LOGDET.loop_id,
 LOGDET.proc_type,
 LOGDET.proc_name,
 LOGDET.script_name AS script,
 LOGDET.raw_file AS file,
 LOGDET.file_line_count,
 LOGDET.utl_row_count,
 LOGDET.err_id AS err,
 chk.sql_type,
 LOGMA.status_1,
 LOGDET.status_1 AS status_detail,
 LOGMA.date_start AS start_date_head,
 EXTRACT(YEAR FROM LOGMA.date_start) AS start_date_head_year,
 EXTRACT(MONTH FROM LOGMA.date_start) AS start_date_head_month,
 EXTRACT(DAY FROM LOGMA.date_start) AS start_date_head_day,
 COALESCE(LOGMA.date_end, LOGMA.date_start) AS end_date_head,
 EXTRACT(YEAR FROM COALESCE(LOGMA.date_end, LOGMA.date_start)) AS end_date_head_year,
 EXTRACT(MONTH FROM COALESCE(LOGMA.date_end, LOGMA.date_start)) AS end_date_head_month,
 EXTRACT(DAY FROM COALESCE(LOGMA.date_end, LOGMA.date_start)) AS end_date_head_day,
 LOGMA.time_start AS start_time_head,
 TIME_ADD(TIME_ADD(TIME_ADD(LOGMA.time_start, INTERVAL EXTRACT(MINUTE FROM LOGMA.time_start) MINUTE), INTERVAL
   EXTRACT(SECOND FROM LOGMA.time_start) SECOND), INTERVAL CAST(CAST(CASE
     WHEN EXTRACT(MINUTE FROM LOGMA.time_start) = 0
     THEN 0
     WHEN EXTRACT(MINUTE FROM LOGMA.time_start) > 0 AND EXTRACT(MINUTE FROM LOGMA.time_start) < 15
     THEN 0
     WHEN EXTRACT(MINUTE FROM LOGMA.time_start) > 14 AND EXTRACT(MINUTE FROM LOGMA.time_start) < 30
     THEN 15
     WHEN EXTRACT(MINUTE FROM LOGMA.time_start) > 29 AND EXTRACT(MINUTE FROM LOGMA.time_start) < 45
     THEN 30
     ELSE 45
     END AS BIGNUMERIC) AS INTEGER) MINUTE) AS start_time_head_round,
 COALESCE(LOGMA.time_end, LOGMA.time_start) AS end_time_head,
 LOGDET.date_start AS start_date_detail,
 EXTRACT(YEAR FROM LOGDET.date_start) AS start_date_detail_year,
 EXTRACT(MONTH FROM LOGDET.date_start) AS start_date_detail_month,
 EXTRACT(DAY FROM LOGDET.date_start) AS start_date_detail_day,
 COALESCE(LOGDET.date_end, LOGDET.date_start) AS end_date_detail,
 EXTRACT(YEAR FROM COALESCE(LOGDET.date_end, LOGDET.date_start)) AS end_date_detail_year,
 EXTRACT(MONTH FROM COALESCE(LOGDET.date_end, LOGDET.date_start)) AS end_date_detail_month,
 EXTRACT(DAY FROM COALESCE(LOGDET.date_end, LOGDET.date_start)) AS end_date_detail_day,
 LOGDET.time_start AS start_time_detail,
 COALESCE(LOGDET.time_end, LOGDET.time_start) AS end_time_detail,
 TIME_ADD(TIME_ADD(TIME_ADD(LOGDET.time_start, INTERVAL EXTRACT(MINUTE FROM LOGDET.time_start) MINUTE), INTERVAL EXTRACT(SECOND FROM LOGDET.time_start) SECOND), INTERVAL CAST(CAST(CASE
     WHEN EXTRACT(MINUTE FROM LOGDET.time_start) = 0
     THEN 0
     WHEN EXTRACT(MINUTE FROM LOGDET.time_start) > 0 AND EXTRACT(MINUTE FROM LOGDET.time_start) < 15
     THEN 0
     WHEN EXTRACT(MINUTE FROM LOGDET.time_start) > 14 AND EXTRACT(MINUTE FROM LOGDET.time_start) < 30
     THEN 15
     WHEN EXTRACT(MINUTE FROM LOGDET.time_start) > 29 AND EXTRACT(MINUTE FROM LOGDET.time_start) < 45
     THEN 30
     ELSE 45
     END AS BIGNUMERIC) AS INTEGER) MINUTE) AS start_time_det_round,
 TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) AS runtime_seconds_det,
  CASE
  WHEN TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) < 60
  THEN 1
  ELSE TRUNC(CAST(CAST(TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) AS BIGNUMERIC) / 60 AS BIGNUMERIC))
  END AS runtime_minutes_detail_round,
 TRUNC(CAST((TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) + 600 - MOD(TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) + 600, 600)) / 60 AS BIGNUMERIC)) AS runtime_10minutes_detail_round,
  CASE
  WHEN CASE
     WHEN TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) < 60
     THEN 1
     ELSE TRUNC(CAST(CAST(TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) AS BIGNUMERIC) / 60 AS BIGNUMERIC))
     END < 10 OR CASE
     WHEN TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) < 60
     THEN 1
     ELSE TRUNC(CAST(CAST(TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) AS BIGNUMERIC) / 60 AS BIGNUMERIC))
     END = 10
  THEN 1
  ELSE 0
  END AS filter_zehn,
  CASE
  WHEN CASE
      WHEN TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) < 60
      THEN 1
      ELSE TRUNC(CAST(CAST(TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) AS BIGNUMERIC) / 60 AS BIGNUMERIC))
      END > 10 AND CASE
      WHEN TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) < 60
      THEN 1
      ELSE TRUNC(CAST(CAST(TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) AS BIGNUMERIC) / 60 AS BIGNUMERIC))
      END < 30 OR CASE
     WHEN TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) < 60
     THEN 1
     ELSE TRUNC(CAST(CAST(TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) AS BIGNUMERIC) / 60 AS BIGNUMERIC))
     END = 30
  THEN 1
  ELSE 0
  END AS filter_zehn_dreissig,
  CASE
  WHEN CASE
    WHEN TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) < 60
    THEN 1
    ELSE TRUNC(CAST(CAST(TIME_DIFF(COALESCE(LOGDET.time_end, LOGDET.time_start), LOGDET.time_start, SECOND) AS BIGNUMERIC) / 60 AS BIGNUMERIC))
    END > 30
  THEN 1
  ELSE 0
  END AS filter_dreissig
FROM kfl_production_dbp_v_process.v_load_log_detail_1 AS LOGDET
 INNER JOIN kfl_production_dbp_v_process.v_load_log_master_1 AS LOGMA ON LOGDET.cycle_id = LOGMA.cycle_id
 LEFT JOIN (SELECT cycle_id,
   sql_name,
   sql_type,
   job_name,
   scr_name,
   proc_type
  FROM kfl_production_dbp_v_process.v_load_chk_figures_1
  WHERE sql_type <> 'N/A'
  GROUP BY cycle_id,
   sql_name,
   sql_type,
   job_name,
   scr_name,
   proc_type) AS chk ON LOGDET.cycle_id = chk.cycle_id AND LOGDET.job_name = chk.job_name AND LOGDET.proc_type = chk.proc_type AND LOGDET.proc_name = chk.scr_name
 LEFT JOIN (SELECT cfg_file_name,
   env_file_name,
   job_name,
   teilprojekt_thema_id,
   sql_name,
   scr_name,
   proc_type,
   aktiv_fg
  FROM kfl_production_dbp_v_process.v_load_chk_figures_var_1
  WHERE dat_ende >= CURRENT_DATE
   AND dat_beginn <= CURRENT_DATE
   AND aktiv_fg <> 0
  GROUP BY cfg_file_name,
   env_file_name,
   job_name,
   teilprojekt_thema_id,
   sql_name,
   scr_name,
   proc_type,
   aktiv_fg) AS fig ON LOGMA.cfg_file_name = fig.cfg_file_name AND LOGMA.env_file_name = fig.env_file_name AND chk.job_name = fig.job_name AND chk.proc_type = fig.proc_type AND chk.sql_name = fig.sql_name AND chk.scr_name = fig.scr_name
 LEFT JOIN kfl_production_dbp_v_process.v_load_teilprojekt_thema_1 AS THEMA ON fig.teilprojekt_thema_id = THEMA.teilprojekt_thema_id
 LEFT JOIN kfl_production_dbp_v_process.v_load_teilprojekt_1 AS TP0 ON THEMA.teilprojekt_id = TP0.teilprojekt_id;