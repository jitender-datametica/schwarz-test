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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_ADJ_BAKEOFF_OVEN_CHAMBER_STORE_1
(	 client_id
	,store_loc_sid
    ,loc_sid_store_move_to
    ,cy_week
 	,bakeoff_oven_chamber_event_dt
    ,day_of_week
  	,bakeoff_oven_pos_nr
	,bakeoff_oven_chamber_pos_cd
   -- ,active_fg

) AS 
SELECT 
	 client_id
	,store_loc_sid
    ,loc_sid_store_move_to
    ,cy_week
 	,bakeoff_oven_chamber_event_dt
    ,day_of_week
  	,bakeoff_oven_pos_nr
	,bakeoff_oven_chamber_pos_cd
   -- ,active_fg
  FROM P_LEW_MART_LEAD.V_REF_ADJ_BAKEOFF_OVEN_CHAMBER_STORE_1
 ;