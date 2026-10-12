CREATE OR REPLACE VIEW produktion_fe_mstr_bge_palettierer.v_fact_alerts_2 AS SELECT alerts_priority_id,
 alerts_message_id,
 alerts_type_id,
 cal_dt,
 DATE(DATETIME_ADD(CAST(REPLACE(CAST(cal_dt AS STRING) || ' ' || CAST(alerts_tm AS STRING), ',', ':') AS DATETIME),
   INTERVAL CAST(- alerts_duration_diff AS INTEGER) SECOND)) AS cal_start_dt,
 cal_dt AS cal_end_dt,
 alerts_day_shift_id,
 alerts_location_id,
 alerts_tm,
 TIME(DATETIME_ADD(CAST(REPLACE(CAST(cal_dt AS STRING) || ' ' || CAST(alerts_tm AS STRING), ',', ':') AS DATETIME),
   INTERVAL CAST(- alerts_duration_diff AS INTEGER) SECOND)) AS alerts_start_tm,
 alerts_tm AS alerts_end_tm,
 alerts_duration_diff,
 MOD(EXTRACT(HOUR FROM alerts_tm) + 18, 24) AS hour_sort,
 IFNULL(alerts_production_stop_fg, FALSE) AS alerts_production_stop_fg,
 alerts_deleted_fg
FROM produktion_core.t_fact_alerts_2
WHERE NOT alerts_deleted_fg;