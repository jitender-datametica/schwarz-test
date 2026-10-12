/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_mfs_warehousetask_type_1
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-05		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for warehouse task type in SAP EWM MFS
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_mfs_warehousetask_type_1 (lu_id OPTIONS(description='Internal ID'),
wht_type OPTIONS(description='Warehouse task type (PK)'), wht_desc OPTIONS(description='Warehouse task description'),
wht_desc_long OPTIONS(description='Warehouse task full description'), dwh_created
OPTIONS(description='DWH creation timestamp'), dwh_src OPTIONS(description='DWH data source'))
OPTIONS(DESCRIPTION = `SAP EWM MFS TOTAL PERFORMANCE - LOOKUP VIEW FOR WAREHOUSE TASK TYPE (BASED ON T_LU_MFS_WAREHOUSETASK_TYPE_1)`)
AS SELECT *
FROM ldl_logop_data.t_lu_mfs_warehousetask_type_1;