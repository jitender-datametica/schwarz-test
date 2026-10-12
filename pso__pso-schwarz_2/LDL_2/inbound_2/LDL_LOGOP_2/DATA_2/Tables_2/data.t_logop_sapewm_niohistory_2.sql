/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_niohistory_2
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_niohistory_2 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_2 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_2 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	hu_ident VARCHAR(20) COMMENT 'Handling Unit_2 Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT',
	log_seq NUMBER(38,0) COMMENT 'Log Sequence - Technical name: LOG_SEQ - Component Type: /SCWM/DE_LOG_SEQ',
	com_point VARCHAR(18) COMMENT 'Communication_2 Point for Conveyor Technique - Technical name: CP - Component Type: /SCWM/DE_MFSCP',
	hu_status VARCHAR(5) COMMENT 'Object Status_2 - Technical name: HU_STATUS - Component Type: CRM_J_STATUS',
	crtd_on_dt DATE COMMENT 'Created On - Technical name: CREATED_ON - Component Type: /SCWM/SP_CREDAT',
	crtd_at_tm TIME(0) COMMENT 'Created At - Technical name: CREATED_AT - Component Type: /SCWM/SP_CRETIM',
	hu_status_short VARCHAR(4) COMMENT 'Individual status_2 of an object (short form) - Technical name: HU_STATUS_SHORT - Component Type: J_TXT04',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	PRIMARY KEY (wh_nr, log_seq, hu_ident)
	)
	COMMENT = 'Structure - NIO History - BI Reporting'
;
