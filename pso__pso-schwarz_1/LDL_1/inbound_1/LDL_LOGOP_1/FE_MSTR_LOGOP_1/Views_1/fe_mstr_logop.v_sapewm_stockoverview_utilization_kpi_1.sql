/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_sapewm_stockoverview_utilization_kpi_1
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-06		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	Final view for SAP EWM stock overview report utilization
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_STOCKOVERVIEW_UTILIZATION_KPI_1(
	CLIENT_ID COMMENT 'Client ID (PK)',
	WH_ID COMMENT 'Warehouse ID (PK)',
	STRG_BIN COMMENT 'Storage bin (PK)',
	STRG_BIN_TYPE COMMENT 'Storage bin type',
	STRG_TYPE COMMENT 'Storage type',
	STRG_SEC COMMENT 'Storage section',
	HU_CNT COMMENT 'Number of handling units in storage bin',
	IS_STRG_BIN_EMPTY_FLG COMMENT 'Storage bin is empty',
	IS_STRG_BIN_FULL_FLG COMMENT 'Storage bin is full',
	STRG_BIN_AISLE COMMENT 'Storage bin aisle',
	STRG_BIN_STACK COMMENT 'Storage bin stack',
	REM_BIN_DEPTH COMMENT 'Remaining bin depth',
	MAX_BIN_DEPTH COMMENT 'Maximum bin depth',
	DWH_VALID_FROM COMMENT 'Valid from date (PK)',
	DWH_VALID_TO COMMENT 'Valid to date',
	DWH_CREATED COMMENT 'DWH creation timestamp',
	DWH_UPDATED COMMENT 'DWH update timestamp',
	HU_STRG_BIN COMMENT 'Storage bin of handling unit_1 data that matches',
	CNT_HUT_SINGLE_DD COMMENT 'Number of records with handling unit_1 type DD single per storage bin',
	CNT_HUT_COUPLED_DD COMMENT 'Number of records with handling unit_1 type DD coupled per storage bin',
	CNT_HUT_TOTAL_EP COMMENT 'Number of records with handling unit_1 type EP and SP per storage bin',
	CNT_HUT_EPAE COMMENT 'Total of records with any of those three handling unit_1 types (DD single, DD coupled and EP & SP)',
	CNT_HU_IDENT COMMENT 'Number of handling unit_1 IDs (PK) per storage bin (only to see how many data records have been aggregated)',
	TOTAL_BIN COMMENT 'Total bins',
	OCCUPIED_BIN COMMENT 'Occupied bins',
	EMPTY_BIN COMMENT 'Empty bins',
	TOTAL_CH COMMENT 'Total channel which is equal to all storage bins with storage type 8141 without considering empty indicators',
	OCCUPIED_CH COMMENT 'Occupied channel which is all storage bins with storage type 8141 and empty indicator not true',
	EMPTY_CH COMMENT 'Empty channel which is all storage bins with storage type 8141 and empty indicator true ',
	TOTAL_PICKFACE COMMENT 'Total pickface',
	UNASSIGNED_PICKFACE COMMENT 'Unassigned pickface'
) AS
SELECT
	client_id
	--,lidl_ctry
	,wh_id
	,strg_bin
	,strg_bin_type
	,strg_type
	,strg_sec
	--,bin_acs_type
	,hu_cnt
	,is_strg_bin_empty_flg
	,is_strg_bin_full_flg
	,strg_bin_aisle
	,strg_bin_stack
	--,strg_bin_level
	,rem_bin_depth
	,max_bin_depth
	,dwh_valid_from
	,dwh_valid_to
	--,pi_doc_nr
	,dwh_created
	,dwh_updated
	,hu_strg_bin
	,cnt_hut_single_dd
	,cnt_hut_coupled_dd
	,cnt_hut_total_ep
	,cnt_hut_epae
	,cnt_hu_ident
	--,list_zz_hu_type
	--,list_pair_bracket
	--,fba_strg_bin
	--,cnt_prod_nr
	,total_bin
	,occupied_bin
	,empty_bin
	,total_ch 
	,occupied_ch
	,empty_ch
	,total_pickface
	,unassigned_pickface
FROM FE_MSTR_LOGOP.V_SAPEWM_STOCKOVERVIEW_UTILIZATION_ADD_1 -- Primary key combination (client_id, wh_id, strg_bin, dwh_valid_from)
WHERE CURRENT_DATE BETWEEN DWH_VALID_FROM AND DWH_VALID_TO
;
  