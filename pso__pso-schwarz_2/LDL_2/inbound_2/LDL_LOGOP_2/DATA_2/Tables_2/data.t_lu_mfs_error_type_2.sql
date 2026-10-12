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
CREATE TABLE DATA.t_lu_mfs_error_type_2 (
	lu_id NUMBER(2) NOT NULL COMMENT 'Internal ID',
	err_cd VARCHAR(10) NOT NULL COMMENT 'Error code (PK)',
	err_desc VARCHAR(100) COMMENT 'Error description',
	err_cat VARCHAR(50) COMMENT 'Error category',
	dwh_created TIMESTAMP_NTZ(9) COMMENT 'DWH creation timestamp',
	dwh_src VARCHAR(50) COMMENT 'DWH data source',
	PRIMARY KEY (err_cd)
) COMMENT = 'SAP EWM MFS - FE lookup table for error type'
;
