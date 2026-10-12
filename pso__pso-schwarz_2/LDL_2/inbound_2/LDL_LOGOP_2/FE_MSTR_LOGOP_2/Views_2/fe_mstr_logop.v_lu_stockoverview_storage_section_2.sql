/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_stockoverview_storage_section_2
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-04-21		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for storage section in SAP EWM stock overview report utilization
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_stockoverview_storage_section_2 (
	lu_id COMMENT 'Internal ID',
	strg_sec_cd COMMENT 'Storage section code (PK)',
	strg_sec_desc COMMENT 'Storage section description',
	dwh_created COMMENT 'DWH creation timestamp',
	dwh_src COMMENT 'DWH data source'
) COMMENT = 'SAP EWM stock overview report utilization - lookup view for storage section (based on t_lu_stockoverview_storage_section_2)'
AS
SELECT
	lu_id,
	strg_sec_cd,
	strg_sec_desc,
	dwh_created,
	dwh_src
FROM DATA.t_lu_stockoverview_storage_section_2
;
