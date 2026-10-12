/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_mfs_conveyor_type
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-06-01		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for conveyor type in SAP EWM MFS Conveyor Usage
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LU_MFS_CONVEYOR_TYPE(
	CT_ID COMMENT 'Conveyor type ID (PK)',
	CT_DESC COMMENT 'Conveyor type in English',
	CT_DESC_DE COMMENT 'Conveyor type in German',
	DWH_CREATED COMMENT 'DWH creation time',
	DWH_SRC COMMENT 'DWH source'
) COMMENT='SAP EWM MFS Conveyor Usage - lookup view for conveyor type (based on t_lu_mfs_conveyor_type)'
 AS
SELECT
	CASE WHEN CT_ID = '1.0' THEN 1 
	WHEN ct_ID = '2.0' THEN 2 
	WHEN CT_ID = '3.0' THEN 3
	WHEN CT_iD = '3.1' THEN 31
	WHEN CT_iD = '3.2' THEN 32 
	WHEN ct_id = '4.0' THEN 4
	WHEN CT_ID = '4.1' THEN 41
	WHEN CT_ID = '4.2' THEN 42
	WHEN CT_iD = '4.3' THEN 43 
	WHEN CT_ID = '4.4' THEN 44
	WHEN CT_ID = '4.5' THEN 45
	WHEN CT_ID = '4.6' THEN 46
	WHEN CT_ID = '5.0' THEN 5
	WHEN CT_iD = '6.0' THEN 6
	WHEN CT_ID = '7.0' THEN 7
	WHEN CT_ID = '8.0' THEN 8
	WHEN CT_ID = '9.0' THEN 9 
	WHEN CT_iD = '10.0' THEN 10 
	WHEN CT_ID = '11' THEN 11 
	WHEN CT_ID = '12.0' THEN 12
	WHEN CT_ID = '13.0' THEN 13
	WHEN CT_ID = '14.0' THEN 14
	WHEN CT_ID = '15.0' THEN 15
	WHEN CT_ID = '15.1' THEN 151
	END AS ct_id
	,ct_desc
	,ct_desc_de
	,dwh_created
	,dwh_src
FROM DATA.t_lu_mfs_conveyor_type
ORDER BY ct_id;