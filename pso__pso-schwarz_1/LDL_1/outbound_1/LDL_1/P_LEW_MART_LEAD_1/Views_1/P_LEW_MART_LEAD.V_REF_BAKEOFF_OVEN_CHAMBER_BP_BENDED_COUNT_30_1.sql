/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated list of bakings events count with the granularity of country_1/store/day/timeperiod. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     28.11.2025      Alena Gruner             Initial Version
#  1.1     01.12.2025      Aparna Rayanki             switching to mart table T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_1
#
#-----------------------------------------------------------------------------
*/


-- 1:
 CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_bakeoff_oven_chamber_bp_bended_count_30_1 AS WITH AGGREGATED_FACTS
 AS (SELECT E.bakeoff_oven_chamber_event_dt AS event_date,
   HIST.store_loc_sid,
   HIST.client_id,
   TP.time_period_30_id,
   TP.time_period_30_name,
   E.bakeoff_oven_chamber_event_type_cd AS baking_program_id,
   E.bakeoff_oven_chamber_baking_program_id AS real_program_nr,
   MAX(E.bakeoff_oven_chamber_event_tm) AS last_event_time,
   COUNT(*) AS event_count
  FROM ldl_p_lew_core.t_bakeoff_oven_chamber_event_1 AS E
   INNER JOIN ldl_p_lew_mart_lead.t_ref_bakeoff_oven_chamber_store_hist_1 AS HIST ON E.bakeoff_oven_chamber_sid = HIST.bakeoff_oven_chamber_sid
      AND E.bakeoff_oven_chamber_event_dt BETWEEN HIST.valid_from AND HIST.valid_to
   INNER JOIN ldl_p_lew_mart_lead.v_ref_bakeoff_oven_chamber_time_periods_30min_1 AS TP ON E.bakeoff_oven_chamber_event_tm
    BETWEEN TP.period_start_time AND TP.period_end_time
  WHERE E.bakeoff_oven_chamber_event_type_cd = 'bakingStarted'
   AND E.bakeoff_oven_chamber_event_dt >= DATE_ADD(CURRENT_DATE, INTERVAL - 65 DAY)
   AND HIST.active_fg = 1
  GROUP BY event_date,
   HIST.store_loc_sid,
   HIST.client_id,
   TP.time_period_30_id,
   TP.time_period_30_name,
   baking_program_id,
   real_program_nr), ACTIVE_CONTEXT AS (SELECT DISTINCT store_loc_sid,
   client_id,
   event_date
  FROM AGGREGATED_FACTS), SMART_MATRIX AS (SELECT DISTINCT ac.event_date,
   ac.store_loc_sid,
   ac.client_id,
   TP0.time_period_30_id,
   TP0.time_period_30_name
  FROM ACTIVE_CONTEXT AS ac
   INNER JOIN ldl_p_lew_mart_lead.v_ref_bakeoff_oven_chamber_time_periods_30min_1 AS TP0 ON TRUE), FULL_DATA AS (SELECT
  DISTINCT m.event_date,
   m.store_loc_sid,
   m.client_id,
   m.time_period_30_id,
   m.time_period_30_name,
   f.baking_program_id,
   f.last_event_time,
   COALESCE(f.event_count, 0) AS event_count,
   f.real_program_nr
  FROM SMART_MATRIX AS m
   LEFT JOIN AGGREGATED_FACTS AS f ON m.store_loc_sid = f.store_loc_sid AND m.event_date = f.event_date AND m.time_period_30_id
      = f.time_period_30_id) (-- 2:
 -- 3:
 -- 4:
 -- Fin
 SELECT DISTINCT fd.event_date,
   CAL.cy_week,
   CAL.day_of_week,
   fd.time_period_30_id,
   fd.time_period_30_name,
   COALESCE(fd.baking_program_id, 'bakingStarted') AS baking_program_id,
   STORE_VIEW.loc_sid_store_move_to,
   fd.client_id,
   STORE_VIEW.loc_sid_wh,
   WH_VIEW.src_wh_id AS wh_id,
   STORE_VIEW.src_orig_store_nr AS orig_store_nr,
   fd.last_event_time,
   fd.event_count,
   COALESCE(fd.real_program_nr, 0) AS executed_baking_program_nr,
    CASE
    WHEN COALESCE(fd.real_program_nr, 0) = 1
    THEN 'Brot / Sü\u00dfteilchen'
    WHEN COALESCE(fd.real_program_nr, 0) = 2
    THEN 'Brötchen'
    WHEN COALESCE(fd.real_program_nr, 0) = 3
    THEN 'Käsebrötchen / Snacks'
    WHEN COALESCE(fd.real_program_nr, 0) = 4
    THEN 'Baguette / Snacks'
    WHEN COALESCE(fd.real_program_nr, 0) = 5
    THEN 'Croissant'
    WHEN COALESCE(fd.real_program_nr, 0) = 6
    THEN 'NAT-Programm 6'
    WHEN COALESCE(fd.real_program_nr, 0) = 7
    THEN 'NAT-Programm 7'
    WHEN COALESCE(fd.real_program_nr, 0) = 8
    THEN 'Teiglings-Laugen-Brezel (Rohling)'
    WHEN COALESCE(fd.real_program_nr, 0) = 10
    THEN 'Nachtbacken'
    ELSE 'Unbekannt'
    END AS executed_baking_program_name
  FROM FULL_DATA AS fd
   INNER JOIN ldl_p_lew_bil_ac.v_dim_cal_day_1 AS CAL ON fd.event_date = CAL.cal_dt
   INNER JOIN ldl_p_lew_bil_ac.v_org_store_merge_1 AS STORE_VIEW ON fd.store_loc_sid = STORE_VIEW.loc_sid_store AND
     STORE_VIEW.aspect_id = 2
   LEFT JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH_VIEW ON STORE_VIEW.loc_sid_wh = WH_VIEW.loc_sid_wh AND WH_VIEW.dwh_actual_fg
      = 1);