CREATE OR REPLACE VIEW CORE_REL.V_CALENDAR_DATE_1

AS

WITH

TIMERANGE AS

    (

    SELECT 

        CAST(

          CAST(

            EXTRACT(YEAR FROM CURRENT_DATE) - 10 AS VARCHAR(4)) || '-01-01' 

          AS DATE)

        + ROW_NUMBER() OVER(ORDER BY 1)  - 1 cal_dt

    FROM TABLE(generator(rowcount=>365.25*12))

    )

SELECT

     cal_dt

    ,DAYOFWEEKISO(cal_dt) AS DAY_OF_WEEK
    
    ,MONTH(cal_dt) AS MONTH_OF_YEAR

    ,CASE 

        WHEN DAY_OF_WEEK IN (6, 7) THEN TRUE

        ELSE FALSE

     END AS weekend_fg

    ,DAYOFYEAR(cal_dt) AS day_of_cy

    ,YEAR(cal_dt) * 100 + MONTH(cal_dt) AS cy_month

    ,YEAROFWEEKISO(cal_dt) * 100 + WEEKISO(cal_dt) AS cy_week

    ,YEAR(cal_dt) AS cy

    ,YEAR(cal_dt) - CASE WHEN MONTH(cal_dt) IN (1,2) THEN 1 ELSE 0 END AS bus_year

    ,cal_dt - 7 AS cal_dt_prev_7d

    ,cal_dt - 364 AS cal_dt_swday_prev_1y

    ,DATEDIFF(DAY,CURRENT_DATE,cal_dt) AS cy_day_seq

FROM TIMERANGE;