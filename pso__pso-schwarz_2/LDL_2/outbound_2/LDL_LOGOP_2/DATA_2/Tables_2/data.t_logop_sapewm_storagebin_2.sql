/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_storagebin_2
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_logop_sapewm_storagebin_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
strg_bin STRING(18) NOT NULL OPTIONS(description='Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'),
strg_type STRING(4) OPTIONS(description='Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP'),
strg_sec STRING(4) OPTIONS(description='Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER'),
strg_bin_type STRING(4)
OPTIONS(description='Storage Bin Type - Technical name: LPTYP - Component Type: /SCWM/LVS_LPTYP'),
bin_acs_type STRING(4) OPTIONS(description='Bin Access Type - Technical name: BIN_AT - Component Type: /SCWM/DE_BIN_AT'),
hu_cnt BIGNUMERIC(38,0)
OPTIONS(description='Number of Handling Units in Storage Bin - Technical name: ANZLE - Component Type: /SCWM/LAGP_ANZLE'),
strg_bin_max_weight BIGNUMERIC(38,3)
OPTIONS(description='Maximum Weight of Storage Bin - Technical name: MAX_WEIGHT - Component Type: /SCWM/LAGP_LGEWI'),
vol_unit STRING(3) OPTIONS(description='Volume Unit_2 - Technical name: UNIT_W - Component Type: /SCWM/DE_VOL_UOM'),
strg_bin_mat_weight BIGNUMERIC(38,3)
OPTIONS(description='Weight of Materials in Storage Bin - Technical name: WEIGHT - Component Type: /SCWM/LAGP_MGEWI'),
is_strg_bin_empty_flg BOOL
OPTIONS(description='Empty Storage Bin - Technical name: KZLER - Component Type: /SCWM/LAGP_KZLER'),
is_strg_bin_full_flg BOOL
OPTIONS(description='Indicator Whether Storage Bin is Full - Technical name: KZVOL - Component Type: /SCWM/LAGP_KZVOL'),
first_ptwy_dt DATE
OPTIONS(description='Date of First Putaway - Technical name: PTWY_DATE - Component Type: /SCWM/DE_PTWY_DAT'),
last_mov_tm TIME
OPTIONS(description='Time of Last Movement - Technical name: MOVED_TIME - Component Type: /SCWM/DE_MOVED_TIME'),
last_mov_dt DATE
OPTIONS(description='Date of Last Movement - Technical name: MOVED_DATE - Component Type: /SCWM/DE_MOVED_DATE'),
cnt_dt DATE OPTIONS(description='Count Date - Technical name: IDATUM - Component Type: /SCWM/DE_COUNT_DATE'),
pi_doc_nr BIGNUMERIC(38,0)
OPTIONS(description='Physical Inventory Document Number - Technical name: IVNUM - Component Type: /LIME/PI_DOC_NUMBER'),
strg_bin_aisle STRING(18)
OPTIONS(description='Storage Bin Aisle - Technical name: AISLE - Component Type: /SCWM/DE_AISLE'),
strg_bin_stack STRING(18)
OPTIONS(description='Storage Bin Stack - Technical name: STACK - Component Type: /SCWM/DE_STACK'),
strg_bin_level STRING(18)
OPTIONS(description='Storage Bin Level - Technical name: LVL_V - Component Type: /SCWM/DE_LEVEL'),
bin_sec STRING(18)
OPTIONS(description='Bin Section of a Storage Bin - Technical name: BINSC - Component Type: /SCWM/DE_BINSC'),
losc_grp STRING(4)
OPTIONS(description='Storage Group for Layout-Oriented Storage Control - Technical name: LGBER_LGST - Component Type: /SCWM/DE_LGBER_LGST'),
bin_depth STRING(18) OPTIONS(description='Bin Depth - Technical name: DEPTH - Component Type: /SCWM/DE_DEPTH'),
rec_strg_grp STRING(4)
OPTIONS(description='Storage Group for Resource Execution Constraint (REC) - Technical name: REC_GRP - Component Type: /SCWM/DE_REC_GRP'),
rem_bin_depth BIGNUMERIC(38,0)
OPTIONS(description='Remaining Bin Depth - Technical name: REM_BIN_DEPTH - Component Type: /SCWM/DE_REM_BIN_DEPTH'),
max_bin_depth BIGNUMERIC(38,0)
OPTIONS(description='Maximum Bin Depth - Technical name: MAX_BIN_DEPTH - Component Type: /SCWM/DE_MAX_BIN_DEPTH'),
field_load_grp BIGNUMERIC(38,0)
OPTIONS(description='Field Load Group - Technical name: ZZ_FIELD_LOAD - Component Type: ZEWM_E_FIELD_LOAD'),
max_nr_of_hu BIGNUMERIC(38,0)
OPTIONS(description='Maximum Number of Handling Units in Storage Bin - Technical name: MAXLE - Component Type: /SCWM/LAGP_MAXLE'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, strg_bin, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Storage Bin Data for Power BI Reporting');