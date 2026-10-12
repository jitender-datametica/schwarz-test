/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated list of bakings events count with the granularity of country_2/store/day/timeperiod. 
#
#-----------------------------------------------------------------------------
# History:
#  1.0     28.11.2025      Alena Gruner             Initial Version
#  1.1     01.12.2025      Aparna Rayanki             switching to mart table T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_2
#
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_BAKEOFF_OVEN_CHAMBER_BP_BENDED_COUNT_30_2(
    event_date
    ,cy_week
    ,day_of_week
    ,time_period_30_id    
    ,time_period_30_name 
    ,baking_program_id
    ,loc_sid_store_move_to
    ,client_id
    ,loc_sid_wh
    ,wh_id
    ,orig_store_nr
    ,last_event_time
    ,event_count
    ,executed_baking_program_nr
	,executed_baking_program_name
) AS

-- 1: 
WITH aggregated_facts AS (
    SELECT DISTINCT
        e.bakeoff_oven_chamber_event_dt AS event_date
        ,hist.store_loc_sid
        ,hist.client_id 
        ,tp.time_period_30_id
        ,tp.time_period_30_name                 
        ,e.bakeoff_oven_chamber_event_type_cd AS baking_program_id 
        ,e.bakeoff_oven_chamber_baking_program_id AS real_program_nr
        ,MAX(e.bakeoff_oven_chamber_event_tm) AS last_event_time
        ,COUNT(*) AS event_count
    FROM
        P_LEW_CORE.T_BAKEOFF_OVEN_CHAMBER_EVENT_2 e
    JOIN
        P_LEW_MART_LEAD.T_REF_BAKEOFF_OVEN_CHAMBER_STORE_HIST_2 hist
        ON e.bakeoff_oven_chamber_sid = hist.bakeoff_oven_chamber_sid
        AND e.bakeoff_oven_chamber_event_dt BETWEEN hist.valid_from AND hist.valid_to
    JOIN
        P_LEW_MART_LEAD.V_REF_BAKEOFF_OVEN_CHAMBER_TIME_PERIODS_30MIN_2 tp
        ON e.bakeoff_oven_chamber_event_tm BETWEEN tp.period_start_time AND tp.period_end_time        
    WHERE
        e.bakeoff_oven_chamber_event_type_cd = 'bakingStarted'
        AND e.bakeoff_oven_chamber_event_dt >= DATEADD(DAY, -65, CURRENT_DATE())
		AND hist.active_fg=1
    GROUP BY
        e.bakeoff_oven_chamber_event_dt
        ,hist.store_loc_sid
        ,hist.client_id
        ,tp.time_period_30_id
        ,tp.time_period_30_name                 
        ,e.bakeoff_oven_chamber_event_type_cd
        ,e.bakeoff_oven_chamber_baking_program_id 
)

-- 2:
,active_context AS (
    SELECT DISTINCT
        store_loc_sid
        ,client_id
        ,event_date
    FROM aggregated_facts
)

-- 3: 
,smart_matrix AS (
    SELECT DISTINCT
        ac.event_date
        ,ac.store_loc_sid
        ,ac.client_id
        ,tp.time_period_30_id
        ,tp.time_period_30_name        
    FROM
        active_context ac
    CROSS JOIN
        P_LEW_MART_LEAD.V_REF_BAKEOFF_OVEN_CHAMBER_TIME_PERIODS_30MIN_2 tp
)

-- 4: 
,full_data AS (
    SELECT DISTINCT 
        m.event_date
        ,m.store_loc_sid
        ,m.client_id
        ,m.time_period_30_id
        ,m.time_period_30_name
        ,f.baking_program_id
        ,f.last_event_time
        ,COALESCE(f.event_count, 0) AS event_count
        ,f.real_program_nr 
    FROM
        smart_matrix m
    LEFT JOIN
        aggregated_facts f
        ON m.store_loc_sid = f.store_loc_sid
        AND m.event_date = f.event_date
        AND m.time_period_30_id = f.time_period_30_id
)

-- Fin
SELECT DISTINCT
    fd.event_date
    ,cal.cy_week
    ,cal.day_of_week
    ,fd.time_period_30_id
    ,fd.time_period_30_name
    ,COALESCE(fd.baking_program_id, 'bakingStarted') AS baking_program_id
    ,store_view.loc_sid_store_move_to
    ,fd.client_id
    ,store_view.loc_sid_wh
    ,wh_view.src_wh_id AS wh_id
    ,store_view.src_orig_store_nr AS orig_store_nr
    ,fd.last_event_time
    ,fd.event_count
    ,COALESCE(fd.real_program_nr, 0) AS executed_baking_program_nr
	,CASE COALESCE(fd.real_program_nr, 0)
        WHEN 1 THEN 'Brot / Süßteilchen'
        WHEN 2 THEN 'Brötchen'
        WHEN 3 THEN 'Käsebrötchen / Snacks'
        WHEN 4 THEN 'Baguette / Snacks'
        WHEN 5 THEN 'Croissant'
        WHEN 6 THEN 'NAT-Programm 6'
        WHEN 7 THEN 'NAT-Programm 7'
        WHEN 8 THEN 'Teiglings-Laugen-Brezel (Rohling)'
        WHEN 10 THEN 'Nachtbacken'
        ELSE 'Unbekannt'
    END AS executed_baking_program_name
    
FROM
    full_data fd
JOIN P_LEW_BIL_AC.V_DIM_CAL_DAY_2 cal
    ON fd.event_date = cal.cal_dt
JOIN P_LEW_BIL_AC.V_ORG_STORE_MERGE_2 store_view
    ON fd.store_loc_sid = store_view.loc_sid_store
    AND store_view.aspect_id = 2
LEFT JOIN P_LEW_BIL_AC.V_WAREHOUSE_2 wh_view
    ON store_view.loc_sid_wh = wh_view.loc_sid_wh
    AND wh_view.dwh_actual_fg = 1;