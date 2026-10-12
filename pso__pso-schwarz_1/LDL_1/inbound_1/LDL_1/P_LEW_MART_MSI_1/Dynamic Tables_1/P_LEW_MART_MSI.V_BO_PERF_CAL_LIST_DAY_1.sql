
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_PERF_CAL_LIST_DAY_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
calday.cal_dt,
calday.cy_week,
calday.cy_week_seq,
calday.cy_month,
CALDAY_PY_WEEK4UMS.cal_dt py_caldt_shifted,
CALDAY_PY_WEEK4UMS.cy_week py_week_shifted,
CALDAY_PY_WEEK4UMS.cy_week_seq py_week_seq_shifted,
CASE WHEN SET_OF_WEEKS_FOR_DAILY.cy_week IS NOT NULL
     THEN 1
ELSE 0 END is_daily_level_row,
CASE WHEN calday.cy_week_seq BETWEEN -17 AND -1
            OR calday.cy_week_seq BETWEEN -52 -12 -1 AND -52 +7
     THEN 1
ELSE 0 END is_weekly_normal_level_row,
CASE WHEN CALDAY_PY_WEEK4UMS.cal_dt IS NOT NULL
     THEN 1
ELSE 0 END is_weekly_pyshift_level_row,
-- fällt das Datum für irgendeine der Auswahlwochen in eines der 4 Intervalle, so gilt 1 sonst 0
MAX(CASE WHEN calday.cal_dt BETWEEN INTVLS.min_dat_calendar_month AND INTVLS.max_dat_calendar_month_act
            OR calday.cal_dt BETWEEN INTVLS.min_dat_calendar_month_py AND INTVLS.max_dat_calendar_month_py_act
            OR calday.cal_dt BETWEEN INTVLS.min_dat_calendar_month AND INTVLS.max_dat_calendar_month_plan
            OR calday.cal_dt BETWEEN INTVLS.min_dat_calendar_month_py AND INTVLS.max_dat_calendar_month_py_plan
     THEN 1
ELSE 0 END) is_monthly_level_row
FROM p_lew_core_ac.v_cal_calendarday_1 calday
-- markiere die Tage, welche den Vorjahresdatümern der WEEKLY-Auswahl entsprechen (nur für Umsätze!!)
LEFT OUTER JOIN p_lew_core_ac.v_cal_calendarday_1 CALDAY_PY_WEEK4UMS
ON calday.cal_dt=CALDAY_PY_WEEK4UMS.cal_dt_swday_prev_1y
   AND (CALDAY_PY_WEEK4UMS.cy_week_seq BETWEEN -17 AND -1
        OR CALDAY_PY_WEEK4UMS.cy_week_seq BETWEEN -52 -12 -1 AND -52 +7)
--markiere die Vorjahreswochen für die DAILY-Auswahl: Nutze dazu V_BO_PERF_CAL_LIST_MTH_1 (Diese enthält bereits die für Daily notwendige Wochenanzahl als Gesamtumfang)
LEFT OUTER JOIN p_lew_mart_msi.v_bo_perf_cal_list_mth_1 SET_OF_WEEKS_FOR_DAILY
ON calday.cy_week=SET_OF_WEEKS_FOR_DAILY.cy_week
--KOMPLEXE MONATSLEVEL-AUSWAHL:
-- Es wird zunächste eine_1 Wochenauswahl getroffen, die nicht direkt der Selektion dient! Sie ist identisch zur DAILY-LEVEL-Auswahl und dient daher im LO Join oben zur Bestimmung der Tage für das DAILY-LEvEL
--   Mitglieder sind die aktuelle Woche_1 (SEQ=0) und 5 Wochen davor
--   sowie die Vorjahreswochen- Pendants zu den Wochen (SEQ=0) und 7 Wochen danach.
-- ACHTUNG Besonderheit: Die Vorjahreswoche wird dabei nach der Wochennummer im Jahr ermittelt und nicht durch statische Differenzbildung von 52 Wochen (das bekannte 52/53-Wochenproblem)
-- --------------
-- Für die MONTHLY- Auswahl sind jeder dieser Wochen vier Zeitfenster (Intervalle) zugeordnet
--   1. Akt-Jahr - Istdaten: [Geschaftsjahresstart des ersten Tages der jeweiligen Auswahlwoche] BIS [modifizierer* Wochenendtag der Woche_1]
--   2. Akt-Jahr - Plandaten: [Geschaftsjahresstart des ersten Tages der jeweiligen Auswahlwoche] BIS [Letzter Tag_1 des Monats, in den der erste Tag_1 der Auswahlwoche fällt]
--   3. Vor-Jahr - Istdaten: [Geschäfts-VOR-Jahresstart des ersten Tages der jeweiligen Auswahlwoche] BIS [Vorjahrestag des modifizieren* Wochenendtages der AusswahlWoche ]
--   4. Akt-Jahr - Plandaten: [Geschäfts-VOR-Jahresstart des ersten Tages der jeweiligen Auswahlwoche] BIS [Vorjahrestag des Letzten Tages des Monats, in den der erste Tag_1 der Auswahlwoche fällt]
--  (* modifizierter Wochenendtag: Fällt die Woche_1 komplett in einen Monat_1 => Wochenendtag; verläuft sie über einen Monatswechsel => Monatsendtag;
--               in der aktuellen Woche_1 ist das modifizierte Ende durch den aktuellen Tag_1 zusätzlich geschnitten)
--bestimme die MONTHLY-Auswahl an Tagen: Nutze dazu ebenfalls V_BO_PERF_CAL_LIST_MTH_1
LEFT OUTER JOIN p_lew_mart_msi.v_bo_perf_cal_list_mth_1 INTVLS
ON --komplexe Auswahl für Monatssicht
 calday.cal_dt BETWEEN INTVLS.min_dat_calendar_month AND INTVLS.max_dat_calendar_month_act
 OR calday.cal_dt BETWEEN INTVLS.min_dat_calendar_month_py AND INTVLS.max_dat_calendar_month_py_act
 OR calday.cal_dt BETWEEN INTVLS.min_dat_calendar_month AND INTVLS.max_dat_calendar_month_plan
 OR calday.cal_dt BETWEEN INTVLS.min_dat_calendar_month_py AND INTVLS.max_dat_calendar_month_py_plan
WHERE CALDAY_PY_WEEK4UMS.cal_dt IS NOT NULL
 OR SET_OF_WEEKS_FOR_DAILY.cy_week IS NOT NULL
 OR INTVLS.cy_week IS NOT NULL
 -- einfache Auswahl Wochensicht sozusagen THISYEAR-Auswahl. (Für die Wochenazeige kommen für Umsätze auch die hierzu passenden echten Vorjahreswerte hinzu!!!)
 OR calday.cy_week_seq BETWEEN -17 AND -1
 OR calday.cy_week_seq BETWEEN -52 -12 -1 AND -52 +7      --- py data  start (-52: pre. year, -12: data to be reported, -1: week shift)
GROUP BY 1,2,3,4,5,6,7,8
;
