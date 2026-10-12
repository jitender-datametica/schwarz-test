CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_work_time_store_day_2 AS SELECT client_id,
 loc_sid AS loc_sid_store,
 dwh_cal_dt,
 SUM(working_time_brutto_hrs) AS work_time_gross_hr,
 SUM(working_time_netto_hrs) AS work_time_net_hr,
 SUM(break_hrs) AS break_hr,
 SUM(perf_rel_absence_hrs) AS perform_relev_absence_hr,
 - 1 AS dwh_load_id,
 CURRENT_TIMESTAMP() AS dwh_created,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM (SELECT client_id,
    loc_sid,
    dwh_cal_dt,
    CAST(CASE
       WHEN event_type_cd = 'P20'
       THEN CAST(timestamp_seconds AS INTEGER)
       WHEN event_type_cd = 'P10'
       THEN CAST(timestamp_seconds * - 1 AS INTEGER)
       ELSE 0
       END / 3600.00000 AS NUMERIC) AS working_time_brutto_hrs,
    CAST(CASE
       WHEN event_type_cd = 'P25'
       THEN CAST(timestamp_seconds AS INTEGER)
       WHEN event_type_cd = 'P15'
       THEN CAST(timestamp_seconds * - 1 AS INTEGER)
       ELSE 0
       END / 3600.00000 AS NUMERIC) AS break_hrs,
     CAST(CASE
        WHEN event_type_cd = 'P20'
        THEN CAST(timestamp_seconds AS INTEGER)
        WHEN event_type_cd = 'P10'
        THEN CAST(timestamp_seconds * - 1 AS INTEGER)
        ELSE 0
        END / 3600.00000 AS NUMERIC) - CAST(CASE
        WHEN event_type_cd = 'P25'
        THEN CAST(timestamp_seconds AS INTEGER)
        WHEN event_type_cd = 'P15'
        THEN CAST(timestamp_seconds * - 1 AS INTEGER)
        ELSE 0
        END / 3600.00000 AS NUMERIC) AS working_time_netto_hrs,
    CAST(NULL AS NUMERIC) AS perf_rel_absence_hrs
   FROM (SELECT GWT.client_id,
      GWT.loc_sid,
      GWT.employee_hash,
      GWT.dwh_cal_dt,
      GWT.event_type_cd,
           DATE_DIFF(DATE(GWT.event_tmsp), (MIN(DATE(GWT.event_tmsp)) OVER (PARTITION BY CAST(GWT.client_id AS STRING), CAST(GWT.loc_sid AS STRING)
                , GWT.employee_hash RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), DAY) * 24 * 3600 +
          EXTRACT(HOUR FROM GWT.event_tmsp) * 3600 + EXTRACT(MINUTE FROM GWT.event_tmsp) * 60 + EXTRACT(SECOND FROM GWT
        .event_tmsp) AS timestamp_seconds
     FROM (SELECT *
       FROM (SELECT SUM(CASE
            WHEN cancel_fg = 1
            THEN 1
            ELSE 0
            END) OVER (PARTITION BY CAST(time_record_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
           UNBOUNDED FOLLOWING) AS pdsnr_cancel_fg_sum,
          client_id,
          loc_sid,
          time_record_id,
          time_record_change_dt,
          employee_hash,
          time_type_sid,
          event_type_cd,
          event_tmsp,
          event_booking_type_cd,
          cancel_fg,
          dwh_cal_dt,
          dwh_load_id,
          dwh_created,
          dwh_updated
         FROM ldl_p_lew_core_ac.v_time_tracking_record_2
         WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 61
              MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
          AND event_type_cd NOT IN ('P01', 'P02')
         QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), CAST(time_record_id AS STRING)
               ORDER BY time_record_change_dt IS NULL, time_record_change_dt, dwh_load_id IS NULL DESC, dwh_load_id DESC
               )) = 1) AS PDSNR_DEDUP
       WHERE pdsnr_cancel_fg_sum = 0
       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), employee_hash,
             event_tmsp, event_type_cd ORDER BY time_record_change_dt IS NULL DESC, time_record_change_dt DESC,
             cancel_fg IS NULL, cancel_fg)) = 1) AS GWT
      INNER JOIN ldl_p_lew_core_ac.v_time_type_hist_2 AS TYP ON GWT.client_id = TYP.client_id AND GWT.time_type_sid = TYP
          .time_type_sid AND TYP.performance_relevant_fg = 1 AND GWT.dwh_cal_dt BETWEEN TYP.active_from_dt AND TYP.active_to_dt
        
     WHERE GWT.cancel_fg = 0) AS T
   UNION ALL
   SELECT PWT.client_id,
    PWT.loc_sid,
    PWT.dwh_cal_dt,
      CASE
      WHEN PWT.period_start_tmsp IS NULL OR PWT.period_end_tmsp IS NULL
      THEN 0.00000
      ELSE CAST((EXTRACT(HOUR FROM PWT.period_end_tmsp) * 3600 + EXTRACT(MINUTE FROM PWT.period_end_tmsp) * 60 + EXTRACT(SECOND FROM PWT.period_end_tmsp) - (EXTRACT(HOUR FROM PWT.period_start_tmsp) * 3600 + EXTRACT(MINUTE FROM PWT.period_start_tmsp) * 60 + EXTRACT(SECOND FROM PWT.period_start_tmsp)
            ) + DATE_DIFF(DATE(PWT.period_end_tmsp), DATE(PWT.period_start_tmsp), DAY) * 86400) / 3600.00000 AS NUMERIC)
      END * PWT.performance_factor AS working_time_brutto_hrs,
    CAST(CAST(PWT.break_duration_minute AS BIGNUMERIC) / 60 * PWT.performance_factor AS NUMERIC) AS break_hrs,
       CASE
       WHEN PWT.period_start_tmsp IS NULL OR PWT.period_end_tmsp IS NULL
       THEN 0.00000
       ELSE CAST((EXTRACT(HOUR FROM PWT.period_end_tmsp) * 3600 + EXTRACT(MINUTE FROM PWT.period_end_tmsp) * 60 + EXTRACT(SECOND FROM PWT.period_end_tmsp) - (EXTRACT(HOUR FROM PWT.period_start_tmsp) * 3600 + EXTRACT(MINUTE FROM PWT.period_start_tmsp) * 60 + EXTRACT(SECOND FROM PWT.period_start_tmsp
               )) + DATE_DIFF(DATE(PWT.period_end_tmsp), DATE(PWT.period_start_tmsp), DAY) * 86400) / 3600.00000 AS NUMERIC)
       END * PWT.performance_factor - CAST(CAST(PWT.break_duration_minute AS BIGNUMERIC) / 60 * PWT.performance_factor
      AS NUMERIC) AS working_time_netto_hrs,
    CAST(NULL AS NUMERIC) AS perf_rel_absence_hrs
   FROM (SELECT *
     FROM ldl_p_lew_core_ac.v_time_tracking_period_2
     WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
        , DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
      AND time_type_grp_cd = 'WT'
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), CAST(time_record_id AS STRING)
           , employee_hash, dwh_cal_dt ORDER BY time_record_change_tmsp IS NULL, time_record_change_tmsp)) = 1) AS PWT
    INNER JOIN ldl_p_lew_core_ac.v_time_type_hist_2 AS TYP ON PWT.client_id = TYP.client_id AND PWT.time_type_sid = TYP.time_type_sid
         AND TYP.performance_relevant_fg = 1 AND PWT.dwh_cal_dt BETWEEN TYP.active_from_dt AND TYP.active_to_dt
   WHERE PWT.cancel_fg = 0
    AND PWT.deleted_fg = 0
   UNION ALL
   SELECT GMT.client_id,
    GMT.loc_sid,
    GMT.dwh_cal_dt,
    ROUND(CAST(GMT.hours_cnt AS NUMERIC), 4) AS working_time_brutto_hrs,
    0 AS break_hrs,
    ROUND(CAST(GMT.hours_cnt AS NUMERIC), 4) AS working_time_netto_hrs,
    CAST(NULL AS NUMERIC) AS perf_rel_absence_hrs
   FROM (SELECT *
     FROM ldl_p_lew_core_ac.v_time_tracking_day_2
     WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
        , DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), CAST(time_record_id AS STRING)
           , CAST(time_type_sid AS STRING), dwh_cal_dt ORDER BY time_record_change_dt IS NULL, time_record_change_dt,
           time_record_id IS NULL, time_record_id)) = 1) AS GMT
    INNER JOIN ldl_p_lew_core_ac.v_time_type_hist_2 AS TYP ON GMT.client_id = TYP.client_id AND GMT.time_type_sid = TYP.time_type_sid
           AND GMT.cancel_fg = 0 AND TYP.presence_fg = 1 AND TYP.performance_relevant_fg = 1 AND GMT.dwh_cal_dt BETWEEN
      TYP.active_from_dt AND TYP.active_to_dt
   WHERE GMT.cancel_fg = 0
   UNION ALL
   SELECT TD.client_id,
    TD.loc_sid,
    TD.dwh_cal_dt,
    CAST(NULL AS NUMERIC) AS working_time_brutto_hrs,
    CAST(NULL AS NUMERIC) AS break_hrs,
    CAST(NULL AS NUMERIC) AS working_time_netto_hrs,
    CAST(TD.hours_cnt AS NUMERIC) AS absence_hours
   FROM (SELECT *
     FROM ldl_p_lew_core_ac.v_time_tracking_day_2
     WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
        , DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), dwh_cal_dt, CAST(time_record_id AS STRING)
           , CAST(time_type_sid AS STRING) ORDER BY time_record_change_dt IS NULL, time_record_change_dt, time_record_id
           IS NULL, time_record_id)) = 1) AS TD
    INNER JOIN ldl_p_lew_core_ac.v_time_type_hist_2 AS TYP ON TD.client_id = TYP.client_id AND TD.time_type_sid = TYP.time_type_sid
          AND TYP.presence_fg = 0 AND TYP.performance_relevant_fg = 1 AND TD.dwh_cal_dt BETWEEN TYP.active_from_dt AND
      TYP.active_to_dt
   WHERE TD.cancel_fg = 0
   UNION ALL
   SELECT TP.client_id,
    TP.loc_sid,
    TP.dwh_cal_dt,
    CAST(NULL AS NUMERIC) AS working_time_brutto_hrs,
    CAST(NULL AS NUMERIC) AS break_hrs,
    CAST(NULL AS NUMERIC) AS working_time_netto_hrs,
     CASE
     WHEN TP.period_start_tmsp IS NULL OR TP.period_end_tmsp IS NULL
     THEN 0.00000
     WHEN CAST(TP.period_start_tmsp AS TIME) = '00:00:00' OR CAST(TP.period_end_tmsp AS TIME) = '00:00:00'
     THEN 0.00000
     ELSE CAST((EXTRACT(HOUR FROM TP.period_end_tmsp) * 3600 + EXTRACT(MINUTE FROM TP.period_end_tmsp) * 60 + EXTRACT(SECOND FROM TP.period_end_tmsp) - (EXTRACT(HOUR FROM TP.period_start_tmsp) * 3600 + EXTRACT(MINUTE FROM TP.period_start_tmsp) * 60 + EXTRACT(SECOND FROM TP.period_start_tmsp)) +
          DATE_DIFF(DATE(TP.period_end_tmsp), DATE(TP.period_start_tmsp), DAY) * 86400) / 3600.00000 AS NUMERIC)
     END AS absence_hours
   FROM (SELECT *
     FROM ldl_p_lew_core_ac.v_time_tracking_period_2
     WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
        , DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
      AND time_type_grp_cd = 'MT'
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), dwh_cal_dt,
           employee_hash, CAST(time_type_sid AS STRING), period_start_tmsp ORDER BY time_record_change_tmsp IS NULL,
           time_record_change_tmsp, time_record_id IS NULL, time_record_id)) = 1) AS TP
    INNER JOIN ldl_p_lew_core_ac.v_time_type_hist_2 AS TYP ON TP.client_id = TYP.client_id AND TP.time_type_sid = TYP.time_type_sid
         AND TYP.performance_relevant_fg = 1 AND TP.dwh_cal_dt BETWEEN TYP.active_from_dt AND TYP.active_to_dt
   WHERE TP.cancel_fg = 0
    AND TP.deleted_fg = 0) AS LVL0
GROUP BY client_id,
 loc_sid_store,
 dwh_cal_dt;