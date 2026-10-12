/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			data
DB table/view:		t_lu_stockoverview_assortment_area_1
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
CREATE TABLE DATA.t_lu_stockoverview_assortment_area_1 (
	lu_id NUMBER(2) NOT NULL COMMENT 'Internal ID',
	assort_area_id NUMBER(2) NOT NULL COMMENT 'Assortment area ID (PK)',
	assort_area_desc VARCHAR(50) COMMENT 'Assortmen area description',
	dwh_created TIMESTAMP_NTZ(9) COMMENT 'DWH creation timestamp',
	dwh_src VARCHAR(50) COMMENT 'DWH data source',
	PRIMARY KEY (assort_area_id)
) COMMENT = 'SAP EWM stock overview - FE lookup table for assortment area'
;
