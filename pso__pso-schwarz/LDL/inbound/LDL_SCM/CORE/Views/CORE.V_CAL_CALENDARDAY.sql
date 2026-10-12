CREATE OR REPLACE VIEW CORE.V_CAL_CALENDARDAY(
	 CAL_DT
	,DAY_OF_WEEK
	,DAY_OF_MONTH
	,DAY_OF_CY
	,CY
	,CY_WEEK
	,CY_WEEK_99
	,CY_WEEK_PART
	,CY_MONTH
	,CY_MONTH_PREV_1M
	,BUSYEAR
	,BUSYEAR_QTR
	,CAL_DT_PREV_1D
	,CAL_DT_PREV_7D
	,CAL_DT_PREV_1Y
	,CAL_DT_PREV_2Y
	,CAL_DT_PREV_3Y
	,CAL_DT_PREV_4Y
	,CAL_DT_PREV_5Y
	,CAL_DT_PREV_YD
	,CAL_DT_PREV_MD
	,CAL_DT_PREV_PY
	,CAL_DT_SWDAY_PREV_1Y
	,CAL_DT_SWDAY_PREV_2Y
	,CAL_DT_SWDAY_PREV_3Y
	,CAL_DT_SWDAY_PREV_4Y
	,CAL_DT_SWDAY_PREV_5Y
	,CAL_DT_SWDAY_PREV_1Y_1W
	,CAL_DT_LAST_DAY_PREV_1W
	,CAL_DT_LAST_DAY_PREV_1M
	,CAL_DT_LAST_DAY_PREV_1Y
	,CAL_DT_FIRST_DAY_NEXT_1W
	,LAST_DAY_WEEK_FG
	,LAST_DAY_WEEK_PARTIAL_FG
	,LAST_DAY_MONTH_FG
	,LAST_DAY_YEAR_FG
	,CY_DAY_SEQ
	,CY_WEEK_SEQ
	,CY_MONTH_SEQ
	,CY_YEAR_SEQ
	,BUSYEAR_SEQ
) AS 
WITH PUBLIC_CALENDAR_FLTRD
AS 
(
SELECT *
FROM SNOWCONVERT.PUBLIC.CALENDAR
WHERE CALENDAR_DATE > '2004-03-07'
  AND YEAR_OF_CALENDAR <= EXTRACT(YEAR FROM CURRENT_DATE) + 10
)

SELECT 
       a.cal_dt
     , a._day_of_week    AS day_of_week
     , a._day_of_month   AS day_of_month
     , a.day_of_cy
     , a.cy
     , a._cy_week        AS cy_week
     , a.cy_week_99
     , a.cy_week_part
     , a.cy_month
     , a.cy_month_prev_1m
     , a.busyear
     , a.busyear_qtr
     , a.cal_dt_prev_1d
     , a.cal_dt_prev_7d
     , a.cal_dt_prev_1y
     , a.cal_dt_prev_2y
     , a.cal_dt_prev_3y
     , a.cal_dt_prev_4y
     , a.cal_dt_prev_5y
     , a.cal_dt_prev_yd
     , a.cal_dt_prev_md
     , a.cal_dt_prev_py
     , a.cal_dt_swday_prev_1y
     , a.cal_dt_swday_prev_2y
     , a.cal_dt_swday_prev_3y
     , a.cal_dt_swday_prev_4y
     , a.cal_dt_swday_prev_5y
     , a.cal_dt_swday_prev_1y_1w
     , a.cal_dt_last_day_prev_1w
     , a.cal_dt_last_day_prev_1m
     , a.cal_dt_last_day_prev_1y
     , a.cal_dt_first_day_next_1w
     , a.last_day_week_fg
     , CASE WHEN Row_Number() Over(PARTITION BY a.busyear, a._cy_week, a.cy_week_part ORDER BY a._day_of_week DESC) = 1
            THEN 1
            ELSE 0
       END AS last_day_week_partial_fg
     , a.last_day_month_fg
     , a.last_day_year_fg
     , a.cy_day_seq
     , a.cy_week_seq
     , a.cy_month_seq
     , a.cy_year_seq
     , a.busyear_seq
     
