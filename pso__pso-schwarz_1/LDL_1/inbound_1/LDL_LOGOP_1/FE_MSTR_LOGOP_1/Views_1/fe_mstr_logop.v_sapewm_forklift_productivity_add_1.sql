/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_forklift_productivity_add_1
Description		|	SAP EWM Forklift - view with additional columns 
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_forklift_productivity_add_1(
	client_id COMMENT 'Client id (PK)',
	wh_id COMMENT 'Warehouse ID (PK)',
	wh_task_nr COMMENT 'Warehouse Task (PK)',
	conf_by COMMENT 'Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY',
	conf_dt COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	conf_ts COMMENT 'Confirmation timestamp',
	src_hu COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	rsrc COMMENT 'Resource',
	dest_hu COMMENT 'Destination Handling Unit. Source column name: NLENR',
	src_hu_ep COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	src_hu_dd COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	src_hu_qp COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	src_hu_sg COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	src_hu_hg COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	src_hu_qg COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	dest_hu_ep COMMENT 'Destination Handling Unit_1',
	dest_hu_dd COMMENT 'Destination Handling Unit_1',
	dest_hu_qp COMMENT 'Destination Handling Unit_1',
	dest_hu_sg COMMENT 'Destination Handling Unit_1',
	dest_hu_hg COMMENT 'Destination Handling Unit_1',
	dest_hu_qg COMMENT 'Destination Handling Unit_1',
	wh_area COMMENT 'Warehouse area',
	movement_type COMMENT 'Movement type',
	rsrc_type COMMENT 'Resource type',
	hu_size COMMENT 'Calculated amount of handling units after successful end of task',
	hu_type COMMENT 'Handling Unit_1 Type. Source column name: LETYP',
	QUEUE COMMENT 'Queue. Source column name: QUEUE',
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
) COMMENT='SAP EWM forklift report forklift productivity - view with additional columns (based on v_sapewm_whtask_1 and mv_ref_queue_1)'
AS
WITH taskqueueset AS (    
SELECT
        t.client_id 
        ,t.wh_id 
        ,t.wh_task_nr 
        ,t.wh_task_item
        ,t.conf_by
        ,t.conf_dt
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
    FROM fe_mstr_logop.v_sapewm_whtask_1 t -- Primary key (client_id, wh_id, wh_task_nr, wh_task_item)
        JOIN "DATA".T_REF_QUEUE_1 q -- Primary key (queue) but this columns is already covered in the PK of mv_sapewm_whtask_1
            ON t.QUEUE = q.QUEUE
    WHERE t.wh_task_stat IN ('C') -- A canceled, C confirmed
        AND (NOT STARTSWITH(IFNULL(t.QUEUE, 'dummy_1'), 'OUT') OR (STARTSWITH(IFNULL(t.QUEUE, 'dummy_1'), 'OUT') AND t.src_hu IS NOT NULL))
        AND (t.src_rsrc IS NOT NULL OR t.dest_rsrc IS NOT NULL)
        AND t.act_type IN ('INTL', 'PICK', 'PTWY', 'REPL') -- internal movement, picking, put away, replenishment        
), timecalc AS(
SELECT 
	client_id
    ,wh_id
    ,wh_task_nr
    ,conf_by
    ,conf_dt
    ,conf_tm
    ,src_hu
    ,rsrc
    ,wh_area
    ,rsrc_type
    ,movement_type
    ,hu_size
    ,hu_type
    ,QUEUE
    ,hu_type_epe
    ,start_time
    ,end_time
	,IFF(LAG(start_time) OVER (PARTITION BY client_id, wh_id, conf_by, conf_dt, rsrc ORDER BY conf_tm, wh_task_nr) IS NULL AND start_time  IS NOT NULL ,start_time, NULL) AS first_start_ts -- earliest time stamp
    ,IFF(LEAD(end_time) OVER (PARTITION BY client_id, wh_id, conf_by, conf_dt, rsrc ORDER BY conf_tm, wh_task_nr) IS NULL AND end_time IS NOT NULL, end_time,NULL) AS last_end_ts -- latest time stamp
    ,dest_hu
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
    ,CASE WHEN hu_type_epe = 'EP' AND movement_type != 'Full Pallet Pick' THEN src_hu END AS src_hu_ep
    ,CASE WHEN hu_type_epe = 'DD' AND movement_type != 'Full Pallet Pick' THEN src_hu END AS src_hu_dd
    ,CASE WHEN hu_type_epe = 'QP' AND movement_type != 'Full Pallet Pick' THEN src_hu END AS src_hu_qp
    ,CASE WHEN hu_type_epe = 'SG' AND movement_type != 'Full Pallet Pick' THEN src_hu END AS src_hu_sg
    ,CASE WHEN hu_type_epe = 'HG' AND movement_type != 'Full Pallet Pick' THEN src_hu END AS src_hu_hg
    ,CASE WHEN hu_type_epe = 'QG' AND movement_type != 'Full Pallet Pick' THEN src_hu END AS src_hu_qg
    ,CASE WHEN hu_type_epe = 'EP' AND movement_type = 'Full Pallet Pick' THEN dest_hu END AS dest_hu_ep
    ,CASE WHEN hu_type_epe = 'DD' AND movement_type = 'Full Pallet Pick' THEN dest_hu END AS dest_hu_dd
    ,CASE WHEN hu_type_epe = 'QP' AND movement_type = 'Full Pallet Pick' THEN dest_hu END AS dest_hu_qp
    ,CASE WHEN hu_type_epe = 'SG' AND movement_type = 'Full Pallet Pick' THEN dest_hu END AS dest_hu_sg
    ,CASE WHEN hu_type_epe = 'HG' AND movement_type = 'Full Pallet Pick' THEN dest_hu END AS dest_hu_hg
    ,CASE WHEN hu_type_epe = 'QG' AND movement_type = 'Full Pallet Pick' THEN dest_hu END AS dest_hu_qg
    ,wh_area
    ,movement_type
    ,rsrc_type
    ,hu_size
    ,hu_type
    ,QUEUE
	,start_time
	,end_time
	,IFF(last_end_ts IS NOT NULL, LAG(first_start_ts) IGNORE NULLS OVER (PARTITION BY client_id, wh_id, conf_by, conf_dt, rsrc ORDER BY conf_tm, wh_task_nr), NULL) AS prev_start_ts -- start from previous group per country_1, wh, employee_1, day and wh area
    ,IFF(first_start_ts IS NOT NULL, LAG(last_end_ts) IGNORE NULLS OVER (PARTITION BY client_id, wh_id, conf_by, conf_dt, rsrc ORDER BY conf_tm, wh_task_nr), NULL) AS prev_end_ts -- end from previous group per country_1, wh, employee_1, day and wh area
    ,TIMESTAMPDIFF(SECOND, prev_start_ts, last_end_ts) AS exec_time -- execution time
    ,TIMESTAMPDIFF(SECOND, prev_end_ts, first_start_ts) AS travel_dur -- travel time
    ,CASE WHEN exec_time > 900 THEN 900 ELSE exec_time END AS exec_dur_sec -- execution time with maximum of 15 min 
    ,CASE WHEN travel_dur BETWEEN 0 AND 1200 THEN travel_dur END AS travel_dur_sec -- execution time with maximum of 20 min 
    ,dwh_created
    ,dwh_updated
FROM timecalc;