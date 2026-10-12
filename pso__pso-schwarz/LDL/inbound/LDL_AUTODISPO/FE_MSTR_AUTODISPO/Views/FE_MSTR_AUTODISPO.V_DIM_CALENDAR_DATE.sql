CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_DIM_CALENDAR_DATE(
	CAL_DT
	, DAY_OF_WEEK
	, WEEK_ID
	, MONTH_ID
	, CY_WEEK
	, CY
	, DAY_SEQUENCE
	, WEEK_SEQUENCE
) AS

    /* Version:   1.2
    ** Author:    Dominik Pfarr
    ** Date:      2024-01-08
    ** Changes:   adjusting week sequence
    */
WITH
TIMERANGE AS
    (
    SELECT 
        CAST(
          CAST(
            EXTRACT(YEAR FROM CURRENT_DATE) - 6 AS VARCHAR(4)) || '-01-01' 
          AS DATE)
        + ROW_NUMBER() OVER(ORDER BY 1)  - 1 cal_dt
    FROM TABLE(generator(ROWCOUNT=>365.25*8))
    )
SELECT
     cal_dt
    ,DAYOFWEEKISO(cal_dt) AS day_of_week
	,WEEKISO(cal_dt) week_id
    ,MONTH(cal_dt) AS month_id
    ,YEAROFWEEKISO(cal_dt) || '-' || LPAD(WEEKISO(cal_dt),2,'0') AS cy_week
    ,YEAR(cal_dt) AS cy
    ,DATEDIFF(DAY,CURRENT_DATE,cal_dt) AS day_sequence
	,DATEDIFF(WEEK, CURRENT_DATE, cal_dt) AS week_sequence
FROM TIMERANGE;