CREATE OR REPLACE VIEW CORE_REL.V_CALENDAR_YTD_1
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
SELECT
    a.cal_dt AS cal_dt
    ,b.cal_dt AS incl_cal_dt
FROM TIMERANGE a
    INNER JOIN TIMERANGE b
        ON YEAR(a.cal_dt) = YEAR(b.cal_dt)
        AND a.cal_dt >= b.cal_dt;