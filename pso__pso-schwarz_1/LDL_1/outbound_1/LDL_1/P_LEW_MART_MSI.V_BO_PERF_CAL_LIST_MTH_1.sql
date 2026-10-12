/*
  Target      : P_LEW_MART_MSI.V_BO_PERF_CAL_LIST_MTH_1
  Source
    P_LEW_CORE_AC
      V_CAL_CALENDARDAY_1
      V_CAL_WEEK_1
  History:
    2018-06-14  Jens Thole
    Inhalt: Ausschnitt aus Kalender - speziell für bo_perflist; wochengranular: t_cal_calendarday_1
    Ausgehend von Woche_1 0 wird die Grundauswahl an relevanten Reportingwochen für die Daily, Weekly und Monthly- Sicht definiert.
    Reportingwochen sind dabei nicht unbedingt mit der Auswahl von Faktendaten zu diesen Wochen gleichzusetzen.
    Für letztere bereitet die View Datengrenzen auf, die aber nur für die Monthly-Ebene Verwendung finden
    Die Reportingwochen-Grundauswahl ist definiert als
    Gegenwartszeitfester:         [fünftletzte Woche_1 vor der aktuellen Woche_1, aktuelle Woche_1]
    Vergangenheitszeitfenster:    [Jahreswochennummerngleiche Woche_1 zur akt-Woche_1 im Vorjahr, siebte Folgewoche dieser Startwoche]
    2021-11-03  zied.nanaa_ext@mail.schwarz
    https://jira.schwarz/browse/REP4-10316
    Patch for KW53 2020 nicht verfügbar im Leistungsübersicht
*/



CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_bo_perf_cal_list_mth_1
OPTIONS(DESCRIPTION = 'AUSSCHNITT AUS KALENDER - SPEZIELL FÜR BO_PERFLIST; WOCHENGRANULAR: T_CAL_CALENDARDAY_1', ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true)
AS
SELECT C.cy_week,
 C.cy_week_seq,
 MIN(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL CAST(ROUND(C.day_of_week) AS INTEGER) DAY), INTERVAL 1 DAY)) AS
 min_dat_calendar_week,
 MIN(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL CAST(ROUND(C.day_of_week) AS INTEGER) DAY), INTERVAL 7 DAY)) AS
 max_dat_calendar_week,
 MIN(C.cy_month) AS min_cy_month,
 MAX(C.cy_month) AS max_cy_month,
 PARSE_DATE('%Y%m%d', CAST(MIN(C.busyear) AS STRING) || '0301') AS min_dat_calendar_month,
 MAX(CASE
   WHEN C.cy_week_seq = 0
   THEN CASE
    WHEN C.cy_day_seq = 0
    THEN C.cal_dt
    ELSE NULL
    END
   ELSE C.cal_dt
   END) AS dat_calc,
 MIN(DATE_SUB(IF(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1
      DAY) = LAST_DAY(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL
       1 DAY)), LAST_DAY(DATE_ADD(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER)
        DAY), INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month
         ) as INTEGER) DAY), INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL 1 DAY)) AS max_dat_calendar_month_plan,
 IF(PARSE_DATE('%Y%m%d', SAFE_CAST(MIN(C.busyear) as STRING) || '0301') = LAST_DAY(PARSE_DATE('%Y%m%d', SAFE_CAST(MIN(C
        .busyear) as STRING) || '0301')), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SAFE_CAST(MIN(C.busyear) as STRING) ||
      '0301'), INTERVAL - 12 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SAFE_CAST(MIN(C.busyear) as STRING) || '0301'),
   INTERVAL - 12 MONTH)) AS min_dat_calendar_month_py,
 IF(MAX(CASE
     WHEN C.cy_week_seq = 0
     THEN CASE
      WHEN C.cy_day_seq = 0
      THEN C.cal_dt
      ELSE NULL
      END
     ELSE C.cal_dt
     END) = LAST_DAY(MAX(CASE
      WHEN C.cy_week_seq = 0
      THEN CASE
       WHEN C.cy_day_seq = 0
       THEN C.cal_dt
       ELSE NULL
       END
      ELSE C.cal_dt
      END)), LAST_DAY(DATE_ADD(MAX(CASE
      WHEN C.cy_week_seq = 0
      THEN CASE
       WHEN C.cy_day_seq = 0
       THEN C.cal_dt
       ELSE NULL
       END
      ELSE C.cal_dt
      END), INTERVAL - 12 MONTH)), DATE_ADD(MAX(CASE
     WHEN C.cy_week_seq = 0
     THEN CASE
      WHEN C.cy_day_seq = 0
      THEN C.cal_dt
      ELSE NULL
      END
     ELSE C.cal_dt
     END), INTERVAL - 12 MONTH)) AS dat_calc_py,
 IF(MIN(DATE_SUB(IF(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1
        DAY) = LAST_DAY(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY),
         INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER
           ) DAY), INTERVAL 1 DAY), INTERVAL 1 MONTH)), DATE_ADD(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C
           .day_of_month) as INTEGER) DAY), INTERVAL 1 DAY), INTERVAL 1 MONTH)), INTERVAL 1 DAY)) = LAST_DAY(MIN(DATE_SUB(IF(DATE_ADD(DATE_SUB(C
          .cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY) = LAST_DAY(DATE_ADD(DATE_SUB(C
           .cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_ADD(DATE_SUB(C
           .cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY), INTERVAL 1 MONTH)),
       DATE_ADD(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY
         ), INTERVAL 1 MONTH)), INTERVAL 1 DAY))), LAST_DAY(DATE_ADD(MIN(DATE_SUB(IF(DATE_ADD(DATE_SUB(C.cal_dt,
          INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY) = LAST_DAY(DATE_ADD(DATE_SUB(C.cal_dt
           ,INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_ADD(DATE_SUB(C
           .cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY), INTERVAL 1 MONTH)),
       DATE_ADD(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY
         ), INTERVAL 1 MONTH)), INTERVAL 1 DAY)), INTERVAL - 12 MONTH)), DATE_ADD(MIN(DATE_SUB(IF(DATE_ADD(DATE_SUB(C.cal_dt
         ,INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY) = LAST_DAY(DATE_ADD(DATE_SUB(C.cal_dt
          ,INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY)), LAST_DAY(DATE_ADD(DATE_ADD(DATE_SUB(C
          .cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY), INTERVAL 1 MONTH)),
      DATE_ADD(DATE_ADD(DATE_SUB(C.cal_dt, INTERVAL SAFE_CAST(ROUND(C.day_of_month) as INTEGER) DAY), INTERVAL 1 DAY
        ), INTERVAL 1 MONTH)), INTERVAL 1 DAY)), INTERVAL - 12 MONTH)) AS max_dat_calendar_month_py_plan,
  CASE
  WHEN MIN(C.cy_month) = MAX(C.cy_month)
  THEN MAX(CASE
    WHEN C.cy_week_seq = 0
    THEN CASE
     WHEN C.cy_day_seq = 0
     THEN C.cal_dt
     ELSE NULL
     END
    ELSE C.cal_dt
    END)
  ELSE DATE_SUB(MAX(CASE
     WHEN C.cy_week_seq = 0
     THEN CASE
      WHEN C.cy_day_seq = 0
      THEN C.cal_dt
      ELSE NULL
      END
     ELSE C.cal_dt
     END), INTERVAL EXTRACT(DAY FROM MAX(CASE
      WHEN C.cy_week_seq = 0
      THEN CASE
       WHEN C.cy_day_seq = 0
       THEN C.cal_dt
       ELSE NULL
       END
      ELSE C.cal_dt
      END)) DAY)
  END AS max_dat_calendar_month_act,
  CASE
  WHEN MIN(C.cy_month) = MAX(C.cy_month)
  THEN IF(MAX(CASE
      WHEN C.cy_week_seq = 0
      THEN CASE
       WHEN C.cy_day_seq = 0
       THEN C.cal_dt
       ELSE NULL
       END
      ELSE C.cal_dt
      END) = LAST_DAY(MAX(CASE
       WHEN C.cy_week_seq = 0
       THEN CASE
        WHEN C.cy_day_seq = 0
        THEN C.cal_dt
        ELSE NULL
        END
       ELSE C.cal_dt
       END)), LAST_DAY(DATE_ADD(MAX(CASE
       WHEN C.cy_week_seq = 0
       THEN CASE
        WHEN C.cy_day_seq = 0
        THEN C.cal_dt
        ELSE NULL
        END
       ELSE C.cal_dt
       END), INTERVAL - 12 MONTH)), DATE_ADD(MAX(CASE
      WHEN C.cy_week_seq = 0
      THEN CASE
       WHEN C.cy_day_seq = 0
       THEN C.cal_dt
       ELSE NULL
       END
      ELSE C.cal_dt
      END), INTERVAL - 12 MONTH))
  ELSE DATE_SUB(IF(MAX(CASE
       WHEN C.cy_week_seq = 0
       THEN CASE
        WHEN C.cy_day_seq = 0
        THEN C.cal_dt
        ELSE NULL
        END
       ELSE C.cal_dt
       END) = LAST_DAY(MAX(CASE
        WHEN C.cy_week_seq = 0
        THEN CASE
         WHEN C.cy_day_seq = 0
         THEN C.cal_dt
         ELSE NULL
         END
        ELSE C.cal_dt
        END)), LAST_DAY(DATE_ADD(MAX(CASE
        WHEN C.cy_week_seq = 0
        THEN CASE
         WHEN C.cy_day_seq = 0
         THEN C.cal_dt
         ELSE NULL
         END
        ELSE C.cal_dt
        END), INTERVAL - 12 MONTH)), DATE_ADD(MAX(CASE
       WHEN C.cy_week_seq = 0
       THEN CASE
        WHEN C.cy_day_seq = 0
        THEN C.cal_dt
        ELSE NULL
        END
       ELSE C.cal_dt
       END), INTERVAL - 12 MONTH)), INTERVAL EXTRACT(DAY FROM IF(MAX(CASE
        WHEN C.cy_week_seq = 0
        THEN CASE
         WHEN C.cy_day_seq = 0
         THEN C.cal_dt
         ELSE NULL
         END
        ELSE C.cal_dt
        END) = LAST_DAY(MAX(CASE
         WHEN C.cy_week_seq = 0
         THEN CASE
          WHEN C.cy_day_seq = 0
          THEN C.cal_dt
          ELSE NULL
          END
         ELSE C.cal_dt
         END)), LAST_DAY(DATE_ADD(MAX(CASE
         WHEN C.cy_week_seq = 0
         THEN CASE
          WHEN C.cy_day_seq = 0
          THEN C.cal_dt
          ELSE NULL
          END
         ELSE C.cal_dt
         END), INTERVAL - 12 MONTH)), DATE_ADD(MAX(CASE
        WHEN C.cy_week_seq = 0
        THEN CASE
         WHEN C.cy_day_seq = 0
         THEN C.cal_dt
         ELSE NULL
         END
        ELSE C.cal_dt
        END), INTERVAL - 12 MONTH))) DAY)
  END AS max_dat_calendar_month_py_act
FROM ldl_p_lew_core_ac.v_cal_calendarday_1 AS C
 INNER JOIN (SELECT cy_week_prev_1y
  FROM ldl_p_lew_core_ac.v_cal_week_1
  WHERE cy_week_seq BETWEEN - 1 AND 6
  ORDER BY cy_week_prev_1y NULLS LAST) AS cpy ON (C.cy_week = cpy.cy_week_prev_1y OR C.cy_week_seq BETWEEN - 5 AND 0)
  AND C.cy_day_seq <= 0
GROUP BY C.cy_week,
 C.cy_week_seq;
