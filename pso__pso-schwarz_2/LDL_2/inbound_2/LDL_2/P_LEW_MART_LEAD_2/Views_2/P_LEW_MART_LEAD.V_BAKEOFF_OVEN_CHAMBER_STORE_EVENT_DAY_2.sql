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
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_BAKEOFF_OVEN_CHAMBER_STORE_EVENT_DAY_2(
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
     str.client_id
    ,wh.src_wh_id          AS wh_id
    ,wh.loc_sid_wh
    ,str.src_orig_store_nr AS orig_store_nr
    ,str.loc_sid_store_move_to
    ,hst.store_open_fg
    ,evt.cy_week
    ,evt.bakeoff_oven_chamber_event_dt
    ,evt.day_of_week
    ,evt.bakeoff_oven_pos_nr
    ,evt.bakeoff_oven_chamber_pos_cd
    ,evt.oven_chamber_mstr_id
    ,CASE WHEN hst.store_open_fg=1 THEN evt.src_oven_chamber_mstr_id  ELSE NULL END src_oven_chamber_mstr_id
   	,CASE WHEN evt.bakeoff_oven_chamber_pos_cd='top' THEN 'https://mis-lidl.schwarz/MicroStrategy/images/_custom/lidl/Bakeoff/OvenTop.png'
          WHEN evt.bakeoff_oven_chamber_pos_cd='bottom' THEN 'https://mis-lidl.schwarz/MicroStrategy/images/_custom/lidl/Bakeoff/OvenBottom.png'
	      END AS chamber_image_link
    ,evt.bakeoff_oven_chamber_baking_program_id
    ,evt.time_last_baking_program
    ,CASE WHEN hst.store_open_fg=0 THEN NULL
          WHEN hst.store_open_fg=1 THEN evt.cnt_cleanings END AS cnt_cleanings

FROM
(
    SELECT DISTINCT
      cl.client_id
    --, cl.loc_sid_wh
    , cl.loc_sid_store_move_to
    , cl.cy_week
    , cl.bakeoff_oven_chamber_event_dt
    , cl.day_of_week
    , cl.bakeoff_oven_pos_nr
    , cl.bakeoff_oven_chamber_pos_cd
    , (cl.bakeoff_oven_pos_nr || LENGTH(cl.bakeoff_oven_chamber_pos_cd))::DECIMAL(18,0) AS oven_chamber_mstr_id
    , CASE WHEN cl.src_bakeoff_oven_pos_nr IS NULL THEN NULL 
           WHEN cl.src_bakeoff_oven_pos_nr IS NOT NULL AND cl.src_bakeoff_oven_chamber_pos_cd IS NULL THEN NULL
           ELSE oven_chamber_mstr_id END AS src_oven_chamber_mstr_id
    , cl.bakeoff_oven_chamber_baking_program_id
    , cl.time_last_baking_program
    , cl.cnt_cleanings
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
            , evt.bakeoff_oven_pos_nr AS src_bakeoff_oven_pos_nr
            , evt.bakeoff_oven_chamber_pos_cd AS src_bakeoff_oven_chamber_pos_cd
            , lbe.bakeoff_oven_chamber_baking_program_id
            , lbe.time_last_baking_program
            , evt.cnt_cleanings 
            FROM P_LEW_MART_LEAD.V_REF_ADJ_BAKEOFF_OVEN_CHAMBER_STORE_2 ref
            LEFT JOIN
                      (SELECT evt.client_id, evt.store_loc_sid, evt.bakeoff_oven_chamber_event_dt, evt.bakeoff_oven_pos_nr, evt.bakeoff_oven_chamber_pos_cd
                      , SUM(CASE WHEN ecl.bakeoff_oven_chamber_event_type_cd= 'cleaningEnded' THEN 1 
                                 ELSE 0 
                            END) AS cnt_cleanings
                      FROM
                          ( SELECT DISTINCT hst.client_id
                                           , hst.store_loc_sid
                                         , evt.bakeoff_oven_chamber_event_dt
                                         , hst.bakeoff_oven_chamber_sid
                                         , hst.bakeoff_oven_pos_nr
                                         , hst.bakeoff_oven_chamber_pos_cd
                            FROM P_LEW_MART_LEAD.T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_2 hst
                            INNER JOIN P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT_2 evt
                             ON hst.bakeoff_oven_chamber_sid = evt.bakeoff_oven_chamber_sid
                            AND evt.bakeoff_oven_chamber_event_dt BETWEEN hst.valid_from AND hst.valid_to
                            AND  evt.bakeoff_oven_chamber_event_type_cd = 'heartbeat'
							WHERE hst.active_fg=1
                          )evt
                      LEFT JOIN P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT_2 ecl
                      ON evt.bakeoff_oven_chamber_sid = ecl.bakeoff_oven_chamber_sid 
                      AND evt.bakeoff_oven_chamber_event_dt = ecl.bakeoff_oven_chamber_event_dt
                      AND ecl.bakeoff_oven_chamber_event_type_cd ='cleaningEnded'
                      GROUP BY 1,2,3,4,5
                      
                      )evt
              ON ref.client_id = evt.client_id
              AND ref.store_loc_sid = evt.store_loc_sid
              AND ref.bakeoff_oven_chamber_event_dt = evt.bakeoff_oven_chamber_event_dt
              AND ref.bakeoff_oven_pos_nr = evt.bakeoff_oven_pos_nr
              AND ref.bakeoff_oven_chamber_pos_cd = evt.bakeoff_oven_chamber_pos_cd
              
            LEFT JOIN             
                                 (SELECT DISTINCT be.client_id
                                   , be.store_loc_sid
                                   , be.bakeoff_oven_chamber_event_dt
                                   , be.bakeoff_oven_chamber_event_tm               AS time_last_baking_program
                                   , MAX(bi.bakeoff_oven_chamber_baking_program_id) AS bakeoff_oven_chamber_baking_program_id
                    FROM
                         (SELECT hst.client_id
                                , hst.store_loc_sid
                                , evt.bakeoff_oven_chamber_event_dt
                           ,MAX(CASE WHEN ecb.bakeoff_oven_chamber_event_type_cd ='bakingStarted' 
                                     THEN ecb.bakeoff_oven_chamber_event_tm 
                                     ELSE NULL 
                                     END) AS bakeoff_oven_chamber_event_tm
                           FROM P_LEW_MART_LEAD.T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_2 hst
                           INNER JOIN P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT_2 evt
                                  ON hst.bakeoff_oven_chamber_sid = evt.bakeoff_oven_chamber_sid
                                 AND evt.bakeoff_oven_chamber_event_dt BETWEEN hst.valid_from AND hst.valid_to
                            LEFT JOIN P_LEW_CORE.t_bakeoff_oven_chamber_event_2 ecb
                                  ON evt.bakeoff_oven_chamber_sid = ecb.bakeoff_oven_chamber_sid 
                                 AND evt.bakeoff_oven_chamber_event_dt = ecb.bakeoff_oven_chamber_event_dt
                                 AND ecb.bakeoff_oven_chamber_event_type_cd =  'bakingStarted'
                            WHERE hst.active_fg=1								 
                         GROUP BY 1,2,3
                         )be
            
                    INNER JOIN 
                        (SELECT DISTINCT hst.client_id
                                       , hst.store_loc_sid
                                       , evt.bakeoff_oven_chamber_event_dt 
                                       , bakeoff_oven_chamber_event_tm
                                       , bakeoff_oven_chamber_baking_program_id
                           FROM P_LEW_MART_LEAD.T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_2 hst
                           INNER JOIN P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT_2 evt
                                 ON hst.bakeoff_oven_chamber_sid = evt.bakeoff_oven_chamber_sid
                                AND evt.bakeoff_oven_chamber_event_dt BETWEEN hst.valid_from AND hst.valid_to
                                AND  evt.bakeoff_oven_chamber_event_type_cd = 'bakingStarted'
                           WHERE hst.active_fg=1								
                        )bi
                        ON be.client_id = bi.client_id
                        AND be.store_loc_sid = bi.store_loc_sid
                        AND be.bakeoff_oven_chamber_event_dt = bi.bakeoff_oven_chamber_event_dt
                        AND be.bakeoff_oven_chamber_event_tm = bi.bakeoff_oven_chamber_event_tm
                        GROUP BY 1,2,3,4
                    )lbe
                   ON ref.client_id = lbe.client_id
                   AND ref.store_loc_sid = lbe.store_loc_sid
                   AND ref.bakeoff_oven_chamber_event_dt = lbe.bakeoff_oven_chamber_event_dt
            )cl

)evt


INNER JOIN P_LEW_BIL_AC.V_ORG_STORE_MERGE_2 str
ON evt.client_id = str.client_id
AND evt.loc_sid_store_move_to = str.loc_sid_store_move_to
AND str.aspect_id=2
AND str.dat_closing_ovis IS NULL

INNER JOIN P_LEW_CORE.T_LOCATION_OPENING_HOUR_HIST_2 hst
ON evt.client_id = hst.client_id
AND evt.loc_sid_store_move_to = hst.store_loc_sid
AND evt.bakeoff_oven_chamber_event_dt = hst.cal_dt

INNER JOIN P_LEW_BIL_AC.V_WAREHOUSE_2 AS wh
ON  wh.client_id     = str.client_id
AND wh.loc_sid_wh    = str.loc_sid_wh
AND wh.dwh_actual_fg = 1

WHERE evt.BAKEOFF_OVEN_CHAMBER_EVENT_DT BETWEEN CURRENT_DATE-365 AND CURRENT_DATE

;