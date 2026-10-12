/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			data
DB table/view:		t_lu_stockoverview_assortment_area
====================================================================================================
Change history:     version, date, developer, comment
	1.0		2022-06-17		Anna Dean			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup table for assortment area in SAP EWM stockoverview - stock type
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lu_stockoverview_assortment_area (
lu_id NUMERIC(2) NOT NULL OPTIONS(description='Internal ID'),
assort_area_id NUMERIC(2) NOT NULL OPTIONS(description='Assortment area ID (PK)'),
assort_area_desc STRING(50) OPTIONS(description='Assortmen area description'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_src STRING(50) OPTIONS(description='DWH data source'),
PRIMARY KEY (assort_area_id) NOT ENFORCED
) OPTIONS(description='SAP EWM stock overview - FE lookup table for assortment area');