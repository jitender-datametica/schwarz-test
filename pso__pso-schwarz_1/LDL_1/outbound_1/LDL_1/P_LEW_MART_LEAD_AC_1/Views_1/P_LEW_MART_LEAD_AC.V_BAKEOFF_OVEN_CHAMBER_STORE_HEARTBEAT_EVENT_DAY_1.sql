/*
#----------------------------------------------------------------------------
# Description:
# ACCESS VIEW. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     01.12.2025      Aparna Rayanki             Initial Version
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_bakeoff_oven_chamber_store_heartbeat_event_day_1 (client_id, wh_id,
loc_sid_wh, orig_store_nr, loc_sid_store_move_to, store_open_fg, cy_week, bakeoff_oven_chamber_event_dt,
bakeoff_oven_pos_nr, bakeoff_oven_chamber_pos_cd, oven_chamber_mstr_id, hb_oven_chamber_mstr_id, cnt_heartbeat) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_bakeoff_oven_chamber_store_heartbeat_event_day_1;