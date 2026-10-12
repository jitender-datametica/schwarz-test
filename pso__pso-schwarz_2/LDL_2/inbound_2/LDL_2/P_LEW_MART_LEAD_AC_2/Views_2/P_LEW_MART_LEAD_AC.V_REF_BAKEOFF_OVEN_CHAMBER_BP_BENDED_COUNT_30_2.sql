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
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_BAKEOFF_OVEN_CHAMBER_BP_BENDED_COUNT_30_2(
    event_date
    ,cy_week
    ,day_of_week
    ,time_period_30_id    
    ,time_period_30_name 
    ,baking_program_id
    ,loc_sid_store_move_to
    ,client_id
    ,loc_sid_wh
    ,wh_id
    ,orig_store_nr
    ,last_event_time
    ,event_count
    ,executed_baking_program_nr
	,executed_baking_program_name
) AS
SELECT
    event_date
    ,cy_week
    ,day_of_week
    ,time_period_30_id    
    ,time_period_30_name 
    ,baking_program_id
    ,loc_sid_store_move_to
    ,client_id
    ,loc_sid_wh
    ,wh_id
    ,orig_store_nr
    ,last_event_time
    ,event_count
    ,executed_baking_program_nr
	,executed_baking_program_name
FROM P_LEW_MART_LEAD.V_REF_BAKEOFF_OVEN_CHAMBER_BP_BENDED_COUNT_30_2;