/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			data
DB table/view:		t_lu_mfs_conveyor_type
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-06-02		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	Table for FE lookup for conveyor type in SAP EWM MFS Conveyor Usage
----------------------------------------------------------------------------------------------------
*/
CREATE TABLE DATA.t_lu_mfs_conveyor_type (
	lu_id NUMBER(3) NOT NULL COMMENT 'Internal ID',
	ct_id NUMBER(3,1) NOT NULL COMMENT 'Conveyor type ID (PK)',
	ct_desc VARCHAR(100) COMMENT 'Conveyor type in English',
	ct_desc_de VARCHAR(100) COMMENT 'Conveyor type in German',
	dwh_created TIMESTAMP_NTZ(9) COMMENT 'DWH creation time',
	dwh_src VARCHAR(50) COMMENT 'DWH source',
	PRIMARY KEY (ct_id)
) COMMENT = 'SAP EWM MFS Conveyor Usage - lookup table for conveyor type'
;