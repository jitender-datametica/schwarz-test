/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lu_mfs_conveyor_1
Description		|	SAP EWM MFS - lookup for FE
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lu_mfs_conveyor_1 (
cid NUMERIC(3) NOT NULL OPTIONS(description='Technical conveyor ID for FE lookup'),
conveyor STRING(50) OPTIONS(description='Conveyor name'),
conveyor_area STRING(50) OPTIONS(description='Conveyor area'),
dwh_sort NUMERIC(3) OPTIONS(description='DWH sorting number'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH source'),
PRIMARY KEY (cid) NOT ENFORCED
) OPTIONS(description='SAP EWM MFS - lookup for FE (PK cid)');