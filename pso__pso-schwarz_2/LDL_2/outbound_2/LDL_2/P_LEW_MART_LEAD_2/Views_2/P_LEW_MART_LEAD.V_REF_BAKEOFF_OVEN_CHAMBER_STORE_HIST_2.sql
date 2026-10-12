/*
#----------------------------------------------------------------------------
# Description:
# Creating 6 dummy_2 chambers for all stores of IOT source data to display nulls for inactive chambers. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#
#-----------------------------------------------------------------------------
*/


-- ,active_fg
 CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_bakeoff_oven_chamber_store_hist_2 (client_id,
store_loc_sid, loc_sid_store_move_to, cy_week, bakeoff_oven_chamber_event_dt, day_of_week, bakeoff_oven_pos_nr,
bakeoff_oven_chamber_pos_cd) AS -- ON cal.dat_calendar = hst.cal_dt
 SELECT DISTINCT str.client_id,
 str.store_loc_sid,
 str.loc_sid_store_move_to,
 str.cy_week,
 str.bakeoff_oven_chamber_event_dt,
 str.day_of_week,
 str.bakeoff_oven_pos_nr,
 str.bakeoff_oven_chamber_pos_cd
 -- , CASE WHEN evt.bakeoff_oven_chamber_event_dt > (CURRENT_DATE - 30) THEN 1 ELSE 0 END AS active_fg

 -- , store_open_fg

FROM (SELECT DISTINCT MRG.client_id,
   MRG.loc_sid_store AS store_loc_sid,
   MRG.loc_sid_store_move_to,
   CAL.cy_week,
   CAL.cal_dt AS bakeoff_oven_chamber_event_dt,
   CAL.day_of_week,
   mst.bakeoff_oven_pos_nr,
   mst.bakeoff_oven_chamber_pos_cd
  FROM ldl_p_lew_bil_ac.v_org_store_merge_2 AS MRG
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON TRUE
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
 INNER JOIN (SELECT DISTINCT OVN.client_id,
   OVN.store_loc_sid,
   OVN.bakeoff_oven_chamber_sid,
   CAL0.cal_dt AS bakeoff_oven_chamber_event_dt,
   CAL0.cy_week
  FROM ldl_p_lew_core.t_bakeoff_oven_chamber_hist_2 AS OVN
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL0 ON CAL0.cal_dt BETWEEN OVN.dwh_valid_from AND OVN.dwh_valid_to
    
  WHERE CAL0.cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) AND (CURRENT_DATE)) AS ovn ON str.client_id = ovn.client_id
     AND str.store_loc_sid = ovn.store_loc_sid AND str.bakeoff_oven_chamber_event_dt = ovn.bakeoff_oven_chamber_event_dt
   /* LEFT JOIN LDL.P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT_2 evt
 ON  ovn.bakeoff_oven_chamber_sid = evt.bakeoff_oven_chamber_sid
AND ovn.bakeoff_oven_chamber_event_dt =  evt.bakeoff_oven_chamber_event_dt
AND evt.bakeoff_oven_chamber_event_type_cd='heartbeat' */;