/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated list of heartbeats for Connectivity metric with the granularity of country_1/store/day/chamber. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#  1.1     01.12.2025      Aparna Rayanki             switching to mart table T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_1
#  1.2     01.15.2026      Aparna Rayanki             correction to get heartbeat count
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_BAKEOFF_OVEN_CHAMBER_STORE_HEARTBEAT_EVENT_DAY_1(
     client_id
    ,wh_id
    ,loc_sid_wh
    ,orig_store_nr
    ,loc_sid_store_move_to
    ,store_open_fg
    ,cy_week
    ,bakeoff_oven_chamber_event_dt
    ,bakeoff_oven_pos_nr
    ,bakeoff_oven_chamber_pos_cd
    ,oven_chamber_mstr_id
    ,hb_oven_chamber_mstr_id
    ,cnt_heartbeat
) AS
SELECT
     str.client_id
    ,wh.src_wh_id          AS wh_id
    ,wh.loc_sid_wh
    ,str.src_orig_store_nr AS orig_store_nr
    ,str.loc_sid_store_move_to
    ,hst.store_open_fg
    ,evt.cy_week
    ,evt.bakeoff_oven_chamber_event_dt
    ,evt.bakeoff_oven_pos_nr
    ,evt.bakeoff_oven_chamber_pos_cd
    ,evt.oven_chamber_mstr_id 
   ,CASE WHEN hst.store_open_fg=1 THEN evt.hb_oven_chamber_mstr_id  ELSE NULL END hb_oven_chamber_mstr_id
   ,CASE WHEN hst.store_open_fg=0 THEN NULL 
         WHEN hst.store_open_fg=1 THEN evt.cnt_heartbeat 
		 END AS cnt_heartbeat
FROM
( SELECT DISTINCT
      cl.client_id
    , cl.loc_sid_store_move_to
    , cl.cy_week
    , cl.bakeoff_oven_chamber_event_dt
    , cl.day_of_week
    , cl.bakeoff_oven_pos_nr
    , cl.bakeoff_oven_chamber_pos_cd
    , (cl.bakeoff_oven_pos_nr || LENGTH(cl.bakeoff_oven_chamber_pos_cd))::DECIMAL(18,0) AS oven_chamber_mstr_id
    , CASE WHEN cl.hb_bakeoff_oven_pos_nr IS NULL THEN NULL 
           WHEN cl.hb_bakeoff_oven_pos_nr IS NOT NULL AND cl.hb_bakeoff_oven_chamber_pos_cd IS NULL THEN NULL
           ELSE oven_chamber_mstr_id END AS hb_oven_chamber_mstr_id
   , CASE WHEN hb_oven_chamber_mstr_id IS NULL THEN NULL
           WHEN cl.bakeoff_oven_chamber_event_type_cd IS NOT NULL THEN 1
           ELSE 0
           END AS cnt_heartbeat
           FROM
                (
                  SELECT DISTINCT 
                              ref.client_id
                            , ref.loc_sid_store_move_to
                            , ref.cy_week
                            , ref.bakeoff_oven_chamber_event_dt
                            , ref.day_of_week
                            , ref.bakeoff_oven_pos_nr
                            , ref.bakeoff_oven_chamber_pos_cd
                            , hb.bakeoff_oven_pos_nr AS hb_bakeoff_oven_pos_nr
                            , hb.bakeoff_oven_chamber_pos_cd AS hb_bakeoff_oven_chamber_pos_cd
                            , hb.bakeoff_oven_chamber_event_type_cd         
                            FROM P_LEW_MART_LEAD.V_REF_ADJ_BAKEOFF_OVEN_CHAMBER_STORE_1 ref
                         LEFT JOIN
                                    ( SELECT DISTINCT hst.client_id
                                                         , hst.store_loc_sid
                                                         , hst.bakeoff_oven_chamber_event_dt
                                                         , hst.bakeoff_oven_pos_nr
                                                         , hst.bakeoff_oven_chamber_pos_cd
                                                         , evt.bakeoff_oven_chamber_event_type_cd
                                                         FROM
                                                      (SELECT DISTINCT hst.client_id
                                                         , hst.store_loc_sid
                                                         , hst.bakeoff_oven_chamber_sid
                                                         , cal.cal_dt AS bakeoff_oven_chamber_event_dt
                                                         , hst.bakeoff_oven_pos_nr
                                                         , hst.bakeoff_oven_chamber_pos_cd
                                          FROM P_LEW_MART_LEAD.T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_1 hst
                                          INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1 cal
                                          ON cal.cal_dt BETWEEN hst.valid_from AND hst.valid_to
                                          WHERE active_fg=1
                                          AND cal.cal_dt BETWEEN CURRENT_DATE-365 AND CURRENT_DATE
                                          )hst
                                          LEFT JOIN P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT_1 evt
                                          ON hst.bakeoff_oven_chamber_sid = evt.bakeoff_oven_chamber_sid
                                          AND hst.bakeoff_oven_chamber_event_dt = evt.bakeoff_oven_chamber_event_dt 
                                          AND evt.bakeoff_oven_chamber_event_type_cd= 'heartbeat'
                                        )hb   
                              ON ref.client_id = hb.client_id
                              AND ref.store_loc_sid = hb.store_loc_sid
                              AND ref.bakeoff_oven_chamber_event_dt = hb.bakeoff_oven_chamber_event_dt
                              AND ref.bakeoff_oven_pos_nr = hb.bakeoff_oven_pos_nr
                              AND ref.bakeoff_oven_chamber_pos_cd = hb.bakeoff_oven_chamber_pos_cd 
                	)cl
)evt


INNER JOIN P_LEW_BIL_AC.V_ORG_STORE_MERGE_1 str
ON evt.client_id = str.client_id
AND evt.loc_sid_store_move_to = str.loc_sid_store_move_to
AND str.aspect_id=2
AND str.dat_closing_ovis IS NULL

INNER JOIN P_LEW_CORE.T_LOCATION_OPENING_HOUR_HIST_1 hst
ON evt.client_id = hst.client_id
AND evt.loc_sid_store_move_to = hst.store_loc_sid
AND evt.bakeoff_oven_chamber_event_dt = hst.cal_dt

INNER JOIN P_LEW_BIL_AC.V_WAREHOUSE_1 AS wh
ON  wh.client_id     = str.client_id
AND wh.loc_sid_wh    = str.loc_sid_wh
AND wh.dwh_actual_fg = 1

WHERE evt.BAKEOFF_OVEN_CHAMBER_EVENT_DT BETWEEN CURRENT_DATE-365 AND CURRENT_DATE
;