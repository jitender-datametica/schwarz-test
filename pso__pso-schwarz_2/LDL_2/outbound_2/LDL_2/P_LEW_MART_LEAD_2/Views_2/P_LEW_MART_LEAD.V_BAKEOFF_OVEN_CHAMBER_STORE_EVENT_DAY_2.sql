/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated list of cleanings and bakings with the granularity of country_2/store/day/chamber. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#  1.1     01.12.2025      Aparna Rayanki             performance fix 
#  1.2     01.12.2025      Aparna Rayanki             switching to mart table T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_2
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_bakeoff_oven_chamber_store_event_day_2 (client_id, wh_id, loc_sid_wh,
orig_store_nr, loc_sid_store_move_to, store_open_fg, cy_week, bakeoff_oven_chamber_event_dt, day_of_week,
bakeoff_oven_pos_nr, bakeoff_oven_chamber_pos_cd, oven_chamber_mstr_id, src_oven_chamber_mstr_id, chamber_image_link,
bakeoff_oven_chamber_baking_program_id, time_last_baking_program, cnt_cleanings) AS SELECT STR.client_id,
 WH.src_wh_id AS wh_id,
 WH.loc_sid_wh,
 STR.src_orig_store_nr AS orig_store_nr,
 STR.loc_sid_store_move_to,
 HST2.store_open_fg,
 evt.cy_week,
 evt.bakeoff_oven_chamber_event_dt,
 evt.day_of_week,
 evt.bakeoff_oven_pos_nr,
 evt.bakeoff_oven_chamber_pos_cd,
 evt.oven_chamber_mstr_id,
  CASE
  WHEN HST2.store_open_fg = 1
  THEN evt.src_oven_chamber_mstr_id
  ELSE NULL
  END AS src_oven_chamber_mstr_id,
  CASE
  WHEN evt.bakeoff_oven_chamber_pos_cd = 'top'
  THEN 'https://mis-lidl.schwarz/MicroStrategy/images/_custom/lidl/Bakeoff/OvenTop.png'
  WHEN evt.bakeoff_oven_chamber_pos_cd = 'bottom'
  THEN 'https://mis-lidl.schwarz/MicroStrategy/images/_custom/lidl/Bakeoff/OvenBottom.png'
  ELSE NULL
  END AS chamber_image_link,
 evt.bakeoff_oven_chamber_baking_program_id,
 evt.time_last_baking_program,
  CASE
  WHEN HST2.store_open_fg = 0
  THEN NULL
  WHEN HST2.store_open_fg = 1
  THEN evt.cnt_cleanings
  ELSE NULL
  END AS cnt_cleanings
