CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_kpges_availability_day_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT CLNT.client_id,
 CAL.cal_dt AS dat_calendar,
 IND.indicator_id,
  CASE
  WHEN CAL.cal_dt <= iday.dat_formdate
  THEN 1
  ELSE 0
  END AS availability_fg
FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS CLNT ON TRUE
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_indicator_2 AS IND ON TRUE
 LEFT JOIN (SELECT cal1.client_id,
   cal1.indicator_id,
   MAX(CAL2.cal_dt) AS dat_formdate
  FROM (SELECT ind.client_id,
     ind.indicator_id,
     MIN(CAL0.cy_week_part) AS cy_week_part
    FROM (SELECT client_id,
       indicator_id,
       MAX(dat_formdate) AS dat_formdate
      FROM ldl_p_lew_bil_ac.v_kpi_day_2
      WHERE indicator_type_id = 1
      GROUP BY client_id,
       indicator_id) AS ind
     INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL0 ON ind.dat_formdate = CAL0.cal_dt
    GROUP BY ind.client_id,
     ind.indicator_id) AS cal1
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL2 ON cal1.cy_week_part = CAL2.cy_week_part
  GROUP BY cal1.client_id,
   cal1.indicator_id) AS iday ON IND.indicator_id = iday.indicator_id AND CLNT.client_id = iday.client_id
   -- AND cal.dat_calendar = iday.dat_formdate
 -- AND iday.indicator_type_id = 1

WHERE CAL.cy_day_seq <= 0
 AND CAL.cy_month_seq BETWEEN - 23 AND 0
 AND IND.indicator_id IN (114, 122, 123, 138, 139, 141, 143, 149, 157, 290, 291);