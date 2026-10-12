CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_mat_agg_store_day_oven_events (client_id, wh_loc_sid, wh_id,
loc_sid_store_move_to, aspect_id, oven_id, oven_brand, dat_formdate, cy_week, cy_month, busyear, cnt_cleanings,
cnt_baking_last_hour, no_baking_afternoon_fg, cnt_chmb_door_open, cnt_mantn_preheat_temprtr, cnt_cncld_pgm,
cnt_bake_bfr_str_open, connected_fg, cnt_late_door_opening, cnt_bakings_morning, cnt_bakings_afternoon, dwh_updated) AS
SELECT EVENTS.client_id,
 EVENTS.loc_sid_wh AS wh_loc_sid,
 LOC.src_wh_id AS wh_id,
 ORG.loc_sid_store_move_to,
 ORG.aspect_id,
 EVENTS.oven_id,
 EVENTS.oven_brand,
 EVENTS.event_tmsp AS dat_formdate,
 CAL.cy_week,
 CAL.cy_month,
 CAL.busyear,
 1 AS cnt_cleanings,
 1 AS cnt_baking_last_hour,
 1 AS no_baking_afternoon_fg,
 1 AS cnt_chmb_door_open,
 1 AS cnt_mantn_preheat_temprtr,
 1 AS cnt_cncld_pgm,
 1 AS cnt_bake_bfr_str_open,
 1 AS connected_fg,
 1 AS cnt_late_door_opening,
 1 AS cnt_bakings_morning,
 1 AS cnt_bakings_afternoon,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM ldl_p_lew_core_ac.v_bakeoff_oven_event AS EVENTS
 INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge AS ORG ON EVENTS.client_id = ORG.client_id AND EVENTS.loc_sid_store = ORG
   .loc_sid_store
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON EVENTS.client_id = LOC.client_id AND EVENTS.loc_sid_wh = LOC.loc_sid
  AND LOC.wh_store_mark = 'B'
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CAST(EVENTS.event_tmsp AS DATE) = CAL.cal_dt AND CAL.cy_month_seq
   BETWEEN -35 AND 1
GROUP BY EVENTS.client_id,
 wh_loc_sid,
 wh_id,
 ORG.loc_sid_store_move_to,
 ORG.aspect_id,
 EVENTS.oven_id,
 EVENTS.oven_brand,
 dat_formdate,
 CAL.cy_week,
 CAL.cy_month,
 CAL.busyear;