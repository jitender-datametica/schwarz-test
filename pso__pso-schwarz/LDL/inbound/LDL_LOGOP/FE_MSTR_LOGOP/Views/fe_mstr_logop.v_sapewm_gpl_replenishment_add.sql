/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_replenishment_add
Description		|	SAP EWM Gruppenleiter Dahsboard Replenishment - view with additional columns
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_gpl_replenishment_add(
	client_id COMMENT 'Client id (PK)',
	wh_id COMMENT 'Warehouse ID (PK)',
	wh_task_nr COMMENT 'Warehouse Task (PK)',
	conf_by COMMENT 'Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY',
	conf_dt COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	conf_ts COMMENT 'Confirmation timestamp',
	src_hu COMMENT 'Source Handling Unit - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	dest_hu COMMENT 'Destination Handling Unit. Source column name: NLENR',
	rsrc COMMENT 'Resource',
	rsrc_type COMMENT 'Resource type',
	wh_area COMMENT 'Warehouse area',
	movement_type COMMENT 'Movement type',
	hu_size COMMENT 'Calculated amount of handling units after successful end of task',
	hu_type COMMENT 'Handling Unit Type. Source column name: LETYP',
	QUEUE COMMENT 'Queue. Source column name: QUEUE',
	area COMMENT 'Warehouse area. Made to the exact specifications from Repl. Functional Concept.',
	PRIORITY COMMENT 'Replenishment Priority',
	STAT COMMENT 'Status of Warehouse task (Closed/Waiting/Open)',
	start_time COMMENT 'Timestamp of task end or unload from resource',
	end_time COMMENT 'Timestamp of task start or load on resource',
	prev_start_ts COMMENT 'Start timestamp from previous task group',
	prev_end_ts COMMENT 'Start timestamp from previous task group',
	exec_time COMMENT 'Execution time',
	travel_dur COMMENT 'Travel ime',
	exec_dur_sec COMMENT 'Execution Time (Seconds) with maximum of 15 min',
	travel_dur_sec COMMENT 'Travel Time (Seconds) with maximum of 20 min',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at'
) COMMENT='SAP EWM Replenishment view (based on v_sapewm_whtask)'
 AS
