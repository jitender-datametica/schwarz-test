
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_KPGES_AVAILABILITY_DAY_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
 #DescStart#
 #$Revision: 16641 $, $LastChangedBy: rcione $
 #SubjectAreas#: KPGES Views
 #DescEnd#
 */
SELECT
   clnt.client_id,
   cal.cal_dt AS dat_calendar,
   ind.indicator_id,
   CASE
      WHEN cal.cal_dt <= iday.dat_formdate THEN 1
      ELSE 0
   END AS availability_fg
FROM
   p_lew_core_ac.v_cal_calendarday_2 AS cal
   CROSS JOIN p_lew_core_ac.v_wawi_ref_client_country_2 AS clnt
   CROSS JOIN p_lew_core_ac.v_wawi_ref_indicator_2 AS ind
   LEFT OUTER JOIN (
      SELECT
         cal1.client_id,
         cal1.indicator_id,
         MAX(cal2.cal_dt) AS dat_formdate
      FROM
         (
            SELECT
               ind.client_id,
               ind.indicator_id,
               MIN(cal.cy_week_part) AS cy_week_part
            FROM
               (
                  SELECT
                     client_id,
                     indicator_id,
                     MAX(dat_formdate) AS dat_formdate
                  FROM
                     p_lew_bil_ac.v_kpi_day_2
                  WHERE
                     indicator_type_id = 1
                  GROUP BY
                     1,
                     2
               ) AS ind
               INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal ON cal.cal_dt = ind.dat_formdate
            GROUP BY
               1,
               2
         ) AS cal1
         INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal2 ON cal1.cy_week_part = cal2.cy_week_part
      GROUP BY
         1,
         2
   ) AS iday ON ind.indicator_id = iday.indicator_id
   AND clnt.client_id = iday.client_id --AND cal.dat_calendar = iday.dat_formdate
   --AND iday.indicator_type_id = 1
WHERE
   cal.cy_day_seq <= 0
   AND cal.cy_month_seq BETWEEN -23
   AND 0
   AND ind.indicator_id IN (
      114,
      122,
      123,
      138,
      139,
      141,
      143,
      149,
      157,
      290,
      291
   );
