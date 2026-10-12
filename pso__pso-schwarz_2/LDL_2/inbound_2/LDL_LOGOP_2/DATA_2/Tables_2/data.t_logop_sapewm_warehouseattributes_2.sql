/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_warehouseattributes_2
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_warehouseattributes_2 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_2 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_2 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	product_nr VARCHAR(40) COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR',
	product_desc VARCHAR(40) COMMENT 'Product Description - Technical name: MAKTX - Component Type: /SCMB/MDL_PRODUCT_TEXT',
	party_entitled_dispose VARCHAR(10) COMMENT 'Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED',
	buom VARCHAR(3) COMMENT 'Base Unit_2 of Measure - Technical name: MEINS - Component Type: /SAPAPO/MEINS',
	mat_grp VARCHAR(9) COMMENT 'Material Group - Technical name: MATKL - Component Type: /SAPAPO/MATKL',
	transp_grp VARCHAR(4) COMMENT 'Transportation Group - Technical name: TRAGR - Component Type: /SAPAPO/TRAGR',
	strg_sec VARCHAR(4) COMMENT 'Storage Section Indicator - Technical name: LGBKZ - Component Type: /SCWM/LVS_LGBKZ',
	paci VARCHAR(4) COMMENT 'Putaway Control - Technical name: PUT_STRA - Component Type: /SCWM/DE_PUT_STRA',
	srci VARCHAR(4) COMMENT 'Stock Removal Control - Technical name: REM_STRA - Component Type: /SCWM/DE_REM_STRA',
	staging_area VARCHAR(4) COMMENT 'Staging Area/Door Determination Group - Technical name: DRDETGR - Component Type: /SCWM/DE_DRDETGR',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_nr, product_nr, dwh_valid_from)
	)
	COMMENT = 'Structure - WH Attributes - BI reporting'
;
