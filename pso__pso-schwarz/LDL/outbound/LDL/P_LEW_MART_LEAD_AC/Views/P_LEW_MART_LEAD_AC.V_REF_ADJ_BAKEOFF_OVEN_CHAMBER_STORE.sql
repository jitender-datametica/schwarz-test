/*
#----------------------------------------------------------------------------
# Description:
# ACCESS VIEW. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#
#-----------------------------------------------------------------------------
*/


-- ,active_fg
 -- ,active_fg
 CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_adj_bakeoff_oven_chamber_store (client_id
, store_loc_sid, loc_sid_store_move_to, cy_week, bakeoff_oven_chamber_event_dt, day_of_week, bakeoff_oven_pos_nr,
bakeoff_oven_chamber_pos_cd) AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_adj_bakeoff_oven_chamber_store;