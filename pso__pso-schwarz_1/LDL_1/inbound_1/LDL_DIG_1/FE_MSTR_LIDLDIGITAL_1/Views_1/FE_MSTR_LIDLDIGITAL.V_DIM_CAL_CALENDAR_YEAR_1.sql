CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_CAL_CALENDAR_YEAR_1
AS SELECT
     CY AS CY
    ,CY_BEGIN_MONTH AS CY_BEGIN_MONTH
    ,CY_END_MONTH AS CY_END_MONTH
    ,CY_BEGIN_DT AS CY_BEGIN_DT
    ,CY_END_DT AS CY_END_DT
    ,CY_WEEK_CNT AS CY_WEEK_CNT
    ,CY_DAY_CNT AS CY_DAY_CNT
    ,CY_PREV_1Y AS CY_PREV_1Y
    ,CY_PREV_2Y AS CY_PREV_2Y
    ,CY_PREV_3Y AS CY_PREV_3Y
    ,CY_PREV_4Y AS CY_PREV_4Y
    ,CY_PREV_5Y AS CY_PREV_5Y
    ,CY_OFFSET AS CY_OFFSET
FROM
    lec_share.v_dim_cal_calendar_year_1
WHERE 
    CY != '-1' -- some date core tables contain a -1 dummy_1 entry, which is removed here so we can add our own dummy_1 value
UNION ALL
    SELECT
         '-1' -- CY
        ,'-1' -- CY_BEGIN_MONTH
        ,'-1' -- CY_END_MONTH
        ,TO_DATE('1900-01-01') -- CY_BEGIN_DT
        ,TO_DATE('1900-01-01') -- CY_END_DT
        ,'0' -- CY_WEEK_CNT
        ,'0' -- CY_DAY_CNT
        ,'-1' -- CY_PREV_1Y
        ,'-1' -- CY_PREV_2Y
        ,'-1' -- CY_PREV_3Y
        ,'-1' -- CY_PREV_4Y
        ,'-1' -- CY_PREV_5Y
        ,'999' -- CY_OFFSET        
;