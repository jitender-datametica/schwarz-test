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


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_stockoverview_bin_category_1 (strg_bin_cat
OPTIONS(description='Storage bin category (PK)'), dwh_created OPTIONS(description='DWH creation timestamp'), dwh_src
OPTIONS(description='DWH data source'))
OPTIONS(DESCRIPTION = `SAP EWM STOCK OVERVIEW - DYNAMIC LOOKUP VIEW FROM FACT VIEW WITH NO DEFINED LIST FOR STORAGE BIN CATEGORY (BASED ON V_SAPEWM_STOCKOVERVIEW_BINTYPE_KPI_1)`)
AS SELECT strg_bin_cat,
 MAX(dwh_created) AS dwh_created,
 'dynamic distinct list from fact view' AS dwh_src
FROM ldl_logop_fe_mstr_logop.v_sapewm_stockoverview_bintype_kpi_1
GROUP BY strg_bin_cat;