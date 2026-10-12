/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_stockoverview_aisle
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


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_stockoverview_aisle (strg_bin_aisle
OPTIONS(description='Storage bin aisle (PK)'), dwh_created OPTIONS(description='DWH creation timestamp'), dwh_src
OPTIONS(description='DWH data source')) AS SELECT aisle AS strg_bin_aisle,
 MAX(dwh_created) AS dwh_created,
 'dynamic distinct list from fact view' AS dwh_src
FROM ldl_logop_data.t_sapewm_storagebin
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
GROUP BY strg_bin_aisle;