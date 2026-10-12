/*
#----------------------------------------------------------------------------
# Description:
# ACCESS VIEW. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#  1.1     01.12.2025      Aparna Rayanki             Adding cnt_heartbeat for Connectivity metric
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_BAKEOFF_OVEN_CHAMBER_STORE_EVENT_DAY_1(
	 client_id
	,wh_id
	,loc_sid_wh
	,orig_store_nr
	,loc_sid_store_move_to
	,store_open_fg
	,cy_week
	,bakeoff_oven_chamber_event_dt
	,day_of_week
	,bakeoff_oven_pos_nr
	,bakeoff_oven_chamber_pos_cd
	,oven_chamber_mstr_id
	,src_oven_chamber_mstr_id
	,chamber_image_link
	,bakeoff_oven_chamber_baking_program_id
	,time_last_baking_program
	,cnt_cleanings
) AS
SELECT
	 client_id
	,wh_id
	,loc_sid_wh
	,orig_store_nr
	,loc_sid_store_move_to
	,store_open_fg
	,cy_week
	,bakeoff_oven_chamber_event_dt
	,day_of_week
	,bakeoff_oven_pos_nr
	,bakeoff_oven_chamber_pos_cd
	,oven_chamber_mstr_id
	,src_oven_chamber_mstr_id
	,chamber_image_link
	,bakeoff_oven_chamber_baking_program_id
	,time_last_baking_program
	,cnt_cleanings
FROM  P_LEW_MART_LEAD.V_BAKEOFF_OVEN_CHAMBER_STORE_EVENT_DAY_1
;