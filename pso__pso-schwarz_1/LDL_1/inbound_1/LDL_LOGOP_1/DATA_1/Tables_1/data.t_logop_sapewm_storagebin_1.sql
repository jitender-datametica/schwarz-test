/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_storagebin_1
====================================================================================================
*/

CREATE TABLE DATA.t_logop_sapewm_storagebin_1 (
	client_id NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country_1 code',
	lidl_country VARCHAR(3) NOT NULL COMMENT 'Country_1 code. Original field name bic_zmlila',
	source_system VARCHAR(30) NOT NULL COMMENT 'Source system',
	wh_nr VARCHAR(5) COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM',
	strg_bin VARCHAR(18) COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA',
	strg_type VARCHAR(4) COMMENT 'Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP',
	strg_sec VARCHAR(4) COMMENT 'Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER',
	strg_bin_type VARCHAR(4) COMMENT 'Storage Bin Type - Technical name: LPTYP - Component Type: /SCWM/LVS_LPTYP',
	bin_acs_type VARCHAR(4) COMMENT 'Bin Access Type - Technical name: BIN_AT - Component Type: /SCWM/DE_BIN_AT',
	hu_cnt NUMBER(38,0) COMMENT 'Number of Handling Units in Storage Bin - Technical name: ANZLE - Component Type: /SCWM/LAGP_ANZLE',
	strg_bin_max_weight NUMBER(38,3) COMMENT 'Maximum Weight of Storage Bin - Technical name: MAX_WEIGHT - Component Type: /SCWM/LAGP_LGEWI',
	vol_unit VARCHAR(3) COMMENT 'Volume Unit_1 - Technical name: UNIT_W - Component Type: /SCWM/DE_VOL_UOM',
	strg_bin_mat_weight NUMBER(38,3) COMMENT 'Weight of Materials in Storage Bin - Technical name: WEIGHT - Component Type: /SCWM/LAGP_MGEWI',
	is_strg_bin_empty_flg BOOLEAN COMMENT 'Empty Storage Bin - Technical name: KZLER - Component Type: /SCWM/LAGP_KZLER',
	is_strg_bin_full_flg BOOLEAN COMMENT 'Indicator Whether Storage Bin is Full - Technical name: KZVOL - Component Type: /SCWM/LAGP_KZVOL',
	first_ptwy_dt DATE COMMENT 'Date of First Putaway - Technical name: PTWY_DATE - Component Type: /SCWM/DE_PTWY_DAT',
	last_mov_tm TIME(0) COMMENT 'Time of Last Movement - Technical name: MOVED_TIME - Component Type: /SCWM/DE_MOVED_TIME',
	last_mov_dt DATE COMMENT 'Date of Last Movement - Technical name: MOVED_DATE - Component Type: /SCWM/DE_MOVED_DATE',
	cnt_dt DATE COMMENT 'Count Date - Technical name: IDATUM - Component Type: /SCWM/DE_COUNT_DATE',
	pi_doc_nr NUMBER(38,0) COMMENT 'Physical Inventory Document Number - Technical name: IVNUM - Component Type: /LIME/PI_DOC_NUMBER',
	strg_bin_aisle VARCHAR(18) COMMENT 'Storage Bin Aisle - Technical name: AISLE - Component Type: /SCWM/DE_AISLE',
	strg_bin_stack VARCHAR(18) COMMENT 'Storage Bin Stack - Technical name: STACK - Component Type: /SCWM/DE_STACK',
	strg_bin_level VARCHAR(18) COMMENT 'Storage Bin Level - Technical name: LVL_V - Component Type: /SCWM/DE_LEVEL',
	bin_sec VARCHAR(18) COMMENT 'Bin Section of a Storage Bin - Technical name: BINSC - Component Type: /SCWM/DE_BINSC',
	losc_grp VARCHAR(4) COMMENT 'Storage Group for Layout-Oriented Storage Control - Technical name: LGBER_LGST - Component Type: /SCWM/DE_LGBER_LGST',
	bin_depth VARCHAR(18) COMMENT 'Bin Depth - Technical name: DEPTH - Component Type: /SCWM/DE_DEPTH',
	rec_strg_grp VARCHAR(4) COMMENT 'Storage Group for Resource Execution Constraint (REC) - Technical name: REC_GRP - Component Type: /SCWM/DE_REC_GRP',
	rem_bin_depth NUMBER(38,0) COMMENT 'Remaining Bin Depth - Technical name: REM_BIN_DEPTH - Component Type: /SCWM/DE_REM_BIN_DEPTH',
	max_bin_depth NUMBER(38,0) COMMENT 'Maximum Bin Depth - Technical name: MAX_BIN_DEPTH - Component Type: /SCWM/DE_MAX_BIN_DEPTH',
	field_load_grp NUMBER(38,0) COMMENT 'Field Load Group - Technical name: ZZ_FIELD_LOAD - Component Type: ZEWM_E_FIELD_LOAD',
	max_nr_of_hu NUMBER(38,0) COMMENT 'Maximum Number of Handling Units in Storage Bin - Technical name: MAXLE - Component Type: /SCWM/LAGP_MAXLE',
	dwh_load_id NUMBER(38,0) NOT NULL COMMENT 'Load id',
	dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
	dwh_valid_from DATE NOT NULL COMMENT 'Valid from date',
	dwh_valid_to DATE NOT NULL COMMENT 'Valid to date',
	deleted_fg BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
	PRIMARY KEY (client_id, wh_nr, strg_bin, dwh_valid_from)
	)
	COMMENT = 'Storage Bin Data for Power BI Reporting'
;
