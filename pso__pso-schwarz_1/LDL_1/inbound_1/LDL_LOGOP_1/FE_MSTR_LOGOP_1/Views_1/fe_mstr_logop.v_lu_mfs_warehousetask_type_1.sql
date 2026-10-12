/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_mfs_warehousetask_type_1
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-05		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for warehouse task type in SAP EWM MFS
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_mfs_warehousetask_type_1 (
	lu_id COMMENT 'Internal ID',
	wht_type COMMENT 'Warehouse task type (PK)',
	wht_desc COMMENT 'Warehouse task description',
	wht_desc_long COMMENT 'Warehouse task full description',
	dwh_created COMMENT 'DWH creation timestamp',
	dwh_src COMMENT 'DWH data source'
) COMMENT = 'SAP EWM MFS Total Performance - lookup view for warehouse task type (based on t_lu_mfs_warehousetask_type_1)' 
AS
SELECT
	lu_id,
	wht_type,
	wht_desc,
	wht_desc_long,
	dwh_created,
	dwh_src
FROM DATA.t_lu_mfs_warehousetask_type_1
;
