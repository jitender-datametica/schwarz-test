/*
#----------------------------------------------------------------------------
# Description:
# Creating 6 dummy chambers for all stores of IOT source data to display nulls for inactive chambers. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST
(	 client_id
	,store_loc_sid
    ,loc_sid_store_move_to
    ,cy_week
 	,bakeoff_oven_chamber_event_dt
    ,day_of_week
  	,bakeoff_oven_pos_nr
	,bakeoff_oven_chamber_pos_cd
   -- ,active_fg

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
--, CASE WHEN evt.bakeoff_oven_chamber_event_dt > (CURRENT_DATE - 30) THEN 1 ELSE 0 END AS active_fg
--, store_open_fg
FROM
(SELECT DISTINCT mrg.client_id
, mrg.loc_sid_store store_loc_sid
, mrg.loc_sid_store_move_to
, cal.cy_week
, cal.cal_dt AS bakeoff_oven_chamber_event_dt 
, cal.day_of_week
, mst.bakeoff_oven_pos_nr
, mst.bakeoff_oven_chamber_pos_cd
FROM P_LEW_BIL_AC.V_ORG_STORE_MERGE mrg
CROSS JOIN  P_LEW_CORE_AC.V_CAL_CALENDARDAY cal
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
        (SELECT DISTINCT 
		  ovn.client_id
		, ovn.store_loc_sid
		, ovn.bakeoff_oven_chamber_sid
		, cal.cal_dt  AS bakeoff_oven_chamber_event_dt
		, cal.cy_week
        FROM P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_HIST ovn
        INNER JOIN P_LEW_CORE_AC.V_CAL_CALENDARDAY cal
                ON cal.cal_dt BETWEEN ovn.dwh_valid_from AND ovn.dwh_valid_to
        WHERE cal.cal_dt BETWEEN CURRENT_DATE-365 AND CURRENT_DATE  
        )ovn
 ON str.client_id = ovn.client_id
AND str.store_loc_sid = ovn.store_loc_sid
AND str.bakeoff_oven_chamber_event_dt = ovn.bakeoff_oven_chamber_event_dt
/*
LEFT JOIN P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT evt
 ON  ovn.bakeoff_oven_chamber_sid = evt.bakeoff_oven_chamber_sid
AND ovn.bakeoff_oven_chamber_event_dt =  evt.bakeoff_oven_chamber_event_dt
AND evt.bakeoff_oven_chamber_event_type_cd='heartbeat' */

;