/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_nf_add_2
Description		|	SAP EWM NF - add view with calculations for kpi view 
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_nf_add_2 (scan_guid OPTIONS(description='Unofficial PK'),
client_id OPTIONS(description='Client id - calculated based on the country_2 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number'), return_num OPTIONS(description='Return number'),
product_num OPTIONS(description='Product Number'), defect_flag OPTIONS(description='Flag: Is defect'), art_unkn_flag
OPTIONS(description='Flag: Is article unknown'), is_in_ret_flag OPTIONS(description='Flag: Is in return'), sale_flag
OPTIONS(description='Flag: Is Special Sales_2'), is_unp_flag OPTIONS(description='Flag: Is Unpacked'), non_sortable_flag
OPTIONS(description='Flag: non sortable'), qty OPTIONS(description='Quantity per scan - always one'), unit_2
OPTIONS(description='Unit_2 of Measure'), station_id OPTIONS(description='Id of Scan Station in NF counting process'),
conf_dt OPTIONS(description='Created On'), created_time OPTIONS(description='Created At'), conf_dt_short
OPTIONS(description='Short time format'), created_time_conv
OPTIONS(description='Converted created_time for Time Filter'), created_by OPTIONS(description='Created By'), undo_flag
OPTIONS(description='Undo flag'), offline_flag OPTIONS(description='Offline Sorting'), shift_flag
OPTIONS(description='What shift did scan occured on'), non_adv_def_flag OPTIONS(description='Non advised defect scan'),
nr_2 OPTIONS(description='Flag: 2nd option for scan to be considered as Non Recall'), nr_2_ok
OPTIONS(description='Flag: Option for DEF'), nr_3 OPTIONS(description='Flag: 3rd consideration for NR/DEF'), nr_4_ok
OPTIONS(description='Flag: 4th consideration for NR/DEF'), nr_5_ok
OPTIONS(description='Flag: 5th consideration for NR/DEF'), time_selector
OPTIONS(description='Assort data in hourly buckets'), time_hour, time_date, time_month, time_year, time_minute,
time_week, multi_base, multi_flag OPTIONS(description='Original Case/Multiplicator Quota Flag'), dwh_created
OPTIONS(description='Record created at'), dwh_updated OPTIONS(description='Record updated at'), op_dt_prev
OPTIONS(description='Operation date of previous warehouse task'), op_tm_prev
OPTIONS(description='Operation time of previous warehouse task'), prev_op_tm_diff_sec
OPTIONS(description='Time in seconds between last and current operation'), emp_wrk_shift_start_fg
OPTIONS(description='Flag for first operation of a working shift of an employee_2'), work_tm_sec
OPTIONS(description='Recorded working time in seconds'), work_tm_sec_net
OPTIONS(description='Net working time in seconds without pauses and with standard time'), ex_quan
OPTIONS(description='Expected quantities from NFLIMOREPORT'), repeat_qty OPTIONS(description='Quantity for scans'))
OPTIONS(DESCRIPTION = `VIEW BASED ON EMPLOYEE_2 PERFORMANCE`) AS SELECT T.scan_guid,
 T.client_id,
 T.wh_id,
 T.zz_refbs AS return_num,
 T.productno AS product_num,
 T.defect AS defect_flag,
 T.art_unknown AS art_unkn_flag,
 T.is_in_ret AS is_in_ret_flag,
 T.sps AS sale_flag,
 IF(T.is_unpacked = 'X', 1, 0) AS is_unp_flag,
 T.sort_req AS non_sortable_flag,
 T.repeat_qty AS qty,
 T.uom AS unit_2,
 T.station_id,
 T.created_date AS conf_dt,
 T.created_time,
 SUBSTR(SUBSTR(CAST(T.created_time AS STRING), 1, 8), 0, 5) AS conf_dt_short,
  CASE
  WHEN SUBSTR(SUBSTR(CAST(T.created_time AS STRING), 1, 8), 4, 2) BETWEEN '00' AND '14'
  THEN CONCAT(SUBSTR(SUBSTR(CAST(T.created_time AS STRING), 1, 8), 1, 2), ':00')
  WHEN SUBSTR(SUBSTR(CAST(T.created_time AS STRING), 1, 8), 4, 2) BETWEEN '15' AND '44'
  THEN CONCAT(SUBSTR(SUBSTR(CAST(T.created_time AS STRING), 1, 8), 1, 2), ':30')
  WHEN SUBSTR(SUBSTR(CAST(T.created_time AS STRING), 1, 8), 4, 2) BETWEEN '45' AND '59'
  THEN CONCAT(SUBSTR(SUBSTR(CAST(TIME_ADD(T.created_time, INTERVAL 1 HOUR) AS STRING), 1, 8), 1, 2), ':00')
  ELSE NULL
  END AS created_time_conv,
 T.creusr AS created_by,
 T.undo_set AS undo_flag,
 T.offline_srt AS offline_flag,
  CASE
  WHEN T.created_time BETWEEN TIME '06:00:00' AND TIME '14:00:00'
  THEN 1
  WHEN T.created_time BETWEEN TIME '14:00:01' AND TIME '22:00:00'
  THEN 2
  ELSE 3
  END AS shift_flag,
 IF(T.art_unknown = TRUE AND T.defect = TRUE AND T.is_in_ret = TRUE, TRUE, FALSE) AS non_adv_def_flag,
 IF(T.art_unknown = TRUE AND T.defect = TRUE, TRUE, FALSE) AS nr_2,
 IF(T.defect = TRUE AND T.is_in_ret = FALSE AND T.art_unknown = FALSE, TRUE, FALSE) AS nr_2_ok,
 IF(T.defect = TRUE AND T.is_in_ret = TRUE, TRUE, FALSE) AS nr_3,
 IF(T.art_unknown = TRUE AND T.defect = TRUE AND T.is_in_ret = FALSE, TRUE, FALSE) AS nr_4_ok,
 IF(T.art_unknown = TRUE AND T.defect = FALSE AND T.is_in_ret = FALSE, TRUE, FALSE) AS nr_5_ok,
 CAST(TRIM(LEFT(SUBSTR(CAST(T.created_time AS STRING), 1, 8), 5)) AS TIME) AS time_selector,
 EXTRACT(HOUR FROM T.created_time) AS time_hour,
 EXTRACT(DAY FROM T.created_date) AS time_date,
 EXTRACT(MONTH FROM T.created_date) AS time_month,
 EXTRACT(YEAR FROM T.created_date) AS time_year,
 EXTRACT(MINUTE FROM T.created_time) AS time_minute,
 T.zz_kw AS time_week,
 RANK() OVER (ORDER BY T.productno IS NULL, T.productno, T.station_id IS NULL, T.station_id, T.created_date IS NULL, T.created_date
    , T.created_time IS NULL, T.created_time) AS multi_base,
   (COUNT(*) OVER (PARTITION BY T.productno, T.station_id, T.created_date, T.created_time RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 1 AS multi_flag,
 T.dwh_created,
 T.dwh_updated,
 LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date
    IS NULL, T.created_date, T.created_time IS NULL, T.created_time) AS op_dt_prev,
 LAG(T.created_time) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date
    IS NULL, T.created_date, T.created_time IS NULL, T.created_time) AS op_tm_prev,
  TIMESTAMP_DIFF(CAST(T.created_date AS DATETIME), CAST(LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING)
       , CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL,
       T.created_time) AS DATETIME), SECOND) + TIME_DIFF(T.created_time, LAG(T.created_time) OVER (PARTITION BY CAST(T.client_id AS STRING)
      , CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T
      .created_time), SECOND) AS prev_op_tm_diff_sec,
 IF((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id ORDER BY
       T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time)) IS NULL OR TIMESTAMP_DIFF(SAFE_CAST(T
       .created_date as DATETIME), SAFE_CAST((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING)
           , T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time)) as DATETIME)
      ,SECOND) + TIME_DIFF(T.created_time, LAG(T.created_time) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING)
         , T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time), SECOND
      ) > 28800, 1, 0) AS emp_wrk_shift_start_fg,
 IF(IF((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id
       ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time)) IS NULL OR
       TIMESTAMP_DIFF(SAFE_CAST(T.created_date as DATETIME), SAFE_CAST((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING)
             , CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time
             IS NULL, T.created_time)) as DATETIME), SECOND) + TIME_DIFF(T.created_time, LAG(T.created_time) OVER (PARTITION BY CAST(T.client_id AS STRING)
           , CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time
           IS NULL, T.created_time), SECOND) > 28800, 1, 0) <> 1, TIMESTAMP_DIFF(SAFE_CAST(T.created_date as DATETIME),
    SAFE_CAST((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id
         ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time)) as DATETIME), SECOND)
   + TIME_DIFF(T.created_time, LAG(T.created_time) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING)
       , T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time), SECOND)
  , NULL) AS work_tm_sec,
 IF(IF((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id
        ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time)) IS NULL OR
        TIMESTAMP_DIFF(SAFE_CAST(T.created_date as DATETIME), SAFE_CAST((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING)
              , CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time
              IS NULL, T.created_time)) as DATETIME), SECOND) + TIME_DIFF(T.created_time, LAG(T.created_time) OVER (PARTITION BY CAST(T.client_id AS STRING)
            , CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time
            IS NULL, T.created_time), SECOND) > 28800, 1, 0) = 1 OR IF(IF((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING)
            , CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time
            IS NULL, T.created_time)) IS NULL OR TIMESTAMP_DIFF(SAFE_CAST(T.created_date as DATETIME), SAFE_CAST((LAG(T
              .created_date) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id
              ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time)) as DATETIME),
           SECOND) + TIME_DIFF(T.created_time, LAG(T.created_time) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING)
              , T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time),
           SECOND) > 28800, 1, 0) <> 1, TIMESTAMP_DIFF(SAFE_CAST(T.created_date as DATETIME), SAFE_CAST((LAG(T.created_date
          ) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date
            IS NULL, T.created_date, T.created_time IS NULL, T.created_time)) as DATETIME), SECOND) + TIME_DIFF(T.created_time
       , LAG(T.created_time) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id
        ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time), SECOND), NULL) > 900,
  0, IF(IF((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id
        ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time)) IS NULL OR
        TIMESTAMP_DIFF(SAFE_CAST(T.created_date as DATETIME), SAFE_CAST((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING)
              , CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time
              IS NULL, T.created_time)) as DATETIME), SECOND) + TIME_DIFF(T.created_time, LAG(T.created_time) OVER (PARTITION BY CAST(T.client_id AS STRING)
            , CAST(T.wh_id AS STRING), T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time
            IS NULL, T.created_time), SECOND) > 28800, 1, 0) <> 1, TIMESTAMP_DIFF(SAFE_CAST(T.created_date as DATETIME)
     ,SAFE_CAST((LAG(T.created_date) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING), T.station_id
          ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time)) as DATETIME), SECOND)
    + TIME_DIFF(T.created_time, LAG(T.created_time) OVER (PARTITION BY CAST(T.client_id AS STRING), CAST(T.wh_id AS STRING)
        , T.station_id ORDER BY T.created_date IS NULL, T.created_date, T.created_time IS NULL, T.created_time), SECOND
     ), NULL)) AS work_tm_sec_net,
 L.ex_quan,
 T.repeat_qty
FROM ldl_logop_data.t_sapewm_nfemployeeperformance_2 AS T
 LEFT JOIN ldl_logop_data.t_sapewm_nflimoreport_2 AS L ON T.client_id = L.client_id AND T.lgnum = L.lgnum AND T.zz_refbs =
     L.zz_refbs AND T.zz_kw = L.zz_kw AND EXTRACT(YEAR FROM T.created_date) = CAST(L.zz_year AS FLOAT64)
WHERE T.station_id <> 'SE_MAN'
 AND T.created_date >= DATE_ADD(DATE(CURRENT_TIMESTAMP()), INTERVAL - 2 MONTH)
 AND NOT T.undo_set
 AND T.productno IS NOT NULL;