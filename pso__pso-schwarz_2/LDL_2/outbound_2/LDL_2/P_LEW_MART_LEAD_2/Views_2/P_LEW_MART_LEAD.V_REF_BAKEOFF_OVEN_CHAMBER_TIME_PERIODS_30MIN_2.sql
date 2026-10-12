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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_bakeoff_oven_chamber_time_periods_30min_2 AS WITH TIMEGENERATOR AS (SELECT
   SEQ AS interval_sequence
  FROM UNNEST(GENERATE_ARRAY(0, 47)) AS SEQ) (SELECT interval_sequence + 1 AS time_period_30_id,
   TIME_ADD(TIME '00:00:00', INTERVAL interval_sequence * 30 MINUTE) AS period_start_time,
   TIME_ADD(TIME_ADD(TIME '00:00:00', INTERVAL (interval_sequence + 1) * 30 MINUTE), INTERVAL - 1 SECOND) AS
   period_end_time,
   CONCAT(FORMAT_TIME('%H:%M', TIME_ADD(TIME '00:00:00', INTERVAL interval_sequence * 30 MINUTE)), ' - ', FORMAT_TIME('%H:%M'
     , TIME_ADD(TIME_ADD(TIME '00:00:00', INTERVAL interval_sequence * 30 MINUTE), INTERVAL 30 MINUTE))) AS
   time_period_30_name
  FROM TIMEGENERATOR);