/* Reverted for Story 417399 */ CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_time_main AS
/* UNION1: workingtimes in t_time_tracking_record table (GPS) */ /* P10 = Kommen, P20 = Gehen */
/* P15 = Pause Start, P25 = Pause Ende */ /* Story 417399 added cancellatiON logic */
/* UNION2: workingtimes in t_time_tracking_period table (PTM) */ /* calculate date-difference in secONds */
/* Arbeitszeit in Stunden * Leistungsfaktor */ /* ,pwt.break_duratiON_minute  * 1.00000 / 60  AS break_hrs */
/* performance_factor AS multiplier */ /* Pausenzeit in Stunden */
/* UNION3: workingtimes in t_time_tracking_day table (GPS missing) */
/* External Hours can be the same employee_hASh, but different time_record_id */ /* take the latest record for */
/* gps_missing */ /* UNION4: Performance_relevant_absence_hours GPS */
/* time_record_change_dt replaces former dwh_updated */ /* UNION5: Performance_relevant_absence_hours PTM */
/* calculate date-difference in secONds */ SELECT client_id,
 loc_sid AS loc_sid_store,
 dwh_cal_dt,
 SUM(working_time_brutto_hrs) AS work_time_gross_hr,
 SUM(working_time_netto_hrs) AS work_time_net_hr,
 SUM(break_hrs) AS break_hr,
 SUM(perf_rel_absence_hrs) AS perform_relev_absence_hr
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
   FROM (SELECT gwt.client_id,
      gwt.loc_sid,
      gwt.employee_hash,
      gwt.dwh_cal_dt,
      gwt.event_type_cd,
           DATE_DIFF(DATE(gwt.event_tmsp), (MIN(DATE(gwt.event_tmsp)) OVER (PARTITION BY CAST(gwt.client_id AS STRING), CAST(gwt.loc_sid AS STRING)
                , gwt.employee_hash RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), DAY) * 24 * 3600 +
          EXTRACT(HOUR FROM gwt.event_tmsp) * 3600 + EXTRACT(MINUTE FROM gwt.event_tmsp) * 60 + EXTRACT(SECOND FROM gwt
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
          dwh_updated,
          timestamp_load_bcbi
         FROM ldl_bcbi_fe_mstr_bcbi.t_time_tracking_record
         WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 61
              MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
          AND event_type_cd NOT IN ('P01', 'P02')
         QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), CAST(time_record_id AS STRING)
               ORDER BY time_record_change_dt IS NULL, time_record_change_dt, dwh_load_id IS NULL DESC, dwh_load_id DESC
               )) = 1) AS pdsnr_dedup
       WHERE pdsnr_cancel_fg_sum = 0
       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), employee_hash,
             event_tmsp, event_type_cd /* Change for ticket INC3331966 */ ORDER BY time_record_change_dt IS NULL DESC,
             time_record_change_dt DESC, cancel_fg IS NULL, cancel_fg)) = 1) AS gwt
      INNER JOIN (SELECT *
       FROM ldl_bcbi_fe_mstr_bcbi.t_time_type_hist
       WHERE active_to_dt = DATE '9999-12-30') AS typ ON gwt.client_id = typ.client_id AND gwt.time_type_sid = typ.time_type_sid
         /* AND typ.presence_fg   = 1 */ /* es hANDelt sich um einen Anwesenheits-(1) Abwesenheitstyp(0) */ AND typ.performance_relevant_fg
         = 1 /* leistungsrelevant */
     WHERE gwt.cancel_fg = 0 /* Kein Storno */) AS t
   UNION ALL
   SELECT pwt.client_id,
    pwt.loc_sid,
    pwt.dwh_cal_dt,
      CASE
      WHEN pwt.period_start_tmsp IS NULL OR pwt.period_end_tmsp IS NULL
      THEN 0.00000
      ELSE CAST((EXTRACT(HOUR FROM pwt.period_end_tmsp) * 3600 + EXTRACT(MINUTE FROM pwt.period_end_tmsp) * 60 + EXTRACT(SECOND FROM pwt.period_end_tmsp) - (EXTRACT(HOUR FROM pwt.period_start_tmsp) * 3600 + EXTRACT(MINUTE FROM pwt.period_start_tmsp) * 60 + EXTRACT(SECOND FROM pwt.period_start_tmsp)
            ) + DATE_DIFF(DATE(pwt.period_end_tmsp), DATE(pwt.period_start_tmsp), DAY) * 86400) / 3600.00000 AS NUMERIC)
      END * pwt.performance_factor AS working_time_brutto_hrs,
    CAST(CAST(pwt.break_duration_minute AS BIGNUMERIC) / 60 * pwt.performance_factor AS NUMERIC) AS break_hrs,
       CASE
       WHEN pwt.period_start_tmsp IS NULL OR pwt.period_end_tmsp IS NULL
       THEN 0.00000
       ELSE CAST((EXTRACT(HOUR FROM pwt.period_end_tmsp) * 3600 + EXTRACT(MINUTE FROM pwt.period_end_tmsp) * 60 + EXTRACT(SECOND FROM pwt.period_end_tmsp) - (EXTRACT(HOUR FROM pwt.period_start_tmsp) * 3600 + EXTRACT(MINUTE FROM pwt.period_start_tmsp) * 60 + EXTRACT(SECOND FROM pwt.period_start_tmsp
               )) + DATE_DIFF(DATE(pwt.period_end_tmsp), DATE(pwt.period_start_tmsp), DAY) * 86400) / 3600.00000 AS NUMERIC)
       END * pwt.performance_factor - CAST(CAST(pwt.break_duration_minute AS BIGNUMERIC) / 60 * pwt.performance_factor
      AS NUMERIC) AS working_time_netto_hrs,
    CAST(NULL AS NUMERIC) AS perf_rel_absence_hrs
   FROM (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.t_time_tracking_period
     WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
        , DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
      AND time_type_grp_cd = 'WT' /* PTM workingtime */
       /* 1 persON can several record per day, so either start_time, or record_id is needed in partitiON */
       /* Take the latest record for each time_record_id */
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), CAST(time_record_id AS STRING)
           , employee_hash, dwh_cal_dt ORDER BY time_record_change_tmsp IS NULL, time_record_change_tmsp)) = 1) AS pwt
    INNER JOIN (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.t_time_type_hist
     WHERE active_to_dt = DATE '9999-12-30') AS typ ON pwt.client_id = typ.client_id AND pwt.time_type_sid = typ.time_type_sid
       /* AND typ.presence_fg   = 1 */ /* es hANDelt sich um einen Anwesenheits-(1) Abwesenheitstyp(0) */ AND typ.performance_relevant_fg
       = 1 /* leistungsrelevant */
   WHERE pwt.cancel_fg = 0 /* Kein Storno */
    AND pwt.deleted_fg = 0 /* Filter auf deleted_fg darf erst nach dem QUALIFY erfolgen */
   UNION ALL
   SELECT gmt.client_id,
    gmt.loc_sid,
    gmt.dwh_cal_dt,
    ROUND(CAST(gmt.hours_cnt AS NUMERIC), 4) AS working_time_brutto_hrs,
    0 AS break_hrs,
    ROUND(CAST(gmt.hours_cnt AS NUMERIC), 4) AS working_time_netto_hrs,
    CAST(NULL AS NUMERIC) AS perf_rel_absence_hrs
   FROM (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.t_time_tracking_day
     WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
        , DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), CAST(time_record_id AS STRING)
           , CAST(/* employee_hASh, */ time_type_sid AS STRING), dwh_cal_dt ORDER BY time_record_change_dt IS NULL,
           time_record_change_dt, time_record_id IS NULL, time_record_id)) = 1) AS gmt
    INNER JOIN (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.t_time_type_hist
     WHERE active_to_dt = DATE '9999-12-30') AS typ ON gmt.client_id = typ.client_id AND gmt.time_type_sid = typ.time_type_sid
          AND gmt.cancel_fg = 0 AND typ.presence_fg = 1
       /* es hANDelt sich um einen Anwesenheits-(1) Abwesenheitstyp(0) */ AND typ.performance_relevant_fg = 1
      /* leistungsrelevant */
   WHERE gmt.cancel_fg = 0 /* Kein Storno */
   UNION ALL
   SELECT td.client_id,
    td.loc_sid,
    td.dwh_cal_dt,
    CAST(NULL AS NUMERIC) AS working_time_brutto_hrs,
    CAST(NULL AS NUMERIC) AS break_hrs,
    CAST(NULL AS NUMERIC) AS working_time_netto_hrs,
    CAST(td.hours_cnt AS NUMERIC) AS absence_hours
   FROM (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.t_time_tracking_day
     WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
        , DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), dwh_cal_dt, CAST(time_record_id AS STRING)
           , CAST(/* employee_hASh, */ time_type_sid AS STRING) ORDER BY time_record_change_dt IS NULL,
           time_record_change_dt, time_record_id IS NULL, time_record_id)) = 1) AS td
    INNER JOIN (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.t_time_type_hist
     WHERE active_to_dt = DATE '9999-12-30') AS typ ON td.client_id = typ.client_id AND td.time_type_sid = typ.time_type_sid
         AND typ.presence_fg = 0 /* es hANDelt sich um einen Anwesenheits-(1) Abwesenheitstyp(0) */ AND typ.performance_relevant_fg
       = 1 /* leistungsrelevant */
   WHERE td.cancel_fg = 0 /* Kein Storno */
   UNION ALL
   SELECT tp.client_id,
    tp.loc_sid,
    tp.dwh_cal_dt,
    CAST(NULL AS NUMERIC) AS working_time_brutto_hrs,
    CAST(NULL AS NUMERIC) AS break_hrs,
    CAST(NULL AS NUMERIC) AS working_time_netto_hrs,
     CASE
     WHEN tp.period_start_tmsp IS NULL OR tp.period_end_tmsp IS NULL
     THEN 0.00000
     WHEN CAST(tp.period_start_tmsp AS TIME) = '00:00:00' OR CAST(tp.period_end_tmsp AS TIME) = '00:00:00'
     THEN 0.00000
     ELSE CAST((EXTRACT(HOUR FROM tp.period_end_tmsp) * 3600 + EXTRACT(MINUTE FROM tp.period_end_tmsp) * 60 + EXTRACT(SECOND FROM tp.period_end_tmsp) - (EXTRACT(HOUR FROM tp.period_start_tmsp) * 3600 + EXTRACT(MINUTE FROM tp.period_start_tmsp) * 60 + EXTRACT(SECOND FROM tp.period_start_tmsp)) +
          DATE_DIFF(DATE(tp.period_end_tmsp), DATE(tp.period_start_tmsp), DAY) * 86400) / 3600.00000 AS NUMERIC)
     END AS absence_hours
   FROM (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.t_time_tracking_period
     WHERE dwh_cal_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
        , DATE_ADD(CURRENT_DATE, INTERVAL - 61 MONTH))
      AND time_type_grp_cd = 'MT' /* PTM missing */
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(loc_sid AS STRING), dwh_cal_dt,
           employee_hash, CAST(time_type_sid AS STRING), period_start_tmsp ORDER BY time_record_change_tmsp IS NULL,
           time_record_change_tmsp, time_record_id IS NULL, time_record_id)) = 1) AS tp
    INNER JOIN (SELECT *
     FROM ldl_bcbi_fe_mstr_bcbi.t_time_type_hist
     WHERE active_to_dt = DATE '9999-12-30') AS typ ON tp.client_id = typ.client_id AND tp.time_type_sid = typ.time_type_sid
       /* AND typ.presence_fg  = 0 */ /* es hANDelt sich um einen Anwesenheits-(1) Abwesenheitstyp(0) */ AND typ.performance_relevant_fg
       = 1 /* leistungsrelevant */
   WHERE tp.cancel_fg = 0 /* Kein Storno */
    AND tp.deleted_fg = 0 /* Filter auf deleted_fg darf erst nach dem QUALIFY erfolgen */) AS lvl0
GROUP BY client_id,
 loc_sid_store,
 dwh_cal_dt;