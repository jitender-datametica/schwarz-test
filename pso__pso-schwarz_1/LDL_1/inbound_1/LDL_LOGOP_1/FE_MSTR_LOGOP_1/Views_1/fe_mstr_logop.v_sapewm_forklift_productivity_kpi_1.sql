/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_sapewm_forklift_productivity_kpi_1
Description		|	SAP EWM Forklift - view with final KPIs for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_forklift_productivity_kpi_1(
	client_id COMMENT 'Client id (PK)',
	wh_id COMMENT 'Warehouse ID (PK)',
	wh_task_nr COMMENT 'Warehouse Task (PK)',
	conf_dt COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	conf_tm COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	conf_ts COMMENT 'Confirmation timestamp',
	src_hu COMMENT 'Source Handling Unit_1 - Technical name: VLENR - Component Type: /SCWM/LTAP_VLENR (PK)',
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
	exec_dur_sec COMMENT 'Execution Time with maximum of 15 min',
	travel_dur_sec COMMENT 'Travel Time with maximum of 20 min',
	dwh_created COMMENT 'Record created at',
	dwh_updated COMMENT 'Record updated at'
) COMMENT='SAP EWM forklift report forklift productivity - KPI view (based on v_sapewm_forklift_productivity_add_1)'
 AS
SELECT 
    client_id
    , wh_id
    , wh_task_nr
    , conf_dt
    , conf_tm
    , conf_ts
    , src_hu
    , dest_hu
    , src_hu_ep
	, src_hu_dd
	, src_hu_qp
	, src_hu_sg
	, src_hu_hg
	, src_hu_qg
	, dest_hu_ep
	, dest_hu_dd
	, dest_hu_qp
	, dest_hu_sg
	, dest_hu_hg
	, dest_hu_qg
    , wh_area
    , movement_type
    , rsrc_type
    , hu_size
    , hu_type
    , QUEUE
    , start_time 
	, end_time
	, prev_start_ts
	, prev_end_ts
	, exec_time
	, travel_dur
	, exec_dur_sec
	, travel_dur_sec
	, dwh_created
    , dwh_updated
FROM fe_mstr_logop.v_sapewm_forklift_productivity_add_1;