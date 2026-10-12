

/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_forklift_productivity_add
Description		|	SAP EWM Forklift - view with additional columns 
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_forklift_productivity_add (client_id
OPTIONS(description='Client id (PK)'), wh_id OPTIONS(description='Warehouse ID (PK)'), wh_task_nr
OPTIONS(description='Warehouse Task (PK)'), conf_by
OPTIONS(description='Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY'), conf_dt
OPTIONS(description='Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE'),
conf_tm
OPTIONS(description='Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME'),
conf_ts OPTIONS(description='Confirmation timestamp'), src_hu
OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'), rsrc
OPTIONS(description='Resource'), dest_hu OPTIONS(description='Destination Handling Unit. Source column name: NLENR'),
src_hu_ep OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
src_hu_dd OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
src_hu_qp OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
src_hu_sg OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
src_hu_hg OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
src_hu_qg OPTIONS(description='Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR'),
dest_hu_ep OPTIONS(description='Destination Handling Unit'), dest_hu_dd OPTIONS(description='Destination Handling Unit'),
dest_hu_qp OPTIONS(description='Destination Handling Unit'), dest_hu_sg OPTIONS(description='Destination Handling Unit'),
dest_hu_hg OPTIONS(description='Destination Handling Unit'), dest_hu_qg OPTIONS(description='Destination Handling Unit'),
wh_area OPTIONS(description='Warehouse area'), movement_type OPTIONS(description='Movement type'), rsrc_type
OPTIONS(description='Resource type'), hu_size
OPTIONS(description='Calculated amount of handling units after successful end of task'), hu_type
OPTIONS(description='Handling Unit Type. Source column name: LETYP'), queue
OPTIONS(description='Queue. Source column name: QUEUE'), start_time
OPTIONS(description='Timestamp of task end or unload from resource'), end_time
OPTIONS(description='Timestamp of task start or load on resource'), prev_start_ts
OPTIONS(description='Start timestamp from previous task group'), prev_end_ts
OPTIONS(description='Start timestamp from previous task group'), exec_time OPTIONS(description='Execution time'),
travel_dur OPTIONS(description='Travel ime'), exec_dur_sec
OPTIONS(description='Execution Time (Seconds) with maximum of 15 min'), travel_dur_sec
OPTIONS(description='Travel Time (Seconds) with maximum of 20 min'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'))
OPTIONS(DESCRIPTION = `SAP EWM FORKLIFT REPORT FORKLIFT PRODUCTIVITY - VIEW WITH ADDITIONAL COLUMNS (BASED ON V_SAPEWM_WHTASK AND MV_REF_QUEUE)`)
AS WITH TASKQUEUESET AS (SELECT T.client_id,
   T.wh_id,
   T.wh_task_nr,
   T.wh_task_item,
   T.conf_by,
   T.conf_dt,
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
  FROM ldl_logop_fe_mstr_logop.v_sapewm_whtask AS T
   INNER JOIN ldl_logop_data.t_ref_queue AS Q ON T.queue = Q.queue
  WHERE T.wh_task_stat IN ('C')
   AND (NOT STARTS_WITH(IFNULL(T.queue, 'dummy'), 'OUT') OR STARTS_WITH(IFNULL(T.queue, 'dummy'), 'OUT') AND T.src_hu
      IS NOT NULL)
   AND (T.src_rsrc IS NOT NULL OR T.dest_rsrc IS NOT NULL)
   AND T.act_type IN ('INTL', 'PICK', 'PTWY', 'REPL')), TIMECALC AS (SELECT client_id,
   wh_id,
   wh_task_nr,
   conf_by,
   conf_dt,
   conf_tm,
   src_hu,
   rsrc,
   wh_area,
   rsrc_type,
   movement_type,
   hu_size,
   hu_type,
   queue,
   hu_type_epe,
   start_time,
   end_time,
   IF((LAG(start_time) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_by, conf_dt, rsrc
       ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr)) IS NULL AND start_time IS NOT NULL,
    start_time, NULL) AS first_start_ts,
   IF((LEAD(end_time) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), conf_by, conf_dt, rsrc
       ORDER BY conf_tm IS NULL, conf_tm, wh_task_nr IS NULL, wh_task_nr)) IS NULL AND end_time IS NOT NULL, end_time,
    NULL) AS last_end_ts,
   dest_hu,
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
    CASE
    WHEN hu_type_epe = 'EP' AND movement_type <> 'Full Pallet Pick'
    THEN src_hu
    ELSE NULL
    END AS src_hu_ep,
    CASE
    WHEN hu_type_epe = 'DD' AND movement_type <> 'Full Pallet Pick'
    THEN src_hu
    ELSE NULL
    END AS src_hu_dd,
    CASE
    WHEN hu_type_epe = 'QP' AND movement_type <> 'Full Pallet Pick'
    THEN src_hu
    ELSE NULL
    END AS src_hu_qp,
    CASE
    WHEN hu_type_epe = 'SG' AND movement_type <> 'Full Pallet Pick'
    THEN src_hu
    ELSE NULL
    END AS src_hu_sg,
    CASE
    WHEN hu_type_epe = 'HG' AND movement_type <> 'Full Pallet Pick'
    THEN src_hu
    ELSE NULL
    END AS src_hu_hg,
    CASE
    WHEN hu_type_epe = 'QG' AND movement_type <> 'Full Pallet Pick'
    THEN src_hu
    ELSE NULL
    END AS src_hu_qg,
    CASE
    WHEN hu_type_epe = 'EP' AND movement_type = 'Full Pallet Pick'
    THEN dest_hu
    ELSE NULL
    END AS dest_hu_ep,
    CASE
    WHEN hu_type_epe = 'DD' AND movement_type = 'Full Pallet Pick'
    THEN dest_hu
    ELSE NULL
    END AS dest_hu_dd,
    CASE
    WHEN hu_type_epe = 'QP' AND movement_type = 'Full Pallet Pick'
    THEN dest_hu
    ELSE NULL
    END AS dest_hu_qp,
    CASE
    WHEN hu_type_epe = 'SG' AND movement_type = 'Full Pallet Pick'
    THEN dest_hu
    ELSE NULL
    END AS dest_hu_sg,
    CASE
    WHEN hu_type_epe = 'HG' AND movement_type = 'Full Pallet Pick'
    THEN dest_hu
    ELSE NULL
    END AS dest_hu_hg,
    CASE
    WHEN hu_type_epe = 'QG' AND movement_type = 'Full Pallet Pick'
    THEN dest_hu
    ELSE NULL
    END AS dest_hu_qg,
   wh_area,
   movement_type,
   rsrc_type,
   hu_size,
   hu_type,
   queue,
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