/*
#----------------------------------------------------------------------------
# Description:
# ACCESS VIEW. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#  2.0     12.01.2026      Ilker Akin                 Updated columns and table
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_1
(
 bakeoff_oven_chamber_sid
,bakeoff_oven_chamber_name
,bakeoff_oven_chamber_serial_nr
,bakeoff_oven_chamber_model_name
,bakeoff_oven_chamber_construction_year
,bakeoff_oven_chamber_eow_dt
,bakeoff_oven_pos_nr
,bakeoff_oven_chamber_pos_cd
,client_id
,store_loc_sid
,loc_sid_store_move_to
,active_fg
,valid_from
,valid_to
,created_tmsp
,updated_tmsp
) 
AS
SELECT
 bakeoff_oven_chamber_sid
,bakeoff_oven_chamber_name
,bakeoff_oven_chamber_serial_nr
,bakeoff_oven_chamber_model_name
,bakeoff_oven_chamber_construction_year
,bakeoff_oven_chamber_eow_dt
,bakeoff_oven_pos_nr
,bakeoff_oven_chamber_pos_cd
,client_id
,store_loc_sid
,loc_sid_store_move_to
,active_fg
,valid_from
,valid_to
,created_tmsp
,updated_tmsp
FROM P_LEW_MART_LEAD.T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_1
;