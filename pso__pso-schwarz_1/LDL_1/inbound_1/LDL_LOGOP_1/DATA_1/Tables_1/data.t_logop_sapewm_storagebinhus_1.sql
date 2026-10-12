/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_storagebinhus_1
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_storagebinhus_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	hu_ident VARCHAR(20) COMMENT 'Handling Unit_1 Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT',
	activity_area VARCHAR(4) COMMENT 'Activity Area - Technical name: ZZ_AAREA - Component Type: /SCWM/DE_AAREA',
	sub_activity_area VARCHAR(4) COMMENT 'cartonization: Sub Activity Area - Technical name: ZZCAP_SUB_AAREA - Component Type: ZEWM_E_CAP_SUB_AAREA',
	hu_type VARCHAR(4) COMMENT 'Handling Unit_1 Type - Technical name: LETYP - Component Type: /SCWM/DE_HUTYP',
	zz_hu_type VARCHAR(4) COMMENT 'Handling Unit_1 Type - Technical name: ZZ_HUTYP_ORG - Component Type: /SCWM/DE_HUTYP',
	crtd_by VARCHAR(12) COMMENT 'User Name - Technical name: CREATED_BY - Component Type: UNAME',
	crtd_on_dt DATE COMMENT 'Created On - Technical name: CREATED_DATE - Component Type: /SCWM/DE_CREATED_DATE',
	crtd_at_tm TIME(0) COMMENT 'Created At - Technical name: CREATED_TIME - Component Type: /SCWM/DE_CREATED_TIME',
	changed_on_dt DATE COMMENT 'Changed On - Technical name: CHANGED_DATE - Component Type: /SCWM/DE_CHANGED_DATE',
	changed_at_tm TIME(0) COMMENT 'Changed At - Technical name: CHANGED_TIME - Component Type: /SCWM/DE_CHANGED_TIME',
	hu_weight NUMBER(38,3) COMMENT 'Total Weight of Handling Unit_1 - Technical name: G_WEIGHT - Component Type: /SCWM/BRGEW',
	weight_unit VARCHAR(3) COMMENT 'Weight Unit_1 - Technical name: UNIT_GW - Component Type: /SCWM/DE_WGT_UOM',
	capa NUMBER(38,3) COMMENT 'Total Capacity Key Figure - Technical name: G_CAPA - Component Type: /SCWM/DE_GCAPA',
	vol_unit VARCHAR(3) COMMENT 'Volume Unit_1 - Technical name: UNIT_GV - Component Type: /SCWM/DE_VOL_UOM',
	sale_flg VARCHAR(1) COMMENT 'Special Sale Flag - Technical name: ZZ_NF_SPEC_SALE_HU - Component Type: ZEWM_E_NF_SPEC_SALE_HU',
	category VARCHAR(20) COMMENT 'Category - Technical name: ZZ_CATEGORY - Component Type: ZEWM_E_NF_CAT',
	open_hu_wt_flg BOOLEAN COMMENT 'Indicator: Handling Unit_1 is Being Moved (Open HU WT) - Technical name: FLGMOVE - Component Type: /SCWM/FLGMOVE',
	pack_mat VARCHAR(40) COMMENT 'Packaging Material - Technical name: PMAT - Component Type: /SCWM/DE_PMAT',
	strg_bin VARCHAR(18) COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA',
	sorted_non_food_flg VARCHAR(1) COMMENT 'Sorted Non-Food Flag - Technical name: ZZ_HU_SORTED - Component Type: ZEWM_E_HU_SORTED',
	pair_bracket NUMBER(38,0) COMMENT 'Pair Bracket - Technical name: ZZ_PAIR_BRACK - Component Type: ZEWM_E_PAIR_BRACK',
	sys_pal NUMBER(38,0) COMMENT 'System Pallet - Technical name: ZZ_SYS_PAL - Component Type: ZEWM_E_SYS_PAL',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_nr, hu_ident, dwh_valid_from)
	)
	COMMENT = 'Read HUs for storage bins - BI reporting'
;
