/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_stockoverview_assortment_area_2
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-06-17		Anna Dean			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for assortment area in SAP EWM stockoverview - stock type
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_stockoverview_assortment_area_2 (
	lu_id COMMENT 'Internal ID'
	,assort_area_id COMMENT 'Assortment area ID (PK)'
	,assort_area_desc COMMENT 'Assortmen area description'
	,dwh_created COMMENT 'DWH creation timestamp'
	,dwh_src COMMENT 'DWH data source'
) COMMENT = 'SAP EWM stock overview - lookup view for assortment area (based on t_lu_stockoverview_assortment_area_2)'
AS
SELECT
	lu_id 
	,assort_area_id
	,assort_area_desc
	,dwh_created
	,dwh_src
FROM DATA.t_lu_stockoverview_assortment_area_2
;
