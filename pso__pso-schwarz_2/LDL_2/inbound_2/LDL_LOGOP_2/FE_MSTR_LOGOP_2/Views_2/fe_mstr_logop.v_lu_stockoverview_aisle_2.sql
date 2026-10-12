/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_stockoverview_aisle_2
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-22		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for aisle in SAP EWM stock overview (no insert of values)
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LU_STOCKOVERVIEW_AISLE_2(
	 STRG_BIN_AISLE COMMENT 'Storage bin aisle (PK)'
	,DWH_CREATED COMMENT 'DWH creation timestamp'
	,DWH_SRC COMMENT 'DWH data source'
) AS
SELECT
	aisle AS strg_bin_aisle
	,MAX(dwh_created) AS dwh_created
	,'dynamic distinct list from fact view' AS dwh_src
FROM "DATA".t_sapewm_storagebin_2 -- lookup list is collected dynamically from the fact view, there is no defined list 
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to 
GROUP BY strg_bin_aisle
;