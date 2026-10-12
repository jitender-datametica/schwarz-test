/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_picking_pick_rate_add
Description		|	SAP EWM Pick Rate - view with additional columns
====================================================================================================
*/

-- LDL_LOGOP_DEVELOPMENT.FE_MSTR_LOGOP.V_SAPEWM_PICKING_PICK_RATE_ADD source


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_picking_pick_rate_add (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number'), wh_nr
OPTIONS(description='Warehouse Number/Warehouse Complex. Source column name: LGNUM'), wh_task_nr
OPTIONS(description='Warehouse Task. Source column name: TANUM'), act_type
OPTIONS(description='Activity. Source column name: ACT_TYPE'), wh_task_item
OPTIONS(description='Warehouse Task Item. Source column name: TAPOS'), wh_task_stat
OPTIONS(description='Warehouse Task Status. Source column name: TOSTAT'), conf_by
OPTIONS(description='Confirmed by. Source column name: CONFIRMED_BY'), conf_dt
OPTIONS(description='Confirmation Date. Source column name: CONFIRMED_DATE'), conf_tm
OPTIONS(description='Confirmation Time. Source column name: CONFIRMED_TIME'), exc_cd
OPTIONS(description='Exception Code. Source column name: EXCCODE'), conf_tm_hh
OPTIONS(description='Confirmation time rounded down'), start_dt
OPTIONS(description='Start Date. Source column name: STARTED_DATE'), start_tm
OPTIONS(description='Start Time. Source column name: STARTED_TIME'), src_hu
OPTIONS(description='Source Handling Unit. Source column name: VLENR'), act_dest_qty_auom
OPTIONS(description='Actual Destination Quantity in Alternative Unit. Source column name: NISTA'), auom
OPTIONS(description='Alternative Unit of Measure for Stockkeeping Unit. Source column name: ALTME'), hu_type
OPTIONS(description='Handling Unit Type. Source column name: LETYP'), dest_strg_bin
OPTIONS(description='Destination Storage Bin. Source column name: NLPLA'), queue
OPTIONS(description='Queue. Source column name: QUEUE'), perf_area OPTIONS(description='Performance area'), act_area
OPTIONS(description='Activity Area. Source column name: AAREA'), wh_ord_nr
OPTIONS(description='Warehouse Order Number. Source column name: WHO'), act_qty_auom_case
OPTIONS(description='Actual Quantity in Alternative Unit of Measure Case. Source column name: ZZ_QTY_CASE'), auom_case
OPTIONS(description='Alternative Unit of Measure Case. Source column name: ZZ_AUOM_CASE'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), first_queue
OPTIONS(description='First queue within a warehouse order'), who_status
OPTIONS(description='Warehouse Order Status. Source column name: STATUS'), rsrc
OPTIONS(description='Resource (Means of Transportation or User)'), start_dt_who
OPTIONS(description='Start Date. Source column name: STARTED_DATE'), start_tm_who
OPTIONS(description='Start Time. Source column name: STARTED_TIME'), conf_dt_who
OPTIONS(description='Confirmation Date. Source column name: CONFIRMED_DATE'), conf_tm_who
OPTIONS(description='Confirmation Time. Source column name: CONFIRMED_TIME'), amt_pallet_ep
OPTIONS(description='Amount of pallets in EP equivalent based on HU type'), amt_pallet
OPTIONS(description='Amount of pallets mit DEST_STRG_BIN'), amt_case
OPTIONS(description='Amount of cases based on actual quantity in alternative unit case'), amt_pick
OPTIONS(description='Amount of picks based on actual destination quantity auom'), skipped
OPTIONS(description='Skiped possition - warehouse task with the exeption codes “ZPPD, ZFPD, ZFPM”'), grp_queue_first
OPTIONS(description='Identify the sequence of queues coming for picking'), grp_who_first
OPTIONS(description='Sorting number for group of WH order ascending'), grp_who_last
OPTIONS(description='Sorting number for group of WH order descending'), grp_who_emp_first
OPTIONS(description='Sorting number for group of WH order and employee ascending'), grp_who_emp_last
OPTIONS(description='Sorting number for group of WH order and employee descending'), pick_start_dt
OPTIONS(description='Start date of pick'), pick_start_tm OPTIONS(description='Start time of pick'), pick_start_tm_hh
OPTIONS(description='Starting hour of pick rounded down'), pick_end_dt OPTIONS(description='End date of pick'),
pick_end_tm OPTIONS(description='End time of pick'), pick_end_tm_hh
OPTIONS(description='Ending hour of pick rounded up'), work_tm_sec OPTIONS(description='Working time in seconds'),
sum_break_sec OPTIONS(description='Sum of break time in secinds')) AS WITH TASKSFIRSTQUEUE AS (SELECT client_id,
   wh_id,
   wh_nr,
   wh_task_nr,
   act_type,
   wh_task_item,
   wh_task_stat,
   conf_by,
   conf_dt,
   conf_tm,
   exc_cd,
   start_dt,
   start_tm,
   src_hu,
   act_dest_qty_auom,
   auom,
   hu_type,
   dest_strg_bin,
   queue,
   act_area,
   wh_ord_nr,
   act_qty_auom_case,
   auom_case,
   dwh_created,
   dwh_updated,
   FIRST_VALUE(queue) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), CAST(wh_ord_nr AS STRING)
    ORDER BY conf_dt IS NULL, conf_dt, conf_tm IS NULL, conf_tm RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS first_queue
  FROM ldl_logop_fe_mstr_logop.v_sapewm_whtask
  WHERE wh_task_stat = 'C'
   AND act_type <> 'INTL'), BREAKS AS (SELECT client_id,
   wh_id,
   crtd_by,
   wh_ord_nr,
   SUM(duration) AS break_sec
  FROM ldl_logop_fe_mstr_logop.v_sapewm_pickingbreak
  GROUP BY client_id,
   wh_id,
   crtd_by,
   wh_ord_nr) (SELECT t.client_id,
   t.wh_id,
   t.wh_nr,
   t.wh_task_nr,
   t.act_type,
   t.wh_task_item,
   t.wh_task_stat,
   t.conf_by,
   t.conf_dt,
   t.conf_tm,
   t.exc_cd,
   TIME_TRUNC(t.conf_tm, HOUR) AS conf_tm_hh,
   t.start_dt,
   t.start_tm,
   t.src_hu,
   t.act_dest_qty_auom,
   t.auom,
   t.hu_type,
   t.dest_strg_bin,
   t.queue,
   Q.perf_area,
   t.act_area,
   t.wh_ord_nr,
   t.act_qty_auom_case,
   t.auom_case,
   t.dwh_created,
   t.dwh_updated,
   t.first_queue,
   O.who_status,
   O.rsrc,
   O.start_dt AS start_dt_who,
   O.start_tm AS start_tm_who,
   O.conf_dt AS conf_dt_who,
   O.conf_tm AS conf_tm_who,
    CASE
    WHEN LEFT(t.hu_type, 2) = 'EP'
    THEN 1
    WHEN LEFT(t.hu_type, 2) = 'DD'
    THEN 0.5
    WHEN LEFT(t.hu_type, 2) = 'QP'
    THEN 0.25
    WHEN LEFT(t.hu_type, 2) = 'SG'
    THEN 1.28
    WHEN LEFT(t.hu_type, 2) = 'HG'
    THEN 0.5
    WHEN LEFT(t.hu_type, 2) = 'QG'
    THEN 0.25
    WHEN LEFT(t.hu_type, 2) = 'BX'
    THEN 1
    WHEN LEFT(t.hu_type, 2) = 'GMA'
    THEN 1.28
    WHEN LEFT(t.hu_type, 2) = 'IP'
    THEN 1.5
    WHEN LEFT(t.hu_type, 2) = 'BB'
    THEN 0.04
    WHEN LEFT(t.hu_type, 2) = 'MT'
    THEN 0.3
    WHEN LEFT(t.hu_type, 2) = 'AE'
    THEN 1
    WHEN LEFT(t.hu_type, 2) = 'FR'
    THEN 0.8
    ELSE 0
    END AS amt_pallet_ep,
   IF(t.dest_strg_bin IS NULL, '0', SUBSTR(SAFE_CAST(CASE
       WHEN LEFT(t.hu_type, 2) = 'EP'
       THEN 1
       WHEN LEFT(t.hu_type, 2) = 'DD'
       THEN 0.5
       WHEN LEFT(t.hu_type, 2) = 'QP'
       THEN 0.25
       WHEN LEFT(t.hu_type, 2) = 'SG'
       THEN 1.28
       WHEN LEFT(t.hu_type, 2) = 'HG'
       THEN 0.5
       WHEN LEFT(t.hu_type, 2) = 'QG'
       THEN 0.25
       WHEN LEFT(t.hu_type, 2) = 'BX'
       THEN 1
       WHEN LEFT(t.hu_type, 2) = 'GMA'
       THEN 1.28
       WHEN LEFT(t.hu_type, 2) = 'IP'
       THEN 1.5
       WHEN LEFT(t.hu_type, 2) = 'BB'
       THEN 0.04
       WHEN LEFT(t.hu_type, 2) = 'MT'
       THEN 0.3
       WHEN LEFT(t.hu_type, 2) = 'AE'
       THEN 1
       WHEN LEFT(t.hu_type, 2) = 'FR'
       THEN 0.8
       ELSE 0
       END as STRING), 1, 11)) AS amt_pallet,
   IF(t.dest_strg_bin IS NOT NULL, '0', SUBSTR(SAFE_CAST(t.act_qty_auom_case as STRING), 1, 39)) AS amt_case,
   IF(t.dest_strg_bin IS NOT NULL, '0', SUBSTR(SAFE_CAST(t.act_dest_qty_auom as STRING), 1, 39)) AS amt_pick,
   IF(t.exc_cd IN ('ZPPD', 'ZFPD', 'ZFPM'), '1', NULL) AS skipped,
   ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
    ORDER BY t.start_dt IS NULL, t.start_dt, t.start_tm IS NULL, t.start_tm) AS grp_queue_first,
   ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t
      .conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr
      , t.wh_task_item IS NULL, t.wh_task_item) AS grp_who_first,
   ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t
      .queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC, t.wh_task_nr
      IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC) AS grp_who_last,
   ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t
      .conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr
      , t.wh_task_item IS NULL, t.wh_task_item) AS grp_who_emp_first,
   ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t
      .conf_by, t.queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC, t.wh_task_nr
      IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC) AS grp_who_emp_last,
    CASE
    WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
            , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
            IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
            , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
            , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)
         ) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
           ORDER BY t.start_dt IS NULL, t.start_dt, t.start_tm IS NULL, t.start_tm)) = 1 AND t.queue <> 'WHO_CANCEL'
    THEN O.start_dt
    WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
          , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL
          , t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) <> 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
          , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
          , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) =
      1
    THEN t.conf_dt
    WHEN t.queue = 'WHO_CANCEL' AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING)
           , CAST(t.wh_ord_nr AS STRING), t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t
           .conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) = 1 AND (ROW_NUMBER()
       OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by,
          t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr
          , t.wh_task_item IS NULL, t.wh_task_item)) = 1
    THEN t.start_dt
    ELSE LAG(t.conf_dt) OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
       , t.conf_by ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr
       , t.wh_task_item IS NULL, t.wh_task_item)
    END AS pick_start_dt,
    CASE
    WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
            , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
            IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
            , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
            , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)
         ) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
           ORDER BY t.start_dt IS NULL, t.start_dt, t.start_tm IS NULL, t.start_tm)) = 1 AND t.queue <> 'WHO_CANCEL'
    THEN O.start_tm
    WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
           , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
           IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
           , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
           , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item))
       = 1 AND t.queue = 'WHO_CANCEL'
    THEN t.start_tm
    WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
          , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL
          , t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) <> 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
          , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
          , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) =
      1
    THEN t.conf_tm
    ELSE LAG(t.conf_tm) OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
       , t.conf_by ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr
       , t.wh_task_item IS NULL, t.wh_task_item)
    END AS pick_start_tm,
   TIME_TRUNC(CASE
     WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
             , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
             IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
             , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
             , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item
           )) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
            ORDER BY t.start_dt IS NULL, t.start_dt, t.start_tm IS NULL, t.start_tm)) = 1 AND t.queue <> 'WHO_CANCEL'
     THEN O.start_tm
     WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
            , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
            IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
            , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
            , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)
         ) = 1 AND t.queue = 'WHO_CANCEL'
     THEN t.start_tm
     WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
           , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
           IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) <> 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
           , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
           , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item))
       = 1
     THEN t.conf_tm
     ELSE LAG(t.conf_tm) OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
        , t.conf_by ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr
        , t.wh_task_item IS NULL, t.wh_task_item)
     END, HOUR) AS pick_start_tm_hh,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
          , t.queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC, t.wh_task_nr
          IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC)) = 1 AND (ROW_NUMBER() OVER
        (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue
          ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC, t.wh_task_nr IS NULL
          DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC)) = 1, t.conf_dt, t.conf_dt) AS
   pick_end_dt,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
          , t.queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC, t.wh_task_nr
          IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC)) = 1 AND (ROW_NUMBER() OVER
        (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue
          ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC, t.wh_task_nr IS NULL
          DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC)) = 1, t.conf_tm, t.conf_tm) AS
   pick_end_tm,
   TIME_ADD(TIME_TRUNC(IF((ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
            , t.queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC, t.wh_task_nr
            IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC)) = 1 AND (ROW_NUMBER()
         OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by
            , t.queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC, t.wh_task_nr
            IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC)) = 1, t.conf_tm, t.conf_tm
      ), HOUR), INTERVAL 1 HOUR) AS pick_end_tm_hh,
    TIMESTAMP_DIFF(CAST(IF((ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
             , t.queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC, t.wh_task_nr
             IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC)) = 1 AND (ROW_NUMBER()
          OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by
             , t.queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC, t.wh_task_nr
             IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC)) = 1, t.conf_dt, t.conf_dt
       ) AS DATETIME), CAST(CASE
       WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
               , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
               IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
               , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t
               .conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item
               )) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
              ORDER BY t.start_dt IS NULL, t.start_dt, t.start_tm IS NULL, t.start_tm)) = 1 AND t.queue <> 'WHO_CANCEL'
       THEN O.start_dt
       WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
             , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
             IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) <> 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
             , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
             , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item
           )) = 1
       THEN t.conf_dt
       WHEN t.queue = 'WHO_CANCEL' AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING)
              , CAST(t.wh_ord_nr AS STRING), t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL
              , t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) = 1 AND (ROW_NUMBER()
          OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by
             , t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr
             , t.wh_task_item IS NULL, t.wh_task_item)) = 1
       THEN t.start_dt
       ELSE LAG(t.conf_dt) OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
          , t.conf_by ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr
          , t.wh_task_item IS NULL, t.wh_task_item)
       END AS DATETIME), SECOND) + TIME_DIFF(IF((ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING)
            , CAST(t.wh_ord_nr AS STRING), t.queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL
            DESC, t.conf_tm DESC, t.wh_task_nr IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item
            DESC)) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
            , t.conf_by, t.queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC
            , t.wh_task_nr IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC)) = 1, t.conf_tm
      , t.conf_tm), CASE
      WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
              , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
              IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
              , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
              , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item
              )) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
             ORDER BY t.start_dt IS NULL, t.start_dt, t.start_tm IS NULL, t.start_tm)) = 1 AND t.queue <> 'WHO_CANCEL'
      THEN O.start_tm
      WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
             , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
             IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) = 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
             , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
             , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item
           )) = 1 AND t.queue = 'WHO_CANCEL'
      THEN t.start_tm
      WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
            , t.conf_dt, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr
            IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)) <> 1 AND (ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING)
            , CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING), t.conf_by, t.queue ORDER BY t.conf_dt IS NULL, t.conf_dt
            , t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr, t.wh_task_item IS NULL, t.wh_task_item)
         ) = 1
      THEN t.conf_tm
      ELSE LAG(t.conf_tm) OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
         , t.conf_by ORDER BY t.conf_dt IS NULL, t.conf_dt, t.conf_tm IS NULL, t.conf_tm, t.wh_task_nr IS NULL, t.wh_task_nr
         , t.wh_task_item IS NULL, t.wh_task_item)
      END, SECOND) AS work_tm_sec,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t.client_id AS STRING), CAST(t.wh_id AS STRING), CAST(t.wh_ord_nr AS STRING)
          , t.conf_by, t.queue ORDER BY t.conf_dt IS NULL DESC, t.conf_dt DESC, t.conf_tm IS NULL DESC, t.conf_tm DESC,
          t.wh_task_nr IS NULL DESC, t.wh_task_nr DESC, t.wh_task_item IS NULL DESC, t.wh_task_item DESC)) = 1 AND t.queue
       = t.first_queue, b.break_sec, NULL) AS sum_break_sec
  FROM TASKSFIRSTQUEUE AS t
   LEFT JOIN ldl_logop_fe_mstr_logop.v_sapewm_whord AS O ON t.client_id = O.client_id AND t.wh_id = O.wh_id AND t.wh_ord_nr
      = O.wh_ord_nr
   LEFT JOIN BREAKS AS b ON t.client_id = b.client_id AND t.wh_id = b.wh_id AND t.wh_ord_nr = b.wh_ord_nr AND t.conf_by
     = b.crtd_by
   LEFT JOIN ldl_logop_fe_mstr_logop.v_lu_picking_queue_perfarea AS Q ON t.client_id = Q.client_id AND t.wh_id = Q.wh_id
       AND t.queue = Q.queue);