FROM (SELECT DISTINCT client_id -- , cl.loc_sid_wh
,
   loc_sid_store_move_to,
   cy_week,
   bakeoff_oven_chamber_event_dt,
   day_of_week,
   bakeoff_oven_pos_nr,
   bakeoff_oven_chamber_pos_cd,
   ROUND(CAST(CAST(bakeoff_oven_pos_nr AS STRING) || CAST(LENGTH(bakeoff_oven_chamber_pos_cd) AS STRING) AS BIGNUMERIC)
    , 0) AS oven_chamber_mstr_id,
    CASE
    WHEN src_bakeoff_oven_pos_nr IS NULL OR src_bakeoff_oven_chamber_pos_cd IS NULL
    THEN NULL
    ELSE ROUND(CAST(CAST(bakeoff_oven_pos_nr AS STRING) || CAST(LENGTH(bakeoff_oven_chamber_pos_cd) AS STRING) AS
      BIGNUMERIC), 0)
    END AS src_oven_chamber_mstr_id,
   bakeoff_oven_chamber_baking_program_id,
   time_last_baking_program,
   cnt_cleanings
  FROM (SELECT DISTINCT REF.client_id,
     REF.loc_sid_store_move_to,
     REF.cy_week,
     REF.bakeoff_oven_chamber_event_dt,
     REF.day_of_week,
     REF.bakeoff_oven_pos_nr,
     REF.bakeoff_oven_chamber_pos_cd,
     evt.bakeoff_oven_pos_nr AS src_bakeoff_oven_pos_nr,
     evt.bakeoff_oven_chamber_pos_cd AS src_bakeoff_oven_chamber_pos_cd,
     lbe.bakeoff_oven_chamber_baking_program_id,
     lbe.time_last_baking_program,
     evt.cnt_cleanings
    FROM ldl_p_lew_mart_lead.v_ref_adj_bakeoff_oven_chamber_store_2 AS REF
     LEFT JOIN (SELECT evt.client_id,
       evt.store_loc_sid,
       evt.bakeoff_oven_chamber_event_dt,
       evt.bakeoff_oven_pos_nr,
       evt.bakeoff_oven_chamber_pos_cd,
       SUM(CASE
         WHEN ECL.bakeoff_oven_chamber_event_type_cd = 'cleaningEnded'
         THEN 1
         ELSE 0
         END) AS cnt_cleanings
      FROM (SELECT DISTINCT HST.client_id,
         HST.store_loc_sid,
         EVT.bakeoff_oven_chamber_event_dt,
         HST.bakeoff_oven_chamber_sid,
         HST.bakeoff_oven_pos_nr,
         HST.bakeoff_oven_chamber_pos_cd
        FROM ldl_p_lew_mart_lead.t_ref_bakeoff_oven_chamber_store_hist_2 AS HST
         INNER JOIN ldl_p_lew_core.t_bakeoff_oven_chamber_event_2 AS EVT ON HST.bakeoff_oven_chamber_sid = EVT.bakeoff_oven_chamber_sid
             AND EVT.bakeoff_oven_chamber_event_dt BETWEEN HST.valid_from AND HST.valid_to AND EVT.bakeoff_oven_chamber_event_type_cd
            = 'heartbeat'
        WHERE HST.active_fg = 1) AS evt
       LEFT JOIN ldl_p_lew_core.t_bakeoff_oven_chamber_event_2 AS ECL ON evt.bakeoff_oven_chamber_sid = ECL.bakeoff_oven_chamber_sid
           AND evt.bakeoff_oven_chamber_event_dt = ECL.bakeoff_oven_chamber_event_dt AND ECL.bakeoff_oven_chamber_event_type_cd
          = 'cleaningEnded'
      GROUP BY evt.client_id,
       evt.store_loc_sid,
       evt.bakeoff_oven_chamber_event_dt,
       evt.bakeoff_oven_pos_nr,
       evt.bakeoff_oven_chamber_pos_cd) AS evt ON REF.client_id = evt.client_id AND REF.store_loc_sid = evt.store_loc_sid
           AND REF.bakeoff_oven_chamber_event_dt = evt.bakeoff_oven_chamber_event_dt AND REF.bakeoff_oven_pos_nr = evt.bakeoff_oven_pos_nr
         AND REF.bakeoff_oven_chamber_pos_cd = evt.bakeoff_oven_chamber_pos_cd
     LEFT JOIN (SELECT be.client_id,
       be.store_loc_sid,
       be.bakeoff_oven_chamber_event_dt,
       be.bakeoff_oven_chamber_event_tm AS time_last_baking_program,
       MAX(bi.bakeoff_oven_chamber_baking_program_id) AS bakeoff_oven_chamber_baking_program_id
      FROM (SELECT HST0.client_id,
         HST0.store_loc_sid,
         EVT0.bakeoff_oven_chamber_event_dt,
         MAX(CASE
           WHEN ECB.bakeoff_oven_chamber_event_type_cd = 'bakingStarted'
           THEN ECB.bakeoff_oven_chamber_event_tm
           ELSE NULL
           END) AS bakeoff_oven_chamber_event_tm
        FROM ldl_p_lew_mart_lead.t_ref_bakeoff_oven_chamber_store_hist_2 AS HST0
         INNER JOIN ldl_p_lew_core.t_bakeoff_oven_chamber_event_2 AS EVT0 ON HST0.bakeoff_oven_chamber_sid = EVT0.bakeoff_oven_chamber_sid
            AND EVT0.bakeoff_oven_chamber_event_dt BETWEEN HST0.valid_from AND HST0.valid_to
         LEFT JOIN ldl_p_lew_core.t_bakeoff_oven_chamber_event_2 AS ECB ON EVT0.bakeoff_oven_chamber_sid = ECB.bakeoff_oven_chamber_sid
             AND EVT0.bakeoff_oven_chamber_event_dt = ECB.bakeoff_oven_chamber_event_dt AND ECB.bakeoff_oven_chamber_event_type_cd
            = 'bakingStarted'
        WHERE HST0.active_fg = 1
        GROUP BY HST0.client_id,
         HST0.store_loc_sid,
         EVT0.bakeoff_oven_chamber_event_dt) AS be
       INNER JOIN (SELECT DISTINCT HST1.client_id,
         HST1.store_loc_sid,
         EVT1.bakeoff_oven_chamber_event_dt,
         EVT1.bakeoff_oven_chamber_event_tm,
         EVT1.bakeoff_oven_chamber_baking_program_id
        FROM ldl_p_lew_mart_lead.t_ref_bakeoff_oven_chamber_store_hist_2 AS HST1
         INNER JOIN ldl_p_lew_core.t_bakeoff_oven_chamber_event_2 AS EVT1 ON HST1.bakeoff_oven_chamber_sid = EVT1.bakeoff_oven_chamber_sid
             AND EVT1.bakeoff_oven_chamber_event_dt BETWEEN HST1.valid_from AND HST1.valid_to AND EVT1.bakeoff_oven_chamber_event_type_cd
            = 'bakingStarted'
        WHERE HST1.active_fg = 1) AS bi ON be.client_id = bi.client_id AND be.store_loc_sid = bi.store_loc_sid AND be.bakeoff_oven_chamber_event_dt
           = bi.bakeoff_oven_chamber_event_dt AND be.bakeoff_oven_chamber_event_tm = bi.bakeoff_oven_chamber_event_tm
      GROUP BY be.client_id,
       be.store_loc_sid,
       be.bakeoff_oven_chamber_event_dt,
       time_last_baking_program) AS lbe ON REF.client_id = lbe.client_id AND REF.store_loc_sid = lbe.store_loc_sid AND
       REF.bakeoff_oven_chamber_event_dt = lbe.bakeoff_oven_chamber_event_dt) AS cl) AS evt
 INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_2 AS STR ON evt.client_id = STR.client_id AND evt.loc_sid_store_move_to =
     STR.loc_sid_store_move_to AND STR.aspect_id = 2 AND STR.dat_closing_ovis IS NULL
 INNER JOIN ldl_p_lew_core.t_location_opening_hour_hist_2 AS HST2 ON evt.client_id = HST2.client_id AND evt.loc_sid_store_move_to
     = HST2.store_loc_sid AND evt.bakeoff_oven_chamber_event_dt = HST2.cal_dt
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON STR.client_id = WH.client_id AND STR.loc_sid_wh = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
WHERE evt.bakeoff_oven_chamber_event_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) AND (CURRENT_DATE);