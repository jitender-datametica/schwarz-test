/*
#----------------------------------------------------------------------------
# Description:
# ACCESS VIEW
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#  1.1     26.11.2025      Aparna Rayanki             Added new metrics
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_bakeoff_oven_chamber_store_event_wk_1 (client_id, wh_id, loc_sid_wh,
orig_store_nr, loc_sid_store_move_to, cy_week, cnt_active_oven_chamber_wk, sum_active_oven_chamber, cnt_cleanings_wk,
cnt_heartbeat) AS SELECT *
FROM ldl_p_lew_mart_lead.v_bakeoff_oven_chamber_store_event_wk_1;