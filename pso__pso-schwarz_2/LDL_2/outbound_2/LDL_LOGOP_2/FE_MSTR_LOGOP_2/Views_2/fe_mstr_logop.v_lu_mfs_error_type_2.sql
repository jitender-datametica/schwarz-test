/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_mfs_error_type_2
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-05		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for error type in SAP EWM MFS NiO
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_mfs_error_type_2 (lu_id OPTIONS(description='Internal ID'), err_cd
OPTIONS(description='Error code (PK)'), err_desc OPTIONS(description='Error description'), err_cat
OPTIONS(description='Error category'), dwh_created OPTIONS(description='DWH creation timestamp'), dwh_src
OPTIONS(description='DWH data source'))
OPTIONS(DESCRIPTION = `SAP EWM MFS NIO - LOOKUP VIEW FOR CONVEYOR AREA (BASED ON T_LU_MFS_ERROR_TYPE_2)`) AS SELECT *
FROM ldl_logop_data.t_lu_mfs_error_type_2;