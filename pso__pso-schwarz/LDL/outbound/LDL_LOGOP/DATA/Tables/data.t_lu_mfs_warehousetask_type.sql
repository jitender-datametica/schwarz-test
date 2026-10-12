/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			data
DB table/view:		t_lu_mfs_warehousetask_type
====================================================================================================
Change history:     version, date, developer, comment
	1.0		2022-04-05		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup table for warehouse task type in SAP EWM MFS Total Performance
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lu_mfs_warehousetask_type (
lu_id NUMERIC(2) NOT NULL OPTIONS(description='Internal ID'),
wht_type NUMERIC(4,2) NOT NULL OPTIONS(description='Warehouse task type (PK)'),
wht_desc STRING(50) OPTIONS(description='Warehouse task description'),
wht_desc_long STRING(100) OPTIONS(description='Warehouse task full description'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH data source'),
PRIMARY KEY (wht_type) NOT ENFORCED
) OPTIONS(description='SAP EWM MFS - FE lookup table for warehouse task type');