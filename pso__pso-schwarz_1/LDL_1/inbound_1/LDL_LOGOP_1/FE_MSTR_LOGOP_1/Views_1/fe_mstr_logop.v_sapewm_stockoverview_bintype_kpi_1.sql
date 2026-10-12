/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_sapewm_stockoverview_bintype_kpi_1
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-22		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	Final view for SAP EWM stock overview report bin type
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_sapewm_stockoverview_bintype_kpi_1 (
	client_id COMMENT 'Client ID (PK)'
	,lidl_ctry COMMENT 'Country_1 code'
	,wh_id COMMENT 'Warehouse ID (PK)'
	,strg_bin COMMENT 'Storage bin (PK)'
	,strg_bin_type COMMENT 'Storage bin type'
	,strg_type COMMENT 'Storage type'
	,strg_sec COMMENT 'Storage section'
	,bin_acs_type COMMENT 'Bin access type'
	,is_strg_bin_empty_flg COMMENT 'Storage bin is empty'
	,is_strg_bin_full_flg COMMENT 'Storage bin is full'
	,strg_bin_aisle COMMENT 'Storage bin aisle'
	,strg_bin_stack COMMENT 'Storage bin stack'
	,strg_bin_level COMMENT 'Storage bin level'
	,rem_bin_depth COMMENT 'Remaining bin depth'
	,max_bin_depth COMMENT 'Maximum bin depth'
	,dwh_valid_from COMMENT 'Valid from date (PK)'
	,dwh_valid_to COMMENT 'Valid to date'
	,pi_doc_nr COMMENT 'Physical inventory document number'
	,dwh_created COMMENT 'DWH creation timestamp'
	,dwh_updated COMMENT 'DWH update timestamp'
	,total_bin COMMENT 'Total bins'
	,occupied_bin COMMENT 'Occupied bins'
	,empty_bin COMMENT 'Empty bins'
	,strg_bin_cat COMMENT 'Storage bin category'
) COMMENT = 'SAP EWM stock overview report for bin type - final view (based on v_sapewm_stockoverview_bintype_add_1)'
AS
SELECT
	client_id
	,lidl_ctry
	,wh_id
	,strg_bin
	,strg_bin_type
	,strg_type
	,strg_sec
	,bin_acs_type
	,is_strg_bin_empty_flg
	,is_strg_bin_full_flg
	,strg_bin_aisle
	,strg_bin_stack
	,strg_bin_level
	,rem_bin_depth
	,max_bin_depth
	,dwh_valid_from
	,dwh_valid_to
	,pi_doc_nr
	,dwh_created
	,dwh_updated
	,total_bin
	,occupied_bin
	,empty_bin
	,strg_bin_cat
FROM fe_mstr_logop.v_sapewm_stockoverview_bintype_add_1 -- Primary key combination (client_id, wh_id, strg_bin, dwh_valid_from)
WHERE CURRENT_DATE BETWEEN DWH_VALID_FROM AND DWH_VALID_TO
;
