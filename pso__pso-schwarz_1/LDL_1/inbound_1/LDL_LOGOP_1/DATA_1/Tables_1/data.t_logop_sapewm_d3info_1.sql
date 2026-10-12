/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_d3info_1
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_d3info_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	freight_unit_id VARCHAR(20) COMMENT 'Freight Unit_1 ID - Technical name: FU_ID - Component Type: ZEWM_E_FUID',
	pshu_id VARCHAR(20) COMMENT 'Handling Unit_1 Identification - Technical name: PSHUIDENT - Component Type: /SCWM/DE_HUIDENT',
	hu_id VARCHAR(20) COMMENT 'Handling Unit_1 Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT',
	tu_nr VARCHAR(18) COMMENT 'Internal Number of Transportation Unit_1 - Technical name: TU_NUM - Component Type: /SCWM/DE_TU_NUM',
	activity_area VARCHAR(4) COMMENT 'Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_AAREA',
	sub_activity_area VARCHAR(4) COMMENT 'cartonization: Sub Activity Area - Technical name: AAREA_SUB - Component Type: ZEWM_E_CAP_SUB_AAREA',
	bus_partner_nr VARCHAR(10) COMMENT 'Business Partner Number - Technical name: STORE - Component Type: /SCDL/DL_PARTYNO',
	wave NUMBER(38,0) COMMENT 'Wave - Technical name: WAVE - Component Type: /SCWM/DE_WAVE',
	guid_pshu_id VARCHAR(50) COMMENT 'Unique Internal Identification of a Handling Unit_1 - Technical name: GUID_PSHU - Component Type: /SCWM/GUID_HU',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at'
	)
	COMMENT = 'TOMS Interface - D3 Data for BI Reporting'
;
