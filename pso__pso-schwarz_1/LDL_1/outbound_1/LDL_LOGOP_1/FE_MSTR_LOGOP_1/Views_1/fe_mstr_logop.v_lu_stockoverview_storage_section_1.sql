/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_stockoverview_storage_section_1
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-21		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for storage section in SAP EWM stock overview report utilization
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_stockoverview_storage_section_1 (lu_id
OPTIONS(description='Internal ID'), strg_sec_cd OPTIONS(description='Storage section code (PK)'), strg_sec_desc
OPTIONS(description='Storage section description'), dwh_created OPTIONS(description='DWH creation timestamp'), dwh_src
OPTIONS(description='DWH data source'))
OPTIONS(DESCRIPTION = `SAP EWM STOCK OVERVIEW REPORT UTILIZATION - LOOKUP VIEW FOR STORAGE SECTION (BASED ON T_LU_STOCKOVERVIEW_STORAGE_SECTION_1)`)
AS SELECT *
FROM ldl_logop_data.t_lu_stockoverview_storage_section_1;