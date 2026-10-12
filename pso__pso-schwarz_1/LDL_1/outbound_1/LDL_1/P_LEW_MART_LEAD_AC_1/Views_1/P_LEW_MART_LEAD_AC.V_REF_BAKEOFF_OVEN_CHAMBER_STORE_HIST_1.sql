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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_bakeoff_oven_chamber_store_hist_1 (bakeoff_oven_chamber_sid,
bakeoff_oven_chamber_name, bakeoff_oven_chamber_serial_nr, bakeoff_oven_chamber_model_name,
bakeoff_oven_chamber_construction_year, bakeoff_oven_chamber_eow_dt, bakeoff_oven_pos_nr, bakeoff_oven_chamber_pos_cd,
client_id, store_loc_sid, loc_sid_store_move_to, active_fg, valid_from, valid_to, created_tmsp, updated_tmsp) AS SELECT
 bakeoff_oven_chamber_sid,
 bakeoff_oven_chamber_name,
 bakeoff_oven_chamber_serial_nr,
 bakeoff_oven_chamber_model_name,
 bakeoff_oven_chamber_construction_year,
 bakeoff_oven_chamber_eow_dt,
 bakeoff_oven_pos_nr,
 bakeoff_oven_chamber_pos_cd,
 client_id,
 store_loc_sid,
 loc_sid_store_move_to,
 active_fg,
 valid_from,
 valid_to,
 created_tmsp,
 updated_tmsp
FROM ldl_p_lew_mart_lead.t_ref_bakeoff_oven_chamber_store_hist_1;