
/*
  Target      : P_LEW_MART_MSI.V_BO_PERF_CAL_LIST_MTH_2
  Source
    P_LEW_CORE_AC
      V_CAL_CALENDARDAY_2
      V_CAL_WEEK_2
  History:
    2018-06-14  Jens Thole
    Inhalt: Ausschnitt aus Kalender - speziell für bo_perflist; wochengranular: t_cal_calendarday_2
    Ausgehend von Woche_2 0 wird die Grundauswahl an relevanten Reportingwochen für die Daily, Weekly und Monthly- Sicht definiert.
    Reportingwochen sind dabei nicht unbedingt mit der Auswahl von Faktendaten zu diesen Wochen gleichzusetzen.
    Für letztere bereitet die View Datengrenzen auf, die aber nur für die Monthly-Ebene Verwendung finden
    Die Reportingwochen-Grundauswahl ist definiert als
    Gegenwartszeitfester:         [fünftletzte Woche_2 vor der aktuellen Woche_2, aktuelle Woche_2]
    Vergangenheitszeitfenster:    [Jahreswochennummerngleiche Woche_2 zur akt-Woche_2 im Vorjahr, siebte Folgewoche dieser Startwoche]
    2021-11-03  zied.nanaa_ext@mail.schwarz
    https://jira.schwarz/browse/REP4-10316
    Patch for KW53 2020 nicht verfügbar im Leistungsübersicht
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_PERF_CAL_LIST_MTH_2 COMMENT='Ausschnitt aus Kalender - speziell für bo_perflist; wochengranular: t_cal_calendarday_2'
(
    cy_week                           COMMENT 'Wochenummer'
  , cy_week_seq                       COMMENT 'Sequence beginnend ab der aktuellen Woche_2'
  , min_dat_calendar_week             COMMENT 'Erster Tag_2 der Woche_2'
  , max_dat_calendar_week             COMMENT 'Letzter Tag_2 der Woche_2'
  , min_cy_month                      COMMENT 'Monat_2 zum Start der Woche_2'
  , max_cy_month                      COMMENT 'Monat_2 zum Ende der Woche_2'
  , min_dat_calendar_month            COMMENT 'Starttag des Geschäftsjahres, dem der erste Tag_2 der Woche_2 zugehörig ist'
  , dat_calc                          COMMENT 'Mod-Wochenletzter: In aktueller Woche_2 der aktuelle Tag_2, sonst der letzte Tag_2 der Woche_2'
  , max_dat_calendar_month_plan       COMMENT 'Monatsletzter des Monats, in den der erste Tag_2 der Woche_2 fällt'
  , min_dat_calendar_month_py         COMMENT 'Vorjahrestag des Starttages des Geschäftsjahres, dem der erste Tag_2 der Woche_2 zugehörig ist'
  , dat_calc_py                       COMMENT 'Vorjahrestag des {Mod-Wochenletzten = In aktueller Woche_2 der aktuelle Tag_2, sonst der letzte Tag_2 der Woche_2}'
  , max_dat_calendar_month_py_plan    COMMENT 'Vorjahrestag des Monatsletzter des Monats, in den der erste Tag_2 der Woche_2 fällt'
  , max_dat_calendar_month_act        COMMENT 'Final modifizierter Wochenletzter : Mod-Wochenletzter, wenn Woche_2 nicht durch Monatsende unterbrochen. Monatsletzter, falls in Woche_2 neuer Monat_2 beginnt'
  , max_dat_calendar_month_py_act     COMMENT 'Final modifizierter Vorjahrestag des Mod-Wochenletzten'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
    cy_week
  , cy_week_seq
  , MIN(cal_dt  - day_of_week + 1)                                                                                            AS min_dat_calendar_week
  , MIN(cal_dt  - day_of_week + 7)                                                                                            AS max_dat_calendar_week
  , MIN(cy_month)                                                                                                             AS min_cy_month
  , MAX(cy_month)                                                                                                             AS max_cy_month
  , TO_DATE(MIN(busyear) || '0301', 'YYYYMMDD')                                                                               AS min_dat_calendar_month
  , MAX(CASE WHEN cy_week_seq = 0 THEN CASE WHEN cy_day_seq = 0 THEN cal_dt ELSE NULL END ELSE cal_dt END )                   AS dat_calc
  , MIN(ADD_MONTHS(cal_dt - day_of_month + 1, 1) -1)                                                                          AS max_dat_calendar_month_plan
  , ADD_MONTHS(TO_DATE(MIN(busyear) || '0301', 'YYYYMMDD'),-12)                                                               AS min_dat_calendar_month_py
  , ADD_MONTHS(MAX(CASE WHEN cy_week_seq = 0 THEN CASE WHEN cy_day_seq = 0 THEN cal_dt ELSE NULL END ELSE cal_dt END ) , -12) AS dat_calc_py
  , ADD_MONTHS(MIN(ADD_MONTHS(cal_dt - day_of_month + 1, 1) -1) , -12)                                                        AS max_dat_calendar_month_py_plan
  , CASE WHEN min_cy_month = max_cy_month THEN dat_calc ELSE dat_calc - EXTRACT(DAY FROM dat_calc ) END                       AS max_dat_calendar_month_act
  , CASE WHEN min_cy_month = max_cy_month THEN dat_calc_py ELSE dat_calc_py - EXTRACT(DAY FROM dat_calc_py ) END              AS max_dat_calendar_month_py_act
FROM P_LEW_CORE_AC.V_CAL_CALENDARDAY_2 c
JOIN (
  SELECT cy_week_prev_1y
    FROM P_LEW_CORE_AC.V_CAL_WEEK_2
   WHERE cy_week_seq BETWEEN -1 AND 6
   ORDER BY cy_week_prev_1y
) AS cpy
ON (   (c.cy_week = cpy.cy_week_prev_1y
    OR  c.cy_week_seq BETWEEN -5 AND 0 )
AND c.cy_day_seq <= 0 )
GROUP BY   cy_week
         , cy_week_seq
;
