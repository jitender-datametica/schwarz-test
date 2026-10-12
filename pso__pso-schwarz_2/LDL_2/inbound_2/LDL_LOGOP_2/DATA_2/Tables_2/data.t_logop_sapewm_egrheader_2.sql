/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_egrheader_2
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_egrheader_2 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_2 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_2 code. Original field name bic_zmlila',
	SOURCE_SYSTEM VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	doc_nr VARCHAR(35) COMMENT 'Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT',
	blocked_status VARCHAR(30) COMMENT 'Blocked (Overall Status_2) - Technical name: STATUS_BLOCKED_OVERALL - Component Type: /SCWM/SP_OVERALL_BLOCK_STATUS',
	doc_type VARCHAR(4) COMMENT 'Document Type - Technical name: DOCTYPE - Component Type: /SCDL/DL_DOCTYPE',
	doc_type_desc VARCHAR(40) COMMENT 'Document Type Description - Technical name: DOCTYPE_TXT - Component Type: /SCWM/SP_DOCTYPE_TXT',
	ship_from_nr VARCHAR(10) COMMENT 'Ship-from - Technical name: SHIP_FROM - Component Type: /SCWM/DE_SHIP_FROM',
	planned_dlv_dt DATE COMMENT 'Delivery Date (Planned) - Technical name: TDELIVERY_DATE - Component Type: /SCWM/SP_DELDATE',
	planned_dlv_tm TIME(0) COMMENT 'Delivery Time (Planned) - Technical name: TDELIVERY_TIME - Component Type: /SCWM/SP_DELTIME',
	crtd_on_dt DATE COMMENT 'Created On - Technical name: CREATED_ON - Component Type: /SCWM/SP_CREDAT',
	crtd_at_tm TIME(0) COMMENT 'Created At - Technical name: CREATED_AT - Component Type: /SCWM/SP_CRETIM',
	crtd_by VARCHAR(12) COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/SP_CREUSR',
	lia_nr VARCHAR(20) COMMENT 'LIA Number - Technical name: ZZ_EXREF - Component Type: ZEWM_E_EXREF',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	is_active_fg BOOLEAN NOT NULL COMMENT 'Flag indicating active record',
	PRIMARY KEY (wh_nr, doc_nr)
	)
	COMMENT = 'Expected Goods Receipt Header Data for BI Reporting'
;
