/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			data
DB table/view:		t_lu_mfs_warehousetask_type_1
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
CREATE TABLE DATA.t_lu_mfs_warehousetask_type_1 (
	lu_id NUMBER(2) NOT NULL COMMENT 'Internal ID',
	wht_type NUMBER(4,2) NOT NULL COMMENT 'Warehouse task type (PK)',
	wht_desc VARCHAR(50) COMMENT 'Warehouse task description',
	wht_desc_long VARCHAR(100) COMMENT 'Warehouse task full description',
	dwh_created TIMESTAMP_NTZ(9) COMMENT 'DWH creation timestamp',
	dwh_src VARCHAR(50) COMMENT 'DWH data source',
	PRIMARY KEY (wht_type)
) COMMENT = 'SAP EWM MFS - FE lookup table for warehouse task type'
;
