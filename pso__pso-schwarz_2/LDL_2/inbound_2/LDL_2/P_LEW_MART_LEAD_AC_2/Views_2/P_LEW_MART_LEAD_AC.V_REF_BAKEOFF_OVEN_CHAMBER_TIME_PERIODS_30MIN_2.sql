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
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_BAKEOFF_OVEN_CHAMBER_TIME_PERIODS_30MIN_2(
    time_period_30_id    
    ,period_start_time
    ,period_end_time
    ,time_period_30_name   
) AS
SELECT
    time_period_30_id    
    ,period_start_time
    ,period_end_time
    ,time_period_30_name   
FROM P_LEW_MART_LEAD.V_REF_BAKEOFF_OVEN_CHAMBER_TIME_PERIODS_30MIN_2;