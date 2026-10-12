/*
#----------------------------------------------------------------------------
# Description:
# Creating 6 dummy_1 chambers for all stores of IOT source data to display nulls for inactive chambers. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_adj_bakeoff_oven_chamber_store_1 (client_id, store_loc_sid,
loc_sid_store_move_to, cy_week, bakeoff_oven_chamber_event_dt, day_of_week, bakeoff_oven_pos_nr,
bakeoff_oven_chamber_pos_cd) AS -- ON cal.dat_calendar = hst.cal_dt
 SELECT str.client_id,
 str.store_loc_sid,
 str.loc_sid_store_move_to,
 str.cy_week,
 str.bakeoff_oven_chamber_event_dt,
 str.day_of_week,
 str.bakeoff_oven_pos_nr,
 str.bakeoff_oven_chamber_pos_cd
FROM (SELECT DISTINCT MRG.client_id,
   MRG.loc_sid_store AS store_loc_sid,
   MRG.loc_sid_store_move_to,
   CAL.cy_week,
   CAL.cal_dt AS bakeoff_oven_chamber_event_dt,
   CAL.day_of_week,
   mst.bakeoff_oven_pos_nr,
   mst.bakeoff_oven_chamber_pos_cd
  FROM ldl_p_lew_bil_ac.v_org_store_merge_1 AS MRG
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON TRUE
   INNER JOIN (SELECT 1 AS bakeoff_oven_pos_nr,
      'top' AS bakeoff_oven_chamber_pos_cd
     UNION ALL
     SELECT 1 AS bakeoff_oven_pos_nr,
      'bottom' AS bakeoff_oven_chamber_pos_cd
     UNION ALL
     SELECT 2 AS bakeoff_oven_pos_nr,
      'top' AS bakeoff_oven_chamber_pos_cd
     UNION ALL
     SELECT 2 AS bakeoff_oven_pos_nr,
      'bottom' AS bakeoff_oven_chamber_pos_cd
     UNION ALL
     SELECT 3 AS bakeoff_oven_pos_nr,
      'top' AS bakeoff_oven_chamber_pos_cd
     UNION ALL
     SELECT 3 AS bakeoff_oven_pos_nr,
      'bottom' AS bakeoff_oven_chamber_pos_cd) AS mst ON TRUE
  WHERE CAL.cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) AND (CURRENT_DATE)
   AND MRG.mis_store_active_fg = 1
   AND MRG.test_store_fg = 0
   AND MRG.aspect_id = 2) AS str
 INNER JOIN (SELECT DISTINCT HST.client_id,
   HST.store_loc_sid,
   CAL0.cy_week
  FROM ldl_p_lew_mart_lead.t_ref_bakeoff_oven_chamber_store_hist_1 AS HST
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL0 ON CAL0.cal_dt BETWEEN HST.valid_from AND HST.valid_to
   INNER JOIN ldl_p_lew_core.t_bakeoff_oven_chamber_event_1 AS EVT ON HST.bakeoff_oven_chamber_sid = EVT.bakeoff_oven_chamber_sid
      AND CAL0.cal_dt = EVT.bakeoff_oven_chamber_event_dt
  WHERE CAL0.cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) AND (CURRENT_DATE)
   AND HST.active_fg = 1
    -- WHERE evt.bakeoff_oven_chamber_event_type_cd IN ('bakingStarted' ,'cleaningEnded','heartbeat')
) AS ovn ON str.client_id
     = ovn.client_id AND str.store_loc_sid = ovn.store_loc_sid AND str.cy_week = ovn.cy_week;