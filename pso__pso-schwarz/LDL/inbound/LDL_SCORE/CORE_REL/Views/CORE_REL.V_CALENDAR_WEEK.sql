CREATE OR REPLACE VIEW CORE_REL.V_CALENDAR_WEEK
AS
WITH
TIMERANGE AS
    (
    SELECT 
        CAST(
          CAST(
            extract(year from current_date) - 10 AS VARCHAR(4)) || '-01-01' 
          AS DATE)
        + ROW_NUMBER() OVER(ORDER BY 1)  - 1 cal_dt
    FROM table(generator(rowcount=>365.25*12))
    )
,WEEK_LIST AS
    (
    SELECT 
        cal_dt
        ,YEAROFWEEKISO(cal_dt) * 100 + WEEKISO(cal_dt) cy_week
        ,WEEKISO(cal_dt) week_iso
        ,YEAROFWEEKISO(cal_dt) year_iso
    FROM TIMERANGE
    WHERE DAYOFWEEKISO(cal_dt) = 1
    )
SELECT
    cy_week
    ,'KW ' || LPAD(week_iso,2,'0') week_desc
    ,LAG(cy_week) OVER(ORDER BY cy_week) cy_week_prev_1w
    ,CASE WHEN week_iso = 53
        THEN  year_iso * 100 + 1 
        ELSE cy_week - 100
    END cy_week_prev_1y
    ,DATEDIFF(WEEK,current_date,cal_dt) cy_week_seq
FROM WEEK_LIST;