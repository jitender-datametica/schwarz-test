/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lu_mfs_conveyor
Description		|	SAP EWM MFS - lookup for FE
====================================================================================================
*/

CREATE TABLE DATA.t_lu_mfs_conveyor (
	cid NUMBER(3) NOT NULL COMMENT 'Technical conveyor ID for FE lookup',
	conveyor VARCHAR(50) COMMENT 'Conveyor name',
	conveyor_area VARCHAR(50) COMMENT 'Conveyor area',
	dwh_sort NUMBER(3) COMMENT 'DWH sorting number',
	dwh_created TIMESTAMP_NTZ(9) COMMENT 'DWH creation timestamp',
	dwh_src VARCHAR(50) COMMENT 'DWH source',
	PRIMARY KEY (cid)
	)
	COMMENT = 'SAP EWM MFS - lookup for FE (PK cid)'
;
