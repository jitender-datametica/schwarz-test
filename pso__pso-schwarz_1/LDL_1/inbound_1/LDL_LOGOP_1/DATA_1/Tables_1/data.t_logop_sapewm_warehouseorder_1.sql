/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_warehouseorder_1
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_warehouseorder_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	who_nr NUMBER(38,0) COMMENT 'Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO',
	QUEUE VARCHAR(10) COMMENT 'Queue - Technical name: QUEUE - Component Type: /SCWM/DE_QUEUE',
	wave NUMBER(38,0) COMMENT 'Wave - Technical name: WAVE - Component Type: /SCWM/DE_WAVE',
	who_status VARCHAR(1) COMMENT 'Warehouse Order Status_1 - Technical name: STATUS_1 - Component Type: /SCWM/DE_WHOSTAT',
	who_activity_area VARCHAR(4) COMMENT 'Warehouse Order Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_WHOAA',
	crtd_by VARCHAR(12) COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR',
	crtd_on_dt DATE COMMENT 'Created On - Technical name: CREATED_DATE - Component Type: /SCWM/DE_CREATED_DATE',
	crtd_at_tm TIME(0) COMMENT 'Created At - Technical name: CREATED_TIME - Component Type: /SCWM/DE_CREATED_TIME',
	processor VARCHAR(12) COMMENT 'Processor - Technical name: PROCESSOR - Component Type: /SCWM/DE_PROCESSOR',
	rsrc VARCHAR(18) COMMENT 'Resource (Means of Transportation or User) - Technical name: RSRC - Component Type: /SCWM/DE_RSRC',
	start_dt DATE COMMENT 'Start Date - Technical name: STARTED_DATE - Component Type: /SCWM/DE_STARTED_DATE',
	start_tm TIME(0) COMMENT 'Start Time - Technical name: STARTED_TIME - Component Type: /SCWM/DE_STARTED_TIME',
	last_start_dt DATE COMMENT 'Latest Start Date - Technical name: LS_DATE - Component Type: /SCWM/DE_LS_DATE',
	last_start_tm TIME(0) COMMENT 'Latest Start Time - Technical name: LS_TIME - Component Type: /SCWM/DE_LS_TIME',
	changed_by VARCHAR(12) COMMENT 'Changed By - Technical name: CHANGED_BY - Component Type: /SCWM/DE_EDITOR',
	changed_on_dt DATE COMMENT 'Changed On - Technical name: CHANGED_DATE - Component Type: /SCWM/DE_CHANGED_DATE',
	changed_at_tm TIME(0) COMMENT 'Changed At - Technical name: CHANGED_TIME - Component Type: /SCWM/DE_CHANGED_TIME',
	conf_by VARCHAR(12) COMMENT 'Confirmed by - Technical name: CONFIRMED_BY - Component Type: /SCWM/DE_CONFIRMEDBY',
	conf_dt DATE COMMENT 'Confirmation Date - Technical name: CONFIRMED_DATE - Component Type: /SCWM/DE_CONFIRMED_DATE',
	conf_tm TIME(0) COMMENT 'Confirmation Time - Technical name: CONFIRMED_TIME - Component Type: /SCWM/DE_CONFIRMED_TIME',
	exec_tm_plan NUMBER(38,3) COMMENT 'Planned Execution Time of Warehouse Order - Technical name: PLANDURA - Component Type: /SCWM/DE_WHOPLANDURA',
	exec_tm_act NUMBER(38,3) COMMENT 'Actual Execution Time of Warehouse Order - Technical name: ACTDURA - Component Type: /SCWM/DE_WHOACTDURA',
	who_time_unit VARCHAR(3) COMMENT 'Warehouse Order: Time Unit_1 - Technical name: UNIT_T - Component Type: /SCWM/DE_WHOUNITT',
	nr_wt NUMBER(38,0) COMMENT 'Number of WTs - Technical name: COUNT_TO - Component Type: /SCWM/DE_NO_TO',
	who_contains_pi_doc BOOLEAN COMMENT 'WO Contains Physical Inventory Document - Technical name: FLGINV - Component Type: /SCWM/DE_FLGINV',
	who_contains_wt BOOLEAN COMMENT 'Warehouse Order Contains Warehouse Task - Technical name: FLGTO - Component Type: /SCWM/DE_FLGTO',
	total_processing_time NUMBER(38,3) COMMENT 'Total Processing Time - Technical name: SUM_REACHTIME - Component Type: /SCWM/DE_REACHTT_SUM',
	time_unit VARCHAR(3) COMMENT 'Time Unit_1 - Technical name: UNIT_RT - Component Type: /SCWM/LVS_ZEIEI',
	planned_compl_dt DATE COMMENT 'Planned Completion Date - Technical name: PICK_COMP_DATE - Component Type: /SCWM/DE_TOCOMPL_DATE',
	planned_compl_tm TIME(0) COMMENT 'Planned Completion Time - Technical name: PICK_COMP_TIME - Component Type: /SCWM/DE_TOCOMPL_TIME',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	PRIMARY KEY (wh_nr, who_nr)
	)
	COMMENT = 'Warehouse orders for BI Reporting'
;
