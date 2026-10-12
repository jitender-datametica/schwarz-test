/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      mv_sapewm_strgbin_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-11-09      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    Materialized view for SAP EWM storage bin
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE MATERIALIZED VIEW fe_mstr_logop.mv_sapewm_strgbin_2 (
	client_id COMMENT 'Client id - calculated based on the country_2 code'
	,lidl_ctry COMMENT 'Country_2 code. Original field name bic_zmlila'
	,src_sys COMMENT 'Source system'
	,wh_nr COMMENT 'Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'
	,wh_id COMMENT 'Warehouse ID'
	,strg_bin COMMENT 'Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'
	,strg_type COMMENT 'Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP'
	,strg_sec COMMENT 'Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER'
	,strg_bin_type COMMENT 'Storage Bin Type - Technical name: LPTYP - Component Type: /SCWM/LVS_LPTYP'
	,bin_acs_type COMMENT 'Bin Access Type - Technical name: BIN_AT - Component Type: /SCWM/DE_BIN_AT'
	,hu_cnt COMMENT 'Number of Handling Units in Storage Bin - Technical name: ANZLE - Component Type: /SCWM/LAGP_ANZLE'
	,strg_bin_max_weight COMMENT 'Maximum Weight of Storage Bin - Technical name: MAX_WEIGHT - Component Type: /SCWM/LAGP_LGEWI'
	,vol_unit COMMENT 'Volume Unit_2 - Technical name: UNIT_W - Component Type: /SCWM/DE_VOL_UOM'
	,strg_bin_mat_weight COMMENT 'Weight of Materials in Storage Bin - Technical name: WEIGHT - Component Type: /SCWM/LAGP_MGEWI'
	,is_strg_bin_empty_flg COMMENT 'Empty Storage Bin - Technical name: KZLER - Component Type: /SCWM/LAGP_KZLER'
	,is_strg_bin_full_flg COMMENT 'Indicator Whether Storage Bin is Full - Technical name: KZVOL - Component Type: /SCWM/LAGP_KZVOL'
	,first_ptwy_dt COMMENT 'Date of First Putaway - Technical name: PTWY_DATE - Component Type: /SCWM/DE_PTWY_DAT'
	,last_mov_tm COMMENT 'Time of Last Movement - Technical name: MOVED_TIME - Component Type: /SCWM/DE_MOVED_TIME'
	,last_mov_dt COMMENT 'Date of Last Movement - Technical name: MOVED_DATE - Component Type: /SCWM/DE_MOVED_DATE'
	,cnt_dt COMMENT 'Count Date - Technical name: IDATUM - Component Type: /SCWM/DE_COUNT_DATE'
	,pi_doc_nr COMMENT 'Physical Inventory Document Number - Technical name: IVNUM - Component Type: /LIME/PI_DOC_NUMBER'
	,strg_bin_aisle COMMENT 'Storage Bin Aisle - Technical name: AISLE - Component Type: /SCWM/DE_AISLE'
	,strg_bin_stack COMMENT 'Storage Bin Stack - Technical name: STACK - Component Type: /SCWM/DE_STACK'
	,strg_bin_level COMMENT 'Storage Bin Level - Technical name: LVL_V - Component Type: /SCWM/DE_LEVEL'
	,bin_sec COMMENT 'Bin Section of a Storage Bin - Technical name: BINSC - Component Type: /SCWM/DE_BINSC'
	,losc_grp COMMENT 'Storage Group for Layout-Oriented Storage Control - Technical name: LGBER_LGST - Component Type: /SCWM/DE_LGBER_LGST'
	,bin_depth COMMENT 'Bin Depth - Technical name: DEPTH - Component Type: /SCWM/DE_DEPTH'
	,rec_strg_grp COMMENT 'Storage Group for Resource Execution Constraint (REC) - Technical name: REC_GRP - Component Type: /SCWM/DE_REC_GRP'
	,rem_bin_depth COMMENT 'Remaining Bin Depth - Technical name: REM_BIN_DEPTH - Component Type: /SCWM/DE_REM_BIN_DEPTH'
	,max_bin_depth COMMENT 'Maximum Bin Depth - Technical name: MAX_BIN_DEPTH - Component Type: /SCWM/DE_MAX_BIN_DEPTH'
	,field_load_grp COMMENT 'Field Load Group - Technical name: ZZ_FIELD_LOAD - Component Type: ZEWM_E_FIELD_LOAD'
	,max_nr_of_hu COMMENT 'Maximum Number of Handling Units in Storage Bin - Technical name: MAXLE - Component Type: /SCWM/LAGP_MAXLE'
	,dwh_load_id COMMENT 'Load id'
	,dwh_created COMMENT 'Record created at'
	,dwh_updated COMMENT 'Record updated at'
	,dwh_valid_from COMMENT 'Valid from date'
	,dwh_valid_to COMMENT 'Valid to date'
	,deleted_fg COMMENT 'Flag if record is deleted'
) COMMENT = 'SAP EWM storage bin (materialized view based on table t_logop_sapewm_storagebin_2)'
AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,source_system AS src_sys
	,wh_nr
	,LTRIM(REGEXP_SUBSTR(wh_nr, '\\d+'), '0')::NUMBER(5,0) AS wh_id
	,strg_bin
	,strg_type
	,strg_sec
	,strg_bin_type
	,bin_acs_type
	,hu_cnt
	,strg_bin_max_weight
	,vol_unit
	,strg_bin_mat_weight
	,is_strg_bin_empty_flg
	,is_strg_bin_full_flg
	,first_ptwy_dt
	,last_mov_tm
	,last_mov_dt
	,cnt_dt
	,pi_doc_nr
	,strg_bin_aisle
	,strg_bin_stack
	,strg_bin_level
	,bin_sec
	,losc_grp
	,bin_depth
	,rec_strg_grp
	,rem_bin_depth
	,max_bin_depth
	,field_load_grp
	,max_nr_of_hu
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM DATA.t_logop_sapewm_storagebin_2
;
