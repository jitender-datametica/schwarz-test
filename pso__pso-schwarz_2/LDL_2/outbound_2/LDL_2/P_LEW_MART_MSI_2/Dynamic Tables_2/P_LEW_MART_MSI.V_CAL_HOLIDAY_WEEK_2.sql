CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_cal_holiday_week_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
-- Fuer die Berechnung von Ostern und Pfingsten ...

-- (Annahme: Ostern ist entweder am Sonntag oder Montag gekennzeichnet.)

-- falls der Sonntag als Feiertag gekennzeichnet ist, nehme die selbe Woche_2 ...

-- falls nicht, nehme die Vorwochen, d.h. minus 1.

-- Fuer die Berechnung sonstiger Feiertage, uebernehme einfach die Woche.
 SELECT h.country_id,
  CASE
  WHEN h.holidaytype_id = 2 -- pruefe, ob der 24.Dez. in der selben Woche_2 liegt wie dat_holiday_fst ...

   -- THEN CASE WHEN c.day_of_week - (h.dat_holiday_fst - CAST((cy-1900) * 10000 + 1224 AS DATE)) >= 1

  THEN CASE
   WHEN C.day_of_week - DATE_DIFF(h.dat_holiday_fst, DATE(CAST(C.cy AS STRING) || '12' || '24'), DAY) >= 1
    -- falls ja, uebernehme diese Woche_2 ...

   THEN C.cy_week -- falls nicht, kann es nur die Vorwoche sein.

   ELSE C.cy_week - 1
   END
  WHEN h.holidaytype_id IN (1, 3)
  THEN C.cy_week - CASE
    WHEN C.day_of_week = 7
    THEN 0
    ELSE C.day_of_week
    END
  ELSE C.cy_week
  END AS cy_week_holiday,
 MAX(h.holidaytype_id) AS holidaytype_id
FROM ldl_p_lew_core_ac.v_wawi_cal_calendarday_2 AS C
 INNER JOIN (SELECT country_id,
   holidaytype_id,
    CASE
    WHEN holidaytype_id = 0
    THEN DATE_SUB(dat_holiday, INTERVAL MOD(DATE_DIFF(dat_holiday, PARSE_DATE('%F', '0001-01-01'), DAY), 7) DAY)
    ELSE NULL
    END AS dat_holiday_pre_monday,
   EXTRACT(YEAR FROM dat_holiday) AS dat_holiday_year,
   MIN(dat_holiday) AS dat_holiday_fst
  FROM ldl_p_lew_core_ac.v_wawi_cal_holiday_2 AS H1
  GROUP BY country_id,
   holidaytype_id,
   dat_holiday_pre_monday,
   dat_holiday_year) AS h ON C.dat_calendar = h.dat_holiday_fst
GROUP BY h.country_id,
 cy_week_holiday;