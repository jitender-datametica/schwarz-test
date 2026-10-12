/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_storagebinfixbinasg
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_storagebinfixbinasg (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	strg_bin VARCHAR(18) COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA',
	strg_bin_assgn_type_flg BOOLEAN COMMENT 'Storage Bin Assignment Type - Technical name: ASTYPE_BIN - Component Type: /SCWM/DE_FIXBIN_ASTYPE_B_MLTPL',
	product_nr VARCHAR(40) COMMENT 'Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR',
	product_desc VARCHAR(40) COMMENT 'Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX',
	product_assgn_type VARCHAR(1) COMMENT 'Product Assignment Type - Technical name: ASTYPE_PRODUCT - Component Type: /SCWM/DE_FIXBIN_ASTYPE_P_MLTPL',
	party_entitled_dispose VARCHAR(10) COMMENT 'Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED',
	stock_in_fix_bin_flg BOOLEAN COMMENT 'Stock in Fixed Storage Bin - Technical name: STOCK - Component Type: /SCWM/DE_FIXBIN_STOCK_FULL',
	is_strg_bin_imprvbl VARCHAR(1) COMMENT 'Storage Bin Improvable - Technical name: OUTCON - Component Type: /SCWM/DE_OUTCON',
	strg_bin_imprvbl_change_dt DATE COMMENT 'Storage Bin Improvable Changed On - Technical name: DATOUT - Component Type: /SCWM/DE_DATOUT',
	strg_type VARCHAR(4) COMMENT 'Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP',
	strg_sec VARCHAR(4) COMMENT 'Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER',
	strg_bin_empty_flg BOOLEAN COMMENT 'Empty Storage Bin - Technical name: KZLER - Component Type: /SCWM/LAGP_KZLER',
	crtd_by VARCHAR(12) COMMENT 'Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR',
	crtd_on_dt DATE COMMENT 'Creation Date of a Fixed Storage Bin - Technical name: CREATED_DATE - Component Type: /SCWM/DE_FIXBIN_CREATED_DATE',
	crtd_at_tm TIME(0) COMMENT 'Fixed Storage Bin Creation Time - Technical name: CREATED_TIME - Component Type: /SCWM/DE_FIXBIN_CREATED_TIME',
	ps_area VARCHAR(15) COMMENT 'Production Supply Area(s) - Technical name: PSAS - Component Type: /SCWM/DE_PSAS',
	campaign_flg BOOLEAN COMMENT 'Campaign - Technical name: ZZ_CAMPAIGN - Component Type: ZEWM_E_E323_CAMPAIGN',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_nr, strg_bin, product_nr, dwh_valid_from)
	)
	COMMENT = 'Fix bin assignment. BI Reporting'
;
