/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_sapewm_gpl_replenishment_kpi_2
Description		|	SAP EWM Gruppenleiter Dahsboard Replenishment - KPI View
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_gpl_replenishment_kpi_2(
	client_id COMMENT 'Client id (PK)',
	wh_id COMMENT 'Warehouse ID (PK)',
	wh_task_nr COMMENT 'Warehouse Task (PK)',
	conf_by COMMENT 'Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY',
	conf_dt COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	conf_ts COMMENT 'Confirmation timestamp',
	src_hu COMMENT 'Source Handling Unit_2 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR',
	dest_hu COMMENT 'Destination Handling Unit. Source column name: NLENR',
	rsrc COMMENT 'Resource',
	rsrc_type COMMENT 'Resource type',
	wh_area COMMENT 'Warehouse area',
	movement_type COMMENT 'Movement type',
	hu_size COMMENT 'Calculated amount of handling units after successful end of task',
	hu_type COMMENT 'Handling Unit_2 Type. Source column name: LETYP',
	QUEUE COMMENT 'Queue. Source column name: QUEUE',
	area COMMENT 'Warehouse area. Made to the exact specifications from Repl. Functional Concept.',
	PRIORITY COMMENT 'Replenishment Priority',
	STAT COMMENT 'Status_2 of Warehouse task (Closed/Waiting/Open)',
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
) COMMENT='SAP EWM forklift report forklift productivity - view with additional columns (based on v_sapewm_whtask_2 and mv_ref_queue_2)'
 AS
 SELECT
    client_id
    ,wh_id
    ,wh_task_nr
    ,conf_by
    ,conf_dt
    ,conf_tm
    ,conf_ts
    ,src_hu
    ,dest_hu
    ,rsrc
    ,rsrc_type
    ,wh_area
    ,movement_type
    ,hu_size
    ,hu_type
    ,QUEUE
    ,area
    ,priority
    ,STAT
	,start_time
	,end_time
	,prev_start_ts
    ,prev_end_ts
    ,exec_time
    ,travel_dur
    ,exec_dur_sec
    ,travel_dur_sec
    ,dwh_created
    ,dwh_updated
FROM fe_mstr_logop.v_sapewm_gpl_replenishment_add_2;