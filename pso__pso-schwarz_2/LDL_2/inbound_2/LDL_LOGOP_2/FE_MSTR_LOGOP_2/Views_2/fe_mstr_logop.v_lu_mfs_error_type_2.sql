/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_mfs_error_type_2
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-05		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for error type in SAP EWM MFS NiO
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_mfs_error_type_2 (
	lu_id COMMENT 'Internal ID',
	err_cd COMMENT 'Error code (PK)',
	err_desc COMMENT 'Error description',
	err_cat COMMENT 'Error category',
	dwh_created COMMENT 'DWH creation timestamp',
	dwh_src COMMENT 'DWH data source'
) COMMENT = 'SAP EWM MFS NiO - lookup view for conveyor area (based on t_lu_mfs_error_type_2)' 
AS
SELECT
	lu_id,
	err_cd,
	err_desc,
	err_cat,
	dwh_created,
	dwh_src
FROM DATA.t_lu_mfs_error_type_2
;
