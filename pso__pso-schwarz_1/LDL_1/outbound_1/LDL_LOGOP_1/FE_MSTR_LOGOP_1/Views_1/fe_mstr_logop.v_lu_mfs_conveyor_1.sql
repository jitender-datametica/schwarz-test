/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lu_mfs_conveyor_1
Description		|	SAP EWM MFS - lookup for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_mfs_conveyor_1 (cid
OPTIONS(description='Technical conveyor ID for FE lookup'), conveyor OPTIONS(description='Conveyor name'), conveyor_area
OPTIONS(description='Conveyor area'), dwh_sort OPTIONS(description='DWH sorting number'), dwh_created
OPTIONS(description='DWH creation timestamp'), dwh_src OPTIONS(description='DWH source'))
OPTIONS(DESCRIPTION = `SAP EWM MFS - LOOKUP FOR FE (PK CID)`) AS SELECT *
FROM ldl_logop_data.t_lu_mfs_conveyor_1;