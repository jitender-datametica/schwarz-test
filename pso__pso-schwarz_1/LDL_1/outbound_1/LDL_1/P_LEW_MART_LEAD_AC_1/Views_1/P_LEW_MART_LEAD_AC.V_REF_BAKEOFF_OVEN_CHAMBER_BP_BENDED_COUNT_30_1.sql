/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated list of bakings events count with the granularity of country_1/store/day/timeperiod. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     28.11.2025      Alena Gruner             Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_bakeoff_oven_chamber_bp_bended_count_30_1 (event_date, cy_week,
day_of_week, time_period_30_id, time_period_30_name, baking_program_id, loc_sid_store_move_to, client_id, loc_sid_wh,
wh_id, orig_store_nr, last_event_time, event_count, executed_baking_program_nr, executed_baking_program_name) AS SELECT
 *
FROM ldl_p_lew_mart_lead.v_ref_bakeoff_oven_chamber_bp_bended_count_30_1;