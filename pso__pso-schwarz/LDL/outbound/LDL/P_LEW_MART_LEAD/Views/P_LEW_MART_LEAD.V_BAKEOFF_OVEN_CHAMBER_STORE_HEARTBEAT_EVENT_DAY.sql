/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated list of heartbeats for Connectivity metric with the granularity of country/store/day/chamber. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#  1.1     01.12.2025      Aparna Rayanki             switching to mart table T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST
#  1.2     01.15.2026      Aparna Rayanki             correction to get heartbeat count
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_bakeoff_oven_chamber_store_heartbeat_event_day (client_id, wh_id,
loc_sid_wh, orig_store_nr, loc_sid_store_move_to, store_open_fg, cy_week, bakeoff_oven_chamber_event_dt,
bakeoff_oven_pos_nr, bakeoff_oven_chamber_pos_cd, oven_chamber_mstr_id, hb_oven_chamber_mstr_id, cnt_heartbeat) AS
SELECT STR.client_id,
 WH.src_wh_id AS wh_id,
 WH.loc_sid_wh,
 STR.src_orig_store_nr AS orig_store_nr,
 STR.loc_sid_store_move_to,
 HST0.store_open_fg,
 evt.cy_week,
 evt.bakeoff_oven_chamber_event_dt,
 evt.bakeoff_oven_pos_nr,
 evt.bakeoff_oven_chamber_pos_cd,
 evt.oven_chamber_mstr_id,
  CASE
  WHEN HST0.store_open_fg = 1
  THEN evt.hb_oven_chamber_mstr_id
  ELSE NULL
  END AS hb_oven_chamber_mstr_id,
  CASE
  WHEN HST0.store_open_fg = 0
  THEN NULL
  WHEN HST0.store_open_fg = 1
  THEN evt.cnt_heartbeat
  ELSE NULL
  END AS cnt_heartbeat
FROM (SELECT DISTINCT client_id,
   loc_sid_store_move_to,
   cy_week,
   bakeoff_oven_chamber_event_dt,
   day_of_week,
   bakeoff_oven_pos_nr,
   bakeoff_oven_chamber_pos_cd,
   ROUND(CAST(CAST(bakeoff_oven_pos_nr AS STRING) || CAST(LENGTH(bakeoff_oven_chamber_pos_cd) AS STRING) AS BIGNUMERIC)
    , 0) AS oven_chamber_mstr_id,
    CASE
    WHEN hb_bakeoff_oven_pos_nr IS NULL OR hb_bakeoff_oven_chamber_pos_cd IS NULL
    THEN NULL
    ELSE ROUND(CAST(CAST(bakeoff_oven_pos_nr AS STRING) || CAST(LENGTH(bakeoff_oven_chamber_pos_cd) AS STRING) AS
      BIGNUMERIC), 0)
    END AS hb_oven_chamber_mstr_id,
    CASE
    WHEN CASE
     WHEN hb_bakeoff_oven_pos_nr IS NULL OR hb_bakeoff_oven_chamber_pos_cd IS NULL
     THEN NULL
     ELSE ROUND(CAST(CAST(bakeoff_oven_pos_nr AS STRING) || CAST(LENGTH(bakeoff_oven_chamber_pos_cd) AS STRING) AS
       BIGNUMERIC), 0)
     END IS NULL
    THEN NULL
    WHEN bakeoff_oven_chamber_event_type_cd IS NOT NULL
    THEN 1
    ELSE 0
    END AS cnt_heartbeat
  FROM (SELECT DISTINCT REF.client_id,
     REF.loc_sid_store_move_to,
     REF.cy_week,
     REF.bakeoff_oven_chamber_event_dt,
     REF.day_of_week,
     REF.bakeoff_oven_pos_nr,
     REF.bakeoff_oven_chamber_pos_cd,
     hb.bakeoff_oven_pos_nr AS hb_bakeoff_oven_pos_nr,
     hb.bakeoff_oven_chamber_pos_cd AS hb_bakeoff_oven_chamber_pos_cd,
     hb.bakeoff_oven_chamber_event_type_cd
    FROM ldl_p_lew_mart_lead.v_ref_adj_bakeoff_oven_chamber_store AS REF
     LEFT JOIN (SELECT DISTINCT hst.client_id,
       hst.store_loc_sid,
       hst.bakeoff_oven_chamber_event_dt,
       hst.bakeoff_oven_pos_nr,
       hst.bakeoff_oven_chamber_pos_cd,
       EVT.bakeoff_oven_chamber_event_type_cd
      FROM (SELECT DISTINCT HST.client_id,
         HST.store_loc_sid,
         HST.bakeoff_oven_chamber_sid,
         CAL.cal_dt AS bakeoff_oven_chamber_event_dt,
         HST.bakeoff_oven_pos_nr,
         HST.bakeoff_oven_chamber_pos_cd
        FROM ldl_p_lew_mart_lead.t_ref_bakeoff_oven_chamber_store_hist AS HST
         INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CAL.cal_dt BETWEEN HST.valid_from AND HST.valid_to
        WHERE HST.active_fg = 1
         AND CAL.cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) AND (CURRENT_DATE)) AS hst
       LEFT JOIN ldl_p_lew_core.t_bakeoff_oven_chamber_event AS EVT ON hst.bakeoff_oven_chamber_sid = EVT.bakeoff_oven_chamber_sid
           AND hst.bakeoff_oven_chamber_event_dt = EVT.bakeoff_oven_chamber_event_dt AND EVT.bakeoff_oven_chamber_event_type_cd
          = 'heartbeat') AS hb ON REF.client_id = hb.client_id AND REF.store_loc_sid = hb.store_loc_sid AND REF.bakeoff_oven_chamber_event_dt
          = hb.bakeoff_oven_chamber_event_dt AND REF.bakeoff_oven_pos_nr = hb.bakeoff_oven_pos_nr AND REF.bakeoff_oven_chamber_pos_cd
        = hb.bakeoff_oven_chamber_pos_cd) AS cl) AS evt
 INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge AS STR ON evt.client_id = STR.client_id AND evt.loc_sid_store_move_to =
     STR.loc_sid_store_move_to AND STR.aspect_id = 2 AND STR.dat_closing_ovis IS NULL
 INNER JOIN ldl_p_lew_core.t_location_opening_hour_hist AS HST0 ON evt.client_id = HST0.client_id AND evt.loc_sid_store_move_to
     = HST0.store_loc_sid AND evt.bakeoff_oven_chamber_event_dt = HST0.cal_dt
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON STR.client_id = WH.client_id AND STR.loc_sid_wh = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
WHERE evt.bakeoff_oven_chamber_event_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) AND (CURRENT_DATE);