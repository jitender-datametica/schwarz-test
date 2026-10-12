/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			data
DB table/view:		t_lu_stockoverview_storage_section_1
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


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lu_stockoverview_storage_section_1 (
lu_id NUMERIC(2) NOT NULL OPTIONS(description='Internal ID'),
strg_sec_cd STRING(10) NOT NULL OPTIONS(description='Storage section code (PK)'),
strg_sec_desc STRING(100) OPTIONS(description='Storage section description'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH data source'),
PRIMARY KEY (strg_sec_cd) NOT ENFORCED
) OPTIONS(description='SAP EWM stock overview - FE lookup table for storage section');