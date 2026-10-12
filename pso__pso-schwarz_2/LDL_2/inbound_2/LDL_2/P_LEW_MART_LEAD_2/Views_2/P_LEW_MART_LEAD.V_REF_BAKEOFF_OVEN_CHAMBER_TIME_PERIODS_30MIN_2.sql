/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated list of bakings events count with the granularity of country_2/store/day/timeperiod. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     28.11.2025      Alena Gruner             Initial Version
#
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_BAKEOFF_OVEN_CHAMBER_TIME_PERIODS_30MIN_2(
    time_period_30_id    
    ,period_start_time
    ,period_end_time
    ,time_period_30_name   
) AS

WITH timegenerator AS (
    SELECT (seq4()) AS interval_sequence
    FROM TABLE(generator(ROWCOUNT => 48)) 
)

SELECT
    (interval_sequence + 1) AS time_period_30_id
    
    ,timeadd(MINUTE, interval_sequence * 30, '00:00:00'::TIME) AS period_start_time

    ,timeadd(SECOND, -1, timeadd(MINUTE, (interval_sequence + 1) * 30, '00:00:00'::TIME)) AS period_end_time

    ,CONCAT(
        TO_CHAR(period_start_time, 'hh24:mi') 
        ,' - ' 
        ,TO_CHAR(timeadd(MINUTE, 30, period_start_time), 'hh24:mi')
    ) AS time_period_30_name

FROM timegenerator;