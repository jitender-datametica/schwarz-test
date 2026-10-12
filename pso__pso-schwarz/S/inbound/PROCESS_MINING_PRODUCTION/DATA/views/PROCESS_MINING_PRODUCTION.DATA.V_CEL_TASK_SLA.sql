create or replace view PROCESS_MINING_PRODUCTION.DATA.V_CEL_TASK_SLA(
	SYS_ID,
	TASK,
	TASK_DISPLAY_VALUE,
	SOURCESYSTEM,
	SLA_DISPLAY_VALUE,
	HAS_BREACHED_DISPLAY_VALUE,
	BUSINESS_PERCENTAGE_DISPLAY_VALUE,
	STAGE_DISPLAY_VALUE,
	START_TIME,
	BUSINESS_DURATION_DISPLAY_VALUE,
	BUSINESS_PAUSE_DURATION_SECONDS,
	BUSINESS_PAUSE_DURATION_DISPLAY_VALUE,
	PLANNED_END_TIME
) as
WITH TimeCalculation AS (
  SELECT
    t_task_sla.sys_id, task, t_incident.number as  task_display_value, 'IT4YOU' as sourceSystem, T_CONTRACT_SLA.NAME as sla_display_value, has_breached as has_breached_display_value, business_percentage as business_percentage_display_value, stage as stage_display_value, start_time, null as business_duration_display_value, null as business_pause_duration_display_value, planned_end_time,
    -- Your original query to get the total seconds
    DATEDIFF('second', '1970-01-01', GREATEST(T_TASK_SLA.BUSINESS_PAUSE_DURATION, '1970-01-01')) AS BUSINESS_PAUSE_DURATION_Seconds,
    datediff('second','1970-01-01', GREATEST( T_TASK_SLA.BUSINESS_DURATION, '1970-01-01') ) as SLA_BUSINESS_DURATION_SECONDS
  FROM
    ETL.T_TASK_SLA
    left join etl.t_incident on t_task_sla.task = t_incident.sys_id
    inner JOIN ETL.T_CONTRACT_SLA ON
T_TASK_SLA.sla = T_CONTRACT_SLA.sys_id AND T_CONTRACT_SLA.NAME like '%resolution'
where stage != 'cancelled'
qualify row_number() over (partition by task order by sla_display_value not like '%Sol_Appl_Default%' desc ) =1
)
-- Now, format the seconds into the desired text format
SELECT
   tc.sys_id, task, task_display_value, sourceSystem, sla_display_value, has_breached_display_value, business_percentage_display_value, stage_display_value, start_time,
   TRIM( -- Removes trailing space if the last part is days or hours
    CONCAT(
      -- Add the 'Days' part only if there is at least one full day
      CASE
        WHEN (tc.SLA_BUSINESS_DURATION_SECONDS / 86400) >= 1
        THEN CONCAT(FLOOR(tc.SLA_BUSINESS_DURATION_SECONDS / 86400), ' Days ')
        ELSE ''
      END,
      -- Add the 'Hours' part if there is at least one full hour remaining
      CASE
        WHEN FLOOR((tc.SLA_BUSINESS_DURATION_SECONDS % 86400) / 3600) >= 1
        THEN CONCAT(FLOOR((tc.SLA_BUSINESS_DURATION_SECONDS % 86400) / 3600), ' Hours ')
        ELSE ''
      END,
      -- Add the 'Minutes' part
      CASE
        -- If total time is zero, show '0 Minutes'
        WHEN tc.SLA_BUSINESS_DURATION_SECONDS = 0 THEN '0 Minutes'
        -- Otherwise, if there are remaining minutes, show them
        WHEN FLOOR((tc.SLA_BUSINESS_DURATION_SECONDS % 3600) / 60) >= 1
        THEN CONCAT(FLOOR((tc.SLA_BUSINESS_DURATION_SECONDS % 3600) / 60), ' Minutes')
        ELSE ''
      END
    )
  ) AS  business_duration_display_value,
BUSINESS_PAUSE_DURATION_Seconds,

  TRIM( -- Removes trailing space if the last part is days or hours
    CONCAT(
      -- Add the 'Days' part only if there is at least one full day
      CASE
        WHEN (tc.BUSINESS_PAUSE_DURATION_Seconds / 86400) >= 1
        THEN CONCAT(FLOOR(tc.BUSINESS_PAUSE_DURATION_Seconds / 86400), ' Days ')
        ELSE ''
      END,
      -- Add the 'Hours' part if there is at least one full hour remaining
      CASE
        WHEN FLOOR((tc.BUSINESS_PAUSE_DURATION_Seconds % 86400) / 3600) >= 1
        THEN CONCAT(FLOOR((tc.BUSINESS_PAUSE_DURATION_Seconds % 86400) / 3600), ' Hours ')
        ELSE ''
      END,
      -- Add the 'Minutes' part
      CASE
        -- If total time is zero, show '0 Minutes'
        WHEN tc.BUSINESS_PAUSE_DURATION_Seconds = 0 THEN '0 Minutes'
        -- Otherwise, if there are remaining minutes, show them
        WHEN FLOOR((tc.BUSINESS_PAUSE_DURATION_Seconds % 3600) / 60) >= 1
        THEN CONCAT(FLOOR((tc.BUSINESS_PAUSE_DURATION_Seconds % 3600) / 60), ' Minutes')
        ELSE ''
      END
    )
  ) AS  business_pause_duration_display_value, planned_end_time
FROM
  TimeCalculation tc;