/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_sapewm_stockoverview_bintype_add
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-22		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	View with additional columns for SAP EWM stock overview report bin type
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_STOCKOVERVIEW_BINTYPE_ADD(
	CLIENT_ID COMMENT 'Client ID (PK)'
	,LIDL_CTRY COMMENT 'Country code'
	,WH_ID COMMENT 'Warehouse ID (PK)'
	,STRG_BIN COMMENT 'Storage bin (PK)'
	,STRG_BIN_TYPE COMMENT 'Storage bin type'
	,STRG_TYPE COMMENT 'Storage type'
	,STRG_SEC COMMENT 'Storage section'
	,BIN_ACS_TYPE COMMENT 'Bin access type'
	,IS_STRG_BIN_EMPTY_FLG COMMENT 'Storage bin is empty'
	,IS_STRG_BIN_FULL_FLG COMMENT 'Storage bin is full'
	,STRG_BIN_AISLE COMMENT 'Storage bin aisle'
	,STRG_BIN_STACK COMMENT 'Storage bin stack'
	,STRG_BIN_LEVEL COMMENT 'Storage bin level'
	,REM_BIN_DEPTH COMMENT 'Remaining bin depth'
	,MAX_BIN_DEPTH COMMENT 'Maximum bin depth'
	,DWH_VALID_FROM COMMENT 'Valid from date (PK)'
	,DWH_VALID_TO COMMENT 'Valid to date'
	,PI_DOC_NR COMMENT 'Physical inventory document number'
	,DWH_CREATED COMMENT 'DWH creation timestamp'
	,DWH_UPDATED COMMENT 'DWH update timestamp'
	,TOTAL_BIN COMMENT 'Total bins'
	,OCCUPIED_BIN COMMENT 'Occupied bins'
	,EMPTY_BIN COMMENT 'Empty bins'
	,STRG_BIN_CAT COMMENT 'Storage bin category'
) AS
SELECT
	client_id
	,lidl_country AS lidl_ctry
	,wh_id
	,lgpla AS strg_bin
	,lptyp AS strg_bin_type
	,lgtyp AS strg_type
	,lgber AS strg_sec
	,bin_at AS bin_acs_type
	,kzler AS is_strg_bin_empty_flg
	,kzvol AS is_strg_bin_full_flg
	,aisle AS strg_bin_aisle
	,stack AS strg_bin_stack
	,lvl_v AS strg_bin_level
	,rem_bin_depth 
	,max_bin_depth 
	,dwh_valid_from
	,dwh_valid_to
	,ivnum AS pi_doc_nr
	,dwh_created
    ,dwh_updated
	,IFF(((client_id <> 23 AND strg_type = '8141') OR (client_id = 23 AND strg_type = '8241')), max_bin_depth, NULL) AS total_bin
	,IFF(((client_id <> 23 AND strg_type = '8141') OR (client_id = 23 AND strg_type = '8241')), max_bin_depth - rem_bin_depth, NULL) AS occupied_bin
	,IFF(((client_id <> 23 AND strg_type = '8141') OR (client_id = 23 AND strg_type = '8241')), rem_bin_depth, NULL) AS empty_bin
	,CASE
		WHEN client_id = 23 THEN 
			IFF(STARTSWITH(strg_bin_type, 'T'), 'HK' || SUBSTR(strg_bin_type, 2, 1) || '/KK' || SUBSTR(strg_bin_type, 3, 2), NULL)
		ELSE 
			IFF(STARTSWITH(strg_bin_type, 'P'), 'GK' || SUBSTR(strg_bin_type, 3, 1) || '/HK' || SUBSTR(strg_bin_type, 2, 1), NULL)
		END AS strg_bin_cat
FROM DATA.T_SAPEWM_STORAGEBIN  
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
	AND ((client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (25, 96), (18,4), (13,60)) AND strg_type IN ('8141', '8142'))
	OR ((client_id, wh_id) = (23, 18) AND strg_type = '8241')
	AND strg_bin_cat IS NOT NULL
;