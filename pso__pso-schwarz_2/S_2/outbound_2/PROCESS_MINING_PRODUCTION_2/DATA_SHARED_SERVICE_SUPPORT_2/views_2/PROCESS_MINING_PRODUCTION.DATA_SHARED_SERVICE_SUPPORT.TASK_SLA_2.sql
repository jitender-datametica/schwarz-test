CREATE OR REPLACE VIEW process_mining_production_data_shared_service_support.task_sla_2 (business_duration_seconds,
business_duration, business_pause_duration_seconds, business_pause_duration, business_percentage,
business_time_left_seconds, business_time_left, duration_seconds, duration, has_breached, pause_duration_seconds,
pause_duration, sla, stage, task, sys_id, sys_updated_on, contract_sla_name, original_breach_time) AS SELECT
 DATETIME_DIFF(CAST(t_task_sla.business_duration AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME), SECOND) AS
 business_duration_seconds,
 t_task_sla.business_duration,
 DATETIME_DIFF(CAST(GREATEST(t_task_sla.business_pause_duration, '1970-01-01') AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME)
  ,SECOND) AS business_pause_duration_seconds,
 t_task_sla.business_pause_duration,
 t_task_sla.business_percentage,
 DATETIME_DIFF(CAST(GREATEST(t_task_sla.business_time_left, '1970-01-01') AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME)
  ,SECOND) AS business_time_left_seconds,
 t_task_sla.business_time_left,
 DATETIME_DIFF(CAST(GREATEST(t_task_sla.duration, '1970-01-01') AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME),
  SECOND) AS duration_seconds,
 t_task_sla.duration,
 t_task_sla.has_breached,
 DATETIME_DIFF(CAST(GREATEST(t_task_sla.pause_duration, '1970-01-01') AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME)
  ,SECOND) AS pause_duration_seconds,
 t_task_sla.pause_duration,
 t_task_sla.sla,
 t_task_sla.stage,
 t_task_sla.task,
 t_task_sla.sys_id,
 t_task_sla.sys_updated_on,
 t_contract_sla.name AS contract_sla_name,
 t_task_sla.original_breach_time
FROM process_mining_production_etl.t_task_sla_2
 LEFT JOIN process_mining_production_etl.t_contract_sla_2 ON t_task_sla.sla = t_contract_sla.sys_id;