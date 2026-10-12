/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			data
DB table/view:		t_lu_mfs_error_type_2
====================================================================================================
Change history:     version, date, developer, comment
	1.0		2022-04-05		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup table for error type in SAP EWM MFS NiO
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lu_mfs_error_type_2 (
lu_id NUMERIC(2) NOT NULL OPTIONS(description='Internal ID'),
err_cd STRING(10) NOT NULL OPTIONS(description='Error code (PK)'),
err_desc STRING(100) OPTIONS(description='Error description'),
err_cat STRING(50) OPTIONS(description='Error category'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH data source'),
PRIMARY KEY (err_cd) NOT ENFORCED
) OPTIONS(description='SAP EWM MFS - FE lookup table for error type');