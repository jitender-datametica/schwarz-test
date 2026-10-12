CREATE OR REPLACE VIEW process_mining_production_data.v_task_resolution_sla_2 (sla_business_duration_seconds,
sla_business_pause_duration_seconds, business_percentage, sla_business_time_left_seconds, sla_duration_seconds,
has_breached, sla_pause_duration_seconds, sla, stage, task, sys_id, sys_updated_on, sla_contract_sla_name,
sla_planned_end_time) AS SELECT DATETIME_DIFF(CAST(t_task_sla.business_duration AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME)
  ,SECOND) AS sla_business_duration_seconds,
 DATETIME_DIFF(CAST(GREATEST(t_task_sla.business_pause_duration, '1970-01-01') AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME)
  ,SECOND) AS sla_business_pause_duration_seconds,
 t_task_sla.business_percentage,
 DATETIME_DIFF(CAST(GREATEST(t_task_sla.business_time_left, '1970-01-01') AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME)
  ,SECOND) AS sla_business_time_left_seconds,
 DATETIME_DIFF(CAST(GREATEST(t_task_sla.duration, '1970-01-01') AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME),
  SECOND) AS sla_duration_seconds,
 t_task_sla.has_breached,
 DATETIME_DIFF(CAST(GREATEST(t_task_sla.pause_duration, '1970-01-01') AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME)
  ,SECOND) AS sla_pause_duration_seconds,
 t_task_sla.sla,
 t_task_sla.stage,
 t_task_sla.task,
 t_task_sla.sys_id,
 t_task_sla.sys_updated_on,
 t_contract_sla.name AS sla_contract_sla_name,
 t_task_sla.planned_end_time AS sla_planned_end_time
FROM process_mining_production_etl.t_task_sla_2
 INNER JOIN process_mining_production_etl.t_contract_sla_2 ON t_task_sla.sla = t_contract_sla.sys_id AND t_contract_sla.name
   LIKE '%resolution'
WHERE t_task_sla.stage <> 'cancelled'
QUALIFY (ROW_NUMBER() OVER (PARTITION BY t_task_sla.task ORDER BY sla_contract_sla_name NOT LIKE '%Sol_Appl_Default%'
       DESC, sla_contract_sla_name NOT LIKE '%Sol_Appl_Default%' DESC)) = 1;