FROM
(
    SELECT  a.CALENDAR_DATE                                   AS cal_dt--dat_calendar
            -- change day_of_week AS it is different in sys_calendar.calendar than in t_cal_calendarday
            -- in sys_calendar.calendar sunday is 1 in t_cal_calendarday monday is 1
          , EXTRACT(YEAR FROM a.CALENDAR_DATE) * 100 + EXTRACT(MONTH FROM a.CALENDAR_DATE)                        AS cy_month
          , ciso.x_day_of_week                                AS _day_of_week
          , EXTRACT(DAY FROM a.CALENDAR_DATE)                 AS _day_of_month
          , a.day_of_year                                     AS day_of_cy
          , EXTRACT(YEAR FROM a.CALENDAR_DATE)                AS cy
          , (ciso.iso_year * 100) + ciso.iso_week             AS _cy_week
          , CASE WHEN -- Wenn der erste Maerz in der Woche liegt ...
                      CAST(cy||'-03-01' AS DATE) BETWEEN cal_dt-_day_of_week+1 AND cal_dt+7-_day_of_week
                      -- und der Tag vor dem Maerz liegt ...
                      AND MONTH(cal_dt ) < 3
                      -- dann ist der Tag in der KW99 ...
                 THEN cy*100 + 99
                 -- ansonsten in der normalen KW.
                 ELSE _cy_week
            END AS cy_week_99
          , CASE WHEN RANK () OVER (PARTITION BY _cy_week ORDER BY cy_month ASC) > 1
                      OR MIN(_day_of_week) OVER (PARTITION BY _cy_week  ) > 1
                 THEN 2
                 ELSE RANK () OVER (PARTITION BY _cy_week ORDER BY cy_month ASC)
            END AS cy_week_part--cy_partial_week
          , EXTRACT(YEAR FROM ADD_MONTHS(cal_dt, -1 )) * 100 + EXTRACT(MONTH FROM ADD_MONTHS(cal_dt, -1 ))        AS cy_month_prev_1m
          , CASE WHEN EXTRACT(MONTH FROM a.CALENDAR_DATE) > 2
                 THEN EXTRACT(YEAR FROM a.CALENDAR_DATE)
                 ELSE EXTRACT(YEAR FROM a.CALENDAR_DATE) -1
            END                                                          AS busyear
          , busyear*10 + MOD(FLOOR(MOD(cy_month ,100)/3.0)+3,4)+1 AS busyear_qtr
          , a.CALENDAR_DATE - 1                    AS cal_dt_prev_1d--prev_dat_calendar
          , a.CALENDAR_DATE - 7                   AS cal_dt_prev_7d--pwd_dat_calendar
            --, NULL AS cal_dt_prev_35d--DUMMY-value, which will be updated in the next step
          , CASE WHEN MONTH(ADD_MONTHS(a.CALENDAR_DATE , -12))=2 AND DAY(ADD_MONTHS(a.CALENDAR_DATE , -12))=29 THEN ADD_MONTHS(a.CALENDAR_DATE , -12)-1 ELSE ADD_MONTHS(a.CALENDAR_DATE , -12) END AS cal_dt_prev_1y
          , CASE WHEN MONTH(ADD_MONTHS(a.CALENDAR_DATE , -24))=2 AND DAY(ADD_MONTHS(a.CALENDAR_DATE , -24))=29 THEN ADD_MONTHS(a.CALENDAR_DATE , -24)-1 ELSE ADD_MONTHS(a.CALENDAR_DATE , -24) END AS cal_dt_prev_2y
          , CASE WHEN MONTH(ADD_MONTHS(a.CALENDAR_DATE , (-12*3)))=2 AND DAY(ADD_MONTHS(a.CALENDAR_DATE ,  (-12*3)))=29 THEN ADD_MONTHS(a.CALENDAR_DATE , (-12*3))-1 ELSE ADD_MONTHS(a.CALENDAR_DATE , (-12*3))END AS cal_dt_prev_3y
          , ADD_MONTHS(a.CALENDAR_DATE , (-12*4)) AS cal_dt_prev_4y
          , CASE WHEN MONTH(ADD_MONTHS(a.CALENDAR_DATE , (-12*5)))=2 AND DAY(ADD_MONTHS(a.CALENDAR_DATE ,  (-12*5)))=29 THEN ADD_MONTHS(a.CALENDAR_DATE , (-12*5))-1 ELSE ADD_MONTHS(a.CALENDAR_DATE , (-12*5))END AS cal_dt_prev_5y
          , pyd.CALENDAR_DATE                     AS cal_dt_prev_yd   --pyd_dat_calendar
          , pmd.CALENDAR_DATE                     AS cal_dt_prev_md   --pmd_dat_calendar
          , ppy.CALENDAR_DATE                     AS cal_dt_prev_py   --ppy_dat_calendar
          , ciso.CALENDAR_DATE - 364              AS cal_dt_swday_prev_1y
          , ciso.CALENDAR_DATE - (364*2)          AS cal_dt_swday_prev_2y
          , ciso.CALENDAR_DATE - (364*3)          AS cal_dt_swday_prev_3y
          , ciso.CALENDAR_DATE - (364*4)          AS cal_dt_swday_prev_4y
          , ciso.CALENDAR_DATE - (364*5)          AS cal_dt_swday_prev_5y
          , ciso.CALENDAR_DATE - 364 - 7          AS cal_dt_swday_prev_1y_1w
          , cal_dt - _day_of_week                 AS cal_dt_last_day_prev_1w          -- last_dat_prev_week
          , cal_dt - _day_of_month                AS cal_dt_last_day_prev_1m          -- last_dat_prev_month
          , cal_dt - day_of_cy                    AS cal_dt_last_day_prev_1y          -- last_dat_prev_year
            -- Umbenennung in der Coretable cal_dt_first_day_next_1w
          , (cal_dt + 7 - (MOD(cal_dt + 7 - DATE '0001-01-01' , 7))) AS cal_dt_first_day_next_1w
          , CASE WHEN Row_Number() Over(PARTITION BY cy, _cy_week ORDER BY _day_of_week DESC) = 1
                 THEN 1
                 ELSE 0
            END AS last_day_week_fg
          , CASE WHEN Row_Number() Over(PARTITION BY cy, cy_month ORDER BY _day_of_month DESC) = 1
                 THEN 1
                 ELSE 0
            END AS last_day_month_fg
          , CASE WHEN Row_Number() Over(PARTITION BY cy ORDER BY day_of_cy DESC) = 1
                 THEN 1
                 ELSE 0
            END AS last_day_year_fg
          , a.CALENDAR_DATE - (CURRENT_DATE - 1)                      AS cy_day_seq
          , ((cy_month - (cy * 100)) - EXTRACT (MONTH FROM (CURRENT_DATE -1)))+(cy - EXTRACT (YEAR FROM (CURRENT_DATE -1) )) * 12 AS cy_month_seq
          , cy - EXTRACT(YEAR FROM (CURRENT_DATE -1)) AS cy_year_seq
             -- Take the Monday of the week of each cal_dt AND the Monday of the week of the previous day. The difference between both days is divided by 7. This gives the correct week sequence based on the previous day.
          , (((a.CALENDAR_DATE - (MOD((a.CALENDAR_DATE - DATE '0001-01-01') , 7) + 1) + 1) - (CURRENT_DATE - 1 - (MOD((CURRENT_DATE - 1 - DATE '0001-01-01') , 7) + 1) + 1) ) / 7) AS cy_week_seq
          , busyear - CASE WHEN Current_Date - 1 < EXTRACT (YEAR From Current_Date)||'-03-01' -- Current Businessyear
                           THEN EXTRACT(YEAR FROM Current_Date) - 1
                           ELSE EXTRACT(YEAR FROM Current_Date)
                      END AS busyear_seq
          , 0           AS dwh_load_id
          , CURRENT_TIMESTAMP     AS dwh_created
          , CURRENT_TIMESTAMP     AS dwh_updated
      
    FROM PUBLIC_CALENDAR_FLTRD  a
    
    INNER JOIN  (
                  SELECT CALENDAR_DATE
                         -- day_of_week
                       , MOD((CALENDAR_DATE - DATE '0001-01-01') , 7) + 1 AS x_day_of_week
                         -- iso_temp: Thursday within a ISO week, used to calculate ISO weeks
                       , CALENDAR_DATE - x_day_of_week + 4 AS iso_temp
                         -- iso_year
                       , EXTRACT (YEAR FROM iso_temp)   AS iso_year
                         -- iso_week: Julian day / 7 + 1
                       , TRUNC((iso_temp -CAST (EXTRACT (YEAR FROM iso_temp)||'-01-01' AS DATE))/7)+1 AS iso_week
                  FROM PUBLIC_CALENDAR_FLTRD
                ) ciso
            ON a.CALENDAR_DATE = ciso.CALENDAR_DATE
    
    LEFT OUTER JOIN PUBLIC_CALENDAR_FLTRD AS pmd
                 ON CASE WHEN pmd.month_of_year = 12
                         THEN (pmd.YEAR_OF_CALENDAR * 100 + pmd.month_of_year) + 89
                         ELSE (pmd.YEAR_OF_CALENDAR * 100 + pmd.month_of_year) + 1
                    END = (a.YEAR_OF_CALENDAR * 100 + a.month_of_year)
                AND a.day_of_month = pmd.day_of_month
    
    LEFT OUTER JOIN PUBLIC_CALENDAR_FLTRD AS pyd
                 ON a.YEAR_OF_CALENDAR = pyd.YEAR_OF_CALENDAR + 1
                AND a.month_of_year = pyd.month_of_year
                AND a.day_of_month = pyd.day_of_month
    
    LEFT OUTER JOIN (
                       SELECT CALENDAR_DATE
                              -- day_of_week
                            , MOD((CALENDAR_DATE - DATE '0001-01-01') , 7) + 1 AS x_day_of_week
                              -- iso_temp: Thursday within a ISO week, used to calculate ISO weeks
                            , CALENDAR_DATE - x_day_of_week + 4 AS iso_temp
                              -- iso_year
                            , EXTRACT (YEAR FROM iso_temp)   AS iso_year
                              -- iso_week: Julian day / 7 + 1
                            , TRUNC((iso_temp -CAST (EXTRACT (YEAR FROM iso_temp)||'-01-01' AS DATE))/7)+1 AS iso_week
                       FROM PUBLIC_CALENDAR_FLTRD
                    ) ppy
                 ON ciso.iso_year - 2 = ppy.iso_year
                 AND ciso.iso_week = ppy.iso_week
                 AND ciso.x_day_of_week = ppy.x_day_of_week
    
) AS a
;