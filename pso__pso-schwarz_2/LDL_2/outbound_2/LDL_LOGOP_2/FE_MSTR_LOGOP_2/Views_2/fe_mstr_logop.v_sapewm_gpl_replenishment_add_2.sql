
/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_replenishment_add_2
Description		|	SAP EWM Gruppenleiter Dahsboard Replenishment - view with additional columns
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_gpl_replenishment_add_2 (client_id
OPTIONS(description='Client id (PK)'), wh_id OPTIONS(description='Warehouse ID (PK)'), wh_task_nr
OPTIONS(description='Warehouse Task (PK)'), conf_by
OPTIONS(description='Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY'), conf_dt
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
conf_ts OPTIONS(description='Confirmation timestamp'), src_hu
OPTIONS(description='Source Handling Unit_2 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), dest_hu
OPTIONS(description='Destination Handling Unit. Source column name: NLENR'), rsrc OPTIONS(description='Resource'),
rsrc_type OPTIONS(description='Resource type'), wh_area OPTIONS(description='Warehouse area'), movement_type
OPTIONS(description='Movement type'), hu_size
OPTIONS(description='Calculated amount of handling units after successful end of task'), hu_type
OPTIONS(description='Handling Unit_2 Type. Source column name: LETYP'), queue
OPTIONS(description='Queue. Source column name: QUEUE'), area
OPTIONS(description='Warehouse area. Made to the exact specifications from Repl. Functional Concept.'), priority
OPTIONS(description='Replenishment Priority'), stat
OPTIONS(description='Status_2 of Warehouse task (Closed/Waiting/Open)'), start_time
OPTIONS(description='Timestamp of task end or unload from resource'), end_time
OPTIONS(description='Timestamp of task start or load on resource'), prev_start_ts
OPTIONS(description='Start timestamp from previous task group'), prev_end_ts
OPTIONS(description='Start timestamp from previous task group'), exec_time OPTIONS(description='Execution time'),
travel_dur OPTIONS(description='Travel ime'), exec_dur_sec
OPTIONS(description='Execution Time (Seconds) with maximum of 15 min'), travel_dur_sec
OPTIONS(description='Travel Time (Seconds) with maximum of 20 min'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'))
OPTIONS(DESCRIPTION = `SAP EWM REPLENISHMENT VIEW (BASED ON V_SAPEWM_WHTASK_2)`) AS WITH TASKQUEUESET AS (SELECT T.client_id
   ,
   T.wh_id,
   T.wh_task_nr,
   T.wh_task_item,
   T.wh_task_stat,
   T.conf_by,
   IF(T.conf_dt IS NULL, DATE(CURRENT_TIMESTAMP()), T.conf_dt) AS conf_dt,
   T.conf_tm,
   T.src_rsrc,
   T.src_hu,
   T.dest_hu,
   T.hu_type,
   T.queue,
   T.dest_strg_bin,
   T.act_area,
   Q.wh_area,
   Q.movement_type,
   T.rep_sort,
   COALESCE(T.dest_rsrc, T.src_rsrc) AS rsrc,
    CASE
    WHEN LEFT(COALESCE(T.dest_rsrc, T.src_rsrc), 1) = '1'
    THEN 'FAMO'
    WHEN LEFT(COALESCE(T.dest_rsrc, T.src_rsrc), 1) = '2'
    THEN 'FORK'
    WHEN LEFT(COALESCE(T.dest_rsrc, T.src_rsrc), 1) = '3'
    THEN 'FAMO'
    WHEN LEFT(COALESCE(T.dest_rsrc, T.src_rsrc), 1) = ''
    THEN 'No Resource'
    ELSE 'Unknown'
    END AS rsrc_type,
   LEFT(T.hu_type, 2) AS hu_type_epe,
    CASE
    WHEN LEFT(T.hu_type, 2) = 'EP'
    THEN 1
    WHEN LEFT(T.hu_type, 2) = 'DD'
    THEN 0.5
    WHEN LEFT(T.hu_type, 2) = 'QP'
    THEN 0.25
    WHEN LEFT(T.hu_type, 2) = 'IP'
    THEN 1
    WHEN LEFT(T.hu_type, 2) = 'AE'
    THEN 1
    WHEN LEFT(T.hu_type, 2) = 'SG'
    THEN 1
    WHEN LEFT(T.hu_type, 2) = 'HG'
    THEN 0.5
    WHEN LEFT(T.hu_type, 2) = 'QG'
    THEN 0.25
    ELSE 0
    END AS hu_size,
   T.dwh_created,
   T.dwh_updated,
   IF(T.src_strg_bin IS NOT NULL AND T.dest_rsrc IS NOT NULL, DATETIME(T.conf_dt, T.conf_tm), NULL) AS start_time,
   IF(T.dest_strg_bin IS NOT NULL AND T.src_rsrc IS NOT NULL, DATETIME(T.conf_dt, T.conf_tm), NULL) AS end_time
  FROM ldl_logop_fe_mstr_logop.v_sapewm_whtask_2 AS T
   INNER JOIN ldl_logop_data.t_ref_queue_2 AS Q ON T.queue = Q.queue
  WHERE (T.wh_task_stat IS NULL OR T.wh_task_stat = 'C')
   AND (NOT STARTS_WITH(IFNULL(T.queue, 'dummy_2'), 'OUT') OR STARTS_WITH(IFNULL(T.queue, 'dummy_2'), 'OUT') AND T.src_hu
      IS NOT NULL)
   AND (T.src_rsrc IS NOT NULL OR T.dest_rsrc IS NOT NULL)
   AND T.act_type IN ('REPL')
   AND T.wh_proc_type LIKE 'Z%'), TIMECALC AS (SELECT client_id,
   wh_id,
   wh_task_nr,
    CASE
    WHEN wh_task_stat IS NULL
    THEN 0
    WHEN wh_task_stat = 'C'
    THEN 1
    ELSE NULL
    END AS stat,
   conf_by,
   conf_dt,
   conf_tm,
   src_hu,
   rsrc,
   rsrc_type,
   wh_area,
   movement_type,
   hu_size,
   hu_type,
   hu_type_epe,
   dest_hu,
   queue,
   start_time,
   end_time,
   IF((LAG(start_time) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_by, conf_dt, rsrc
       ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr)) IS NULL AND start_time IS NOT NULL,
    start_time, NULL) AS first_start_ts,
   IF((LEAD(end_time) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_by, conf_dt, rsrc
       ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr)) IS NULL AND end_time IS NOT NULL, end_time,
    NULL) AS last_end_ts,
    CASE
    WHEN queue IN ('REPL_AMB', 'REPL_NF', 'REPL_S_AMB', 'REPL1_AMB', 'REPL1_NF', 'REPL2_AMB', 'REPL2_NF', 'REPL3_AMB',
      'REPL3_NF')
    THEN 'Ambient'
    WHEN queue IN ('OB_OUTFEED', 'REPL_BULK', 'REPL2_BULK', 'REPL2_BULK', 'REPL3_BULK')
    THEN 'Bulk'
    WHEN queue IN ('REPL_CHL', 'REPL2_CHL', 'REPL3_CHL')
    THEN 'Chiller'
    WHEN queue IN ('REPL_FV')
    THEN 'Fruit and Veg'
    WHEN queue IN ('REPL_MPF', 'REPL2_MPF', 'REPL3_MPF')
    THEN 'MPF'
    WHEN queue IN ('REPL_FRZ', 'REPL2_FRZ', 'REPL3_FRZ')
    THEN 'Freezer'
    ELSE 'Unknown'
    END AS area,
    CASE
    WHEN rep_sort IN (99)
    THEN 4
    WHEN rep_sort IN (50)
    THEN 3
    WHEN rep_sort IN (30, 25, 15)
    THEN 2
    WHEN rep_sort IN (5, 20)
    THEN 1
    ELSE NULL
    END AS priority,
   dwh_created,
   dwh_updated
  FROM TASKQUEUESET) (SELECT client_id,
   wh_id,
   wh_task_nr,
   conf_by,
   conf_dt,
   conf_tm,
   DATETIME(conf_dt, conf_tm) AS conf_ts,
   src_hu,
   dest_hu,
   rsrc,
   rsrc_type,
   wh_area,
   movement_type,
   hu_size,
   hu_type,
   queue,
   area,
   priority,
   stat,
   start_time,
   end_time,
   IF(last_end_ts IS NOT NULL, LAG(first_start_ts) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING),
       conf_by, conf_dt, rsrc ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr), NULL) AS prev_start_ts
   ,
   IF(first_start_ts IS NOT NULL, LAG(last_end_ts) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING),
       conf_by, conf_dt, rsrc ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr), NULL) AS prev_end_ts,
   TIMESTAMP_DIFF(last_end_ts, IF(last_end_ts IS NOT NULL, LAG(first_start_ts) OVER (PARTITION BY CAST(client_id AS STRING)
        , CAST(wh_id AS STRING), conf_by, conf_dt, rsrc ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL,
        wh_task_nr), NULL), SECOND) AS exec_time,
   TIMESTAMP_DIFF(first_start_ts, IF(first_start_ts IS NOT NULL, LAG(last_end_ts) OVER (PARTITION BY CAST(client_id AS STRING)
        , CAST(wh_id AS STRING), conf_by, conf_dt, rsrc ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL,
        wh_task_nr), NULL), SECOND) AS travel_dur,
    CASE
    WHEN TIMESTAMP_DIFF(last_end_ts, IF(last_end_ts IS NOT NULL, LAG(first_start_ts) OVER (PARTITION BY CAST(client_id AS STRING)
          , CAST(wh_id AS STRING), conf_by, conf_dt, rsrc ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL,
          wh_task_nr), NULL), SECOND) > 900
    THEN 900
    ELSE TIMESTAMP_DIFF(last_end_ts, IF(last_end_ts IS NOT NULL, LAG(first_start_ts) OVER (PARTITION BY CAST(client_id AS STRING)
         , CAST(wh_id AS STRING), conf_by, conf_dt, rsrc ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL,
         wh_task_nr), NULL), SECOND)
    END AS exec_dur_sec,
    CASE
    WHEN TIMESTAMP_DIFF(first_start_ts, IF(first_start_ts IS NOT NULL, LAG(last_end_ts) OVER (PARTITION BY CAST(client_id AS STRING)
          , CAST(wh_id AS STRING), conf_by, conf_dt, rsrc ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL,
          wh_task_nr), NULL), SECOND) BETWEEN 0 AND 1200
    THEN TIMESTAMP_DIFF(first_start_ts, IF(first_start_ts IS NOT NULL, LAG(last_end_ts) OVER (PARTITION BY CAST(client_id AS STRING)
         , CAST(wh_id AS STRING), conf_by, conf_dt, rsrc ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL,
         wh_task_nr), NULL), SECOND)
    ELSE NULL
    END AS travel_dur_sec,
   dwh_created,
   dwh_updated
  FROM TIMECALC);