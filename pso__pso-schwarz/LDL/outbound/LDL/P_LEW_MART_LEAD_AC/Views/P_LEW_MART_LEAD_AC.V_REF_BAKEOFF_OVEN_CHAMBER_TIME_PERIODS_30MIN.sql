/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated list of bakings events count with the granularity of country/store/day/timeperiod. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     28.11.2025      Alena Gruner             Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_bakeoff_oven_chamber_time_periods_30min (time_period_30_id,
period_start_time, period_end_time, time_period_30_name) AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_bakeoff_oven_chamber_time_periods_30min;