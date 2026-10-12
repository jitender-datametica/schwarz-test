/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated list of cleanings and bakings with the granularity of country_1/store/wk. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     20.11.2025      Aparna Rayanki             Initial Version
#  1.1     26.11.2025      Aparna Rayanki             Added new metrics
#  1.2     22.12.2025      Aparna Rayanki             Adjusted cnt_cleanings_wk logic
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_bakeoff_oven_chamber_store_event_wk_1 (client_id, wh_id, loc_sid_wh,
orig_store_nr, loc_sid_store_move_to, cy_week, cnt_active_oven_chamber_wk, sum_active_oven_chamber, cnt_cleanings_wk,
cnt_heartbeat) AS SELECT client_id,
 wh_id,
 loc_sid_wh,
 orig_store_nr,
 loc_sid_store_move_to,
 cy_week,
 COUNT(DISTINCT src_oven_chamber_mstr_id) AS cnt_active_oven_chamber_wk,
 SUM(sum_active_oven_chamber) AS sum_active_oven_chamber,
 SUM(cnt_cleanings_wk) AS cnt_cleanings_wk,
 SUM(cnt_heartbeat) AS cnt_heartbeat
FROM (SELECT MAIN.client_id,
   MAIN.wh_id,
   MAIN.loc_sid_wh,
   MAIN.orig_store_nr,
   MAIN.loc_sid_store_move_to,
   MAIN.cy_week,
   MAX(MAIN.src_oven_chamber_mstr_id) AS src_oven_chamber_mstr_id,
   COUNT(MAIN.src_oven_chamber_mstr_id) AS sum_active_oven_chamber,
     SUM(IFNULL(MAIN.cnt_cleanings, 0)) / IF(COUNT(MAIN.src_oven_chamber_mstr_id) = 0, NULL, COUNT(MAIN.src_oven_chamber_mstr_id
       )) * SUM(MAIN.store_open_fg) AS cnt_cleanings_wk,
   COUNT(HB.cnt_heartbeat) AS cnt_heartbeat
  FROM ldl_p_lew_mart_lead.v_bakeoff_oven_chamber_store_event_day_1 AS MAIN
   INNER JOIN ldl_p_lew_mart_lead.v_bakeoff_oven_chamber_store_heartbeat_event_day_1 AS HB ON MAIN.client_id = HB.client_id
        AND MAIN.loc_sid_store_move_to = HB.loc_sid_store_move_to AND MAIN.bakeoff_oven_chamber_event_dt = HB.bakeoff_oven_chamber_event_dt
       AND MAIN.oven_chamber_mstr_id = HB.oven_chamber_mstr_id
  GROUP BY MAIN.client_id,
   MAIN.wh_id,
   MAIN.loc_sid_wh,
   MAIN.orig_store_nr,
   MAIN.loc_sid_store_move_to,
   MAIN.cy_week,
   MAIN.oven_chamber_mstr_id) AS wk
GROUP BY client_id,
 wh_id,
 loc_sid_wh,
 orig_store_nr,
 loc_sid_store_move_to,
 cy_week;