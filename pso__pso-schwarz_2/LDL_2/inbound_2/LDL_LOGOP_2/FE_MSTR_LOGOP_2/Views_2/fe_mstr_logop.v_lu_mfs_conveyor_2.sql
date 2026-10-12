/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lu_mfs_conveyor_2
Description		|	SAP EWM MFS - lookup for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_mfs_conveyor_2 (
	cid COMMENT 'Technical conveyor ID for FE lookup',
	conveyor COMMENT 'Conveyor name',
	conveyor_area COMMENT 'Conveyor area',
	dwh_sort COMMENT 'DWH sorting number',
	dwh_created COMMENT 'DWH creation timestamp',
	dwh_src COMMENT 'DWH source'
	)
COMMENT = 'SAP EWM MFS - lookup for FE (PK cid)' 
AS
SELECT
	cid,
	conveyor,
	conveyor_area,
	dwh_sort,
	dwh_created,
	dwh_src
FROM DATA.t_lu_mfs_conveyor_2
;
