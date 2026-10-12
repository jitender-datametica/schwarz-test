/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated list of cleanings and bakings with the granularity of country/store/wk. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#  1.1     26.11.2025      Aparna Rayanki             Added new metrics
#  1.2     22.12.2025      Aparna Rayanki             Adjusted cnt_cleanings_wk logic
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_BAKEOFF_OVEN_CHAMBER_STORE_EVENT_WK(
	 client_id
	,wh_id
	,loc_sid_wh
	,orig_store_nr
	,loc_sid_store_move_to
	,cy_week
	,cnt_active_oven_chamber_wk
    ,sum_active_oven_chamber
	,cnt_cleanings_wk
	,cnt_heartbeat
) AS
SELECT
     client_id
   , wh_id
   , loc_sid_wh
   , orig_store_nr
   , loc_sid_store_move_to
   , cy_week
   , COUNT(DISTINCT src_oven_chamber_mstr_id) AS  cnt_active_oven_chamber_wk
   , SUM(sum_active_oven_chamber) 
   , SUM(cnt_cleanings_wk)
   , SUM(cnt_heartbeat)
FROM
(
SELECT
     main.client_id
   , main.wh_id
   , main.loc_sid_wh
   , main.orig_store_nr
   , main.loc_sid_store_move_to
   , main.cy_week
   , main.oven_chamber_mstr_id
   , MAX(main.src_oven_chamber_mstr_id)    AS src_oven_chamber_mstr_id 
   , COUNT(main.src_oven_chamber_mstr_id)  AS sum_active_oven_chamber 
   , (SUM(ZEROIFNULL(main.cnt_cleanings))/NULLIFZERO(COUNT(main.src_oven_chamber_mstr_id)))*SUM(main.store_open_fg) AS cnt_cleanings_wk
   , COUNT(hb.cnt_heartbeat) AS cnt_heartbeat
FROM P_LEW_MART_LEAD.V_BAKEOFF_OVEN_CHAMBER_STORE_EVENT_DAY main
INNER JOIN P_LEW_MART_LEAD.V_BAKEOFF_OVEN_CHAMBER_STORE_HEARTBEAT_EVENT_DAY hb
 ON main.client_id = hb.client_id
AND main.loc_sid_store_move_to = hb.loc_sid_store_move_to
AND main.bakeoff_oven_chamber_event_dt = hb.bakeoff_oven_chamber_event_dt
AND main.oven_chamber_mstr_id = hb.oven_chamber_mstr_id
GROUP BY 1,2,3,4,5,6,7
)wk
GROUP BY 1,2,3,4,5,6
;