/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	data.t_logop_sapewm_picbrk
Description		|	SAP EWM Picking Break
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_picbrk (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	crtd_by VARCHAR(12) COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATED_BY',
	start_dt DATE COMMENT 'Start Date - Technical name: START_DATE - Component Type: /SCWM/DE_STARTED_DATE',
	start_tm TIME(0) COMMENT 'Start Time - Technical name: START_TIME - Component Type: /SCWM/DE_STARTED_TIME',
	end_dt DATE COMMENT 'End Date - Technical name: END_DATE - Component Type: /SCWM/DE_ENDED_DATE',
	end_tm TIME(0) COMMENT 'End Time - Technical name: END_TIME - Component Type: /SCWM/DE_ENDED_TIME',
	who_nr NUMBER(38,0) COMMENT 'Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	PRIMARY KEY (wh_nr, crtd_by, start_dt, start_tm, who_nr)
) 
COMMENT='Picking Break in RF for the BI Reporting'
;