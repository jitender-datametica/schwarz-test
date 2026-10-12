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

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_ADJ_BAKEOFF_OVEN_CHAMBER_STORE_2
(	 client_id
	,store_loc_sid
    ,loc_sid_store_move_to
    ,cy_week
 	,bakeoff_oven_chamber_event_dt
    ,day_of_week
  	,bakeoff_oven_pos_nr
	,bakeoff_oven_chamber_pos_cd

) AS 

SELECT DISTINCT 
  str.client_id
, str.store_loc_sid
, str.loc_sid_store_move_to
, str.cy_week
, str.bakeoff_oven_chamber_event_dt 
, str.day_of_week
, str.bakeoff_oven_pos_nr
, str.bakeoff_oven_chamber_pos_cd

FROM
(SELECT DISTINCT mrg.client_id
, mrg.loc_sid_store store_loc_sid
, mrg.loc_sid_store_move_to
, cal.cy_week
, cal.cal_dt AS bakeoff_oven_chamber_event_dt 
, cal.day_of_week
, mst.bakeoff_oven_pos_nr
, mst.bakeoff_oven_chamber_pos_cd
FROM P_LEW_BIL_AC.V_ORG_STORE_MERGE_2 mrg
CROSS JOIN  P_LEW_CORE_AC.V_CAL_CALENDARDAY_2 cal
--ON cal.dat_calendar = hst.cal_dt
CROSS JOIN
        (SELECT 1       AS  bakeoff_oven_pos_nr
              ,'top'    AS  bakeoff_oven_chamber_pos_cd
        UNION
        SELECT 1        AS  bakeoff_oven_pos_nr
              ,'bottom' AS  bakeoff_oven_chamber_pos_cd
        UNION
        SELECT 2        AS  bakeoff_oven_pos_nr
              ,'top'    AS  bakeoff_oven_chamber_pos_cd
        UNION
        SELECT 2        AS  bakeoff_oven_pos_nr
              ,'bottom' AS  bakeoff_oven_chamber_pos_cd
        UNION
        SELECT 3        AS  bakeoff_oven_pos_nr
              ,'top'    AS  bakeoff_oven_chamber_pos_cd
        UNION
        SELECT 3        AS  bakeoff_oven_pos_nr
              ,'bottom' AS  bakeoff_oven_chamber_pos_cd
        
        )mst
WHERE cal.cal_dt BETWEEN CURRENT_DATE-365 AND CURRENT_DATE 
AND mrg.mis_store_active_fg = 1
AND mrg.test_store_fg   = 0
AND mrg.aspect_id       = 2
)str

INNER JOIN
        (                           SELECT DISTINCT hst.client_id
                                         , hst.store_loc_sid
                                         , cal.cy_week
                            FROM P_LEW_MART_LEAD.T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_2 hst
                              INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_2 cal
                              ON cal.cal_dt BETWEEN hst.valid_from AND hst.valid_to
                            INNER JOIN P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT_2 evt
                             ON hst.bakeoff_oven_chamber_sid = evt.bakeoff_oven_chamber_sid
                            AND evt.bakeoff_oven_chamber_event_dt =cal.cal_dt
							WHERE cal.cal_dt BETWEEN CURRENT_DATE-365 AND CURRENT_DATE
                            AND hst.active_fg=1							
                            --WHERE evt.bakeoff_oven_chamber_event_type_cd IN ('bakingStarted' ,'cleaningEnded','heartbeat')
                            
        )ovn
 ON str.client_id = ovn.client_id
AND str.store_loc_sid = ovn.store_loc_sid
AND str.cy_week = ovn.cy_week
;