WITH taskqueueset AS (
SELECT
        t.client_id 
        ,t.wh_id 
        ,t.wh_task_nr 
        ,t.wh_task_item
        ,t.wh_task_stat
        ,t.conf_by
        ,IFF(t.conf_dt IS NULL, GETDATE()::DATE, conf_dt) AS conf_dt
        ,t.conf_tm
        ,t.src_rsrc
        ,t.src_hu
        ,t.dest_hu
        ,t.hu_type
        ,t.QUEUE
        ,t.dest_strg_bin
        ,t.act_area
        ,q.wh_area
        ,q.movement_type
        ,t.rep_sort
        ,COALESCE(t.dest_rsrc, t.src_rsrc) AS rsrc -- destination resource is the resource at start of task, source resource is the resource at end of task
        ,DECODE(LEFT(rsrc, 1), '1', 'FAMO', '2', 'FORK', '3', 'FAMO', '', 'No Resource', 'Unknown') AS rsrc_type 
        ,LEFT(t.hu_type, 2) AS HU_TYPE_EPE
        ,DECODE(LEFT(t.hu_type, 2), 
        	'EP', TO_NUMBER(1,10,5), 
        	'DD', TO_NUMBER(0.5,10,5), 
        	'QP', TO_NUMBER(0.25,10,5), 
        	'IP', TO_NUMBER(1,10,5), 
        	'AE', TO_NUMBER(1,10,5), 
        	'SG', TO_NUMBER (1,10,5),
        	'HG', TO_NUMBER (0.5, 10,5),
        	'QG', TO_NUMBER (0.25, 10,5)
        	,TO_NUMBER(0,10,5)) AS hu_size -- amount of handling units in europallet-equivalent
        ,t.dwh_created
        ,t.dwh_updated
        ,IFF(t.src_strg_bin IS NOT NULL AND t.dest_rsrc IS NOT NULL,TIMESTAMPFROMPARTS(t.conf_dt, t.conf_tm),NULL) AS start_time
        ,IFF(t.dest_strg_bin IS NOT NULL AND t.src_rsrc IS NOT NULL,TIMESTAMPFROMPARTS(t.conf_dt, t.conf_tm),NULL) AS end_time
    FROM fe_mstr_logop.v_sapewm_whtask t -- Primary key (client_id, wh_id, wh_task_nr, wh_task_item)
        JOIN "DATA".t_ref_queue q -- Primary key (queue) but this columns is already covered in the PK of mv_sapewm_whtask
            ON t.QUEUE = q.QUEUE
    WHERE (t.wh_task_stat IS NULL OR t.wh_task_stat = 'C') -- filtering for OPEN tasks only
        AND (NOT STARTSWITH(IFNULL(t.QUEUE, 'dummy'), 'OUT') OR (STARTSWITH(IFNULL(t.QUEUE, 'dummy'), 'OUT') AND t.src_hu IS NOT NULL))
        AND (t.src_rsrc IS NOT NULL OR t.dest_rsrc IS NOT NULL)
        AND t.act_type IN ('REPL')  
        AND t.wh_proc_type LIKE 'Z%' -- filtering for real replenishment WTs
        --AND CONF_DT > DATEADD(MONTH, -2, GETDATE()) -- results from one month only
), timecalc AS(
SELECT 
	client_id
    ,wh_id
    ,wh_task_nr
    ,CASE 
        WHEN wh_task_stat IS NULL THEN 0 -- OPEN
        WHEN wh_task_stat = 'C' THEN 1 -- COMPLETED
     END AS STAT
    ,conf_by
    ,conf_dt
    ,conf_tm
    ,src_hu
    ,rsrc
    ,rsrc_type
    ,wh_area
    ,movement_type
    ,hu_size
    ,hu_type
    ,hu_type_epe
    ,dest_hu
    ,QUEUE
    ,start_time
    ,end_time
	,IFF(LAG(start_time) OVER (PARTITION BY client_id, wh_id, conf_by, conf_dt, rsrc ORDER BY conf_tm, wh_task_nr) IS NULL AND start_time  IS NOT NULL ,start_time, NULL) AS first_start_ts -- earliest time stamp
    ,IFF(LEAD(end_time) OVER (PARTITION BY client_id, wh_id, conf_by, conf_dt, rsrc ORDER BY conf_tm, wh_task_nr) IS NULL AND end_time IS NOT NULL, end_time,NULL) AS last_end_ts -- latest time stamp
    ,CASE 
	    WHEN QUEUE IN ('REPL_AMB', 'REPL_NF', 'REPL_S_AMB', 'REPL1_AMB', 'REPL1_NF', 'REPL2_AMB', 'REPL2_NF', 'REPL3_AMB', 'REPL3_NF') THEN 'Ambient'
	    WHEN QUEUE IN ('OB_OUTFEED', 'REPL_BULK', 'REPL2_BULK','REPL2_BULK', 'REPL3_BULK') THEN 'Bulk'
	    WHEN QUEUE IN ('REPL_CHL', 'REPL2_CHL', 'REPL3_CHL') THEN 'Chiller'
	    WHEN QUEUE IN ('REPL_FV') THEN 'Fruit and Veg'
	    WHEN QUEUE IN ('REPL_MPF', 'REPL2_MPF', 'REPL3_MPF') THEN 'MPF'
	    WHEN QUEUE IN ('REPL_FRZ', 'REPL2_FRZ', 'REPL3_FRZ') THEN 'Freezer'
	    ELSE 'Unknown'
     END AS Area
    ,CASE 
        WHEN rep_sort IN (99) THEN 4
        WHEN rep_sort IN (50) THEN 3
        WHEN rep_sort IN (30,25,15) THEN 2
        WHEN rep_sort IN (5,20) THEN 1
    END AS priority 
    ,dwh_created
    ,dwh_updated
FROM taskqueueset)
SELECT
    client_id
    ,wh_id
    ,wh_task_nr
    ,conf_by
    ,conf_dt
    ,conf_tm
    ,TIMESTAMPFROMPARTS(conf_dt, conf_tm) AS conf_ts
    ,src_hu
    ,dest_hu
    ,rsrc
    ,rsrc_type
    ,wh_area
    ,movement_type
    ,hu_size
    ,hu_type
    ,QUEUE
    ,Area
    ,priority
    ,STAT
	,start_time
	,end_time
	,IFF(last_end_ts IS NOT NULL, LAG(first_start_ts) IGNORE NULLS OVER (PARTITION BY client_id, wh_id, conf_by, conf_dt, rsrc ORDER BY conf_tm, wh_task_nr), NULL) AS prev_start_ts -- start from previous group per country, wh, employee, day and wh area
    ,IFF(first_start_ts IS NOT NULL, LAG(last_end_ts) IGNORE NULLS OVER (PARTITION BY client_id, wh_id, conf_by, conf_dt, rsrc ORDER BY conf_tm, wh_task_nr), NULL) AS prev_end_ts -- end from previous group per country, wh, employee, day and wh area
    ,TIMESTAMPDIFF(SECOND, prev_start_ts, last_end_ts) AS exec_time -- execution time
    ,TIMESTAMPDIFF(SECOND, prev_end_ts, first_start_ts) AS travel_dur -- travel time
    ,CASE WHEN exec_time > 900 THEN 900 ELSE exec_time END AS exec_dur_sec -- execution time with maximum of 15 min 
    ,CASE WHEN travel_dur BETWEEN 0 AND 1200 THEN travel_dur END AS travel_dur_sec -- execution time with maximum of 20 min
    ,dwh_created
    ,dwh_updated
FROM timecalc;