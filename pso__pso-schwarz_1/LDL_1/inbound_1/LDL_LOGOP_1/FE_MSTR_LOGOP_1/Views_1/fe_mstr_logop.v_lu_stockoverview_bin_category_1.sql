/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_stockoverview_bin_category_1
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-25		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for bin category in SAP EWM stock overview (no insert of values)
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_stockoverview_bin_category_1 (
	--lu_id COMMENT 'Internal ID',
	strg_bin_cat COMMENT 'Storage bin category (PK)',
	dwh_created COMMENT 'DWH creation timestamp',
	dwh_src COMMENT 'DWH data source'
) COMMENT = 'SAP EWM stock overview - dynamic lookup view from fact view with no defined list for storage bin category (based on v_sapewm_stockoverview_bintype_kpi_1)'
AS
SELECT
	--lu_id,
	strg_bin_cat,
	MAX(dwh_created) AS dwh_created,
	'dynamic distinct list from fact view' AS dwh_src
FROM fe_mstr_logop.v_sapewm_stockoverview_bintype_kpi_1 -- lookup list is collected dynamically from the fact view, there is no defined list 
GROUP BY strg_bin_cat
;
