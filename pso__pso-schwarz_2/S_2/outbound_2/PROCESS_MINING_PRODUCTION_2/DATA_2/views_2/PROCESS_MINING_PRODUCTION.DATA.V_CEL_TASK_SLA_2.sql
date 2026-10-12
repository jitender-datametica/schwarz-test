

CREATE OR REPLACE VIEW process_mining_production_data.v_cel_task_sla_2 AS WITH TIMECALCULATION AS (SELECT t_task_sla.sys_id
   ,
   t_task_sla.task,
   t_incident.number AS task_display_value,
   'IT4YOU' AS sourcesystem,
   t_contract_sla.name AS sla_display_value,
   t_task_sla.has_breached AS has_breached_display_value,
   t_task_sla.business_percentage AS business_percentage_display_value,
   t_task_sla.stage AS stage_display_value,
   t_task_sla.start_time,
   NULL AS business_duration_display_value,
   NULL AS business_pause_duration_display_value,
   t_task_sla.planned_end_time,
   DATETIME_DIFF(CAST(GREATEST(t_task_sla.business_pause_duration, '1970-01-01') AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME)
    ,SECOND) AS business_pause_duration_seconds,
   DATETIME_DIFF(CAST(GREATEST(t_task_sla.business_duration, '1970-01-01') AS DATETIME), CAST('1970-01-01 00:00:00' AS DATETIME)
    ,SECOND) AS sla_business_duration_seconds
  FROM process_mining_production_etl.t_task_sla_2
   LEFT JOIN process_mining_production_etl.t_incident_2 ON t_task_sla.task = t_incident.sys_id
   INNER JOIN process_mining_production_etl.t_contract_sla_2 ON t_task_sla.sla = t_contract_sla.sys_id AND t_contract_sla_2
     .name LIKE '%resolution'
  WHERE t_task_sla.stage <> 'cancelled'
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY t_task_sla.task ORDER BY (sla_display_value NOT LIKE '%Sol_Appl_Default%')DESC, sla_display_value NOT LIKE '%Sol_Appl_Default%' DESC)) = 1) (SELECT sys_id,
   task,
   task_display_value,
   sourcesystem,
   sla_display_value,
   has_breached_display_value,
   business_percentage_display_value,
   stage_display_value,
   start_time,
   TRIM(CONCAT(CASE
      WHEN sla_business_duration_seconds / 86400 >= 1
      THEN CONCAT(CAST(FLOOR(sla_business_duration_seconds / 86400) AS INTEGER), ' Days ')
      ELSE ''
      END, CASE
      WHEN CAST(FLOOR(MOD(sla_business_duration_seconds, 86400) / 3600) AS INTEGER) >= 1
      THEN CONCAT(CAST(FLOOR(MOD(sla_business_duration_seconds, 86400) / 3600) AS INTEGER), ' Hours ')
      ELSE ''
      END, CASE
      WHEN sla_business_duration_seconds = 0
      THEN '0 Minutes'
      WHEN CAST(FLOOR(MOD(sla_business_duration_seconds, 3600) / 60) AS INTEGER) >= 1
      THEN CONCAT(CAST(FLOOR(MOD(sla_business_duration_seconds, 3600) / 60) AS INTEGER), ' Minutes')
      ELSE ''
      END)) AS business_duration_display_value,
   business_pause_duration_seconds,
   TRIM(CONCAT(CASE
      WHEN business_pause_duration_seconds / 86400 >= 1
      THEN CONCAT(CAST(FLOOR(business_pause_duration_seconds / 86400) AS INTEGER), ' Days ')
      ELSE ''
      END, CASE
      WHEN CAST(FLOOR(MOD(business_pause_duration_seconds, 86400) / 3600) AS INTEGER) >= 1
      THEN CONCAT(CAST(FLOOR(MOD(business_pause_duration_seconds, 86400) / 3600) AS INTEGER), ' Hours ')
      ELSE ''
      END, CASE
      WHEN business_pause_duration_seconds = 0
      THEN '0 Minutes'
      WHEN CAST(FLOOR(MOD(business_pause_duration_seconds, 3600) / 60) AS INTEGER) >= 1
      THEN CONCAT(CAST(FLOOR(MOD(business_pause_duration_seconds, 3600) / 60) AS INTEGER), ' Minutes')
      ELSE ''
      END)) AS business_pause_duration_display_value,
   planned_end_time
  FROM TIMECALCULATION AS tc);
