
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_CAL_HOLIDAY_WEEK_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/* 
#DescStart# 
#$Revision: 6244 $, $LastChangedBy: hwieber $ 
#SubjectAreas#: Kalender 
#DescEnd# 
*/
SELECT
h.country_id,
CASE WHEN h.holidaytype_id = 2
 -- pruefe, ob der 24.Dez. in der selben Woche_1 liegt wie dat_holiday_fst ... 
-- THEN CASE WHEN c.day_of_week - (h.dat_holiday_fst - CAST((cy-1900) * 10000 + 1224 AS DATE)) >= 1
 THEN CASE WHEN c.day_of_week - (h.dat_holiday_fst- TO_DATE(TO_CHAR(cy||12||24),'YYYYMMDD')) >= 1
 
 
 -- falls ja, uebernehme diese Woche_1 ... 
 THEN c.cy_week
 -- falls nicht, kann es nur die Vorwoche sein. 
 ELSE c.cy_week - 1
 END
 -- Fuer die Berechnung von Ostern und Pfingsten ... 
 -- (Annahme: Ostern ist entweder am Sonntag oder Montag gekennzeichnet.) 
 -- falls der Sonntag als Feiertag gekennzeichnet ist, nehme die selbe Woche_1 ... 
 WHEN h.holidaytype_id IN (1,3)
 THEN c.cy_week - (CASE WHEN c.day_of_week = 7
 THEN 0
 -- falls nicht, nehme die Vorwochen, d.h. minus 1. 
 ELSE c.day_of_week
 END)
 -- Fuer die Berechnung sonstiger Feiertage, uebernehme einfach die Woche. 
 ELSE c.cy_week
 END AS cy_week_holiday,
MAX(h.holidaytype_id) AS holidaytype_id
FROM p_lew_core_ac.v_wawi_cal_calendarday_1 c
INNER JOIN
(SELECT
h1.country_id,
h1.holidaytype_id,
CASE WHEN h1.holidaytype_id = 0
 THEN h1.dat_holiday - ((MOD((h1.dat_holiday - TO_DATE('0001-01-01', 'YYYY-MM_1-DD')), 7)) + 0)
ELSE NULL
END AS dat_holiday_pre_monday,
EXTRACT (YEAR FROM h1.dat_holiday) AS dat_holiday_year,
MIN(h1.dat_holiday) AS dat_holiday_fst
FROM p_lew_core_ac.v_wawi_cal_holiday_1 h1
GROUP BY
h1.country_id
,h1.holidaytype_id
,dat_holiday_pre_monday
,dat_holiday_year
) h
ON h.dat_holiday_fst = c.dat_calendar
GROUP BY
h.country_id
,cy_week_holiday
;
