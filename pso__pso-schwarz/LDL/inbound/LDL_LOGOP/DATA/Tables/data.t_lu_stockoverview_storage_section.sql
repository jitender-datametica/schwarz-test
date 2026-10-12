/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			data
DB table/view:		t_lu_stockoverview_storage_section
====================================================================================================
Change history:     version, date, developer, comment
	1.0		2022-04-21		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup table for storage section in SAP EWM stockoverview utilization
----------------------------------------------------------------------------------------------------
*/
CREATE TABLE DATA.t_lu_stockoverview_storage_section (
	lu_id NUMBER(2) NOT NULL COMMENT 'Internal ID',
	strg_sec_cd VARCHAR(10) NOT NULL COMMENT 'Storage section code (PK)',
	strg_sec_desc VARCHAR(100) COMMENT 'Storage section description',
	dwh_created TIMESTAMP_NTZ(9) COMMENT 'DWH creation timestamp',
	dwh_src VARCHAR(50) COMMENT 'DWH data source',
	PRIMARY KEY (strg_sec_cd)
) COMMENT = 'SAP EWM stock overview - FE lookup table for storage section'
;
