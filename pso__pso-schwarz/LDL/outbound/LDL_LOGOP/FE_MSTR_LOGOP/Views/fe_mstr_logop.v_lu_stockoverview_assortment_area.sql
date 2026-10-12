/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_stockoverview_assortment_area
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


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_stockoverview_assortment_area (lu_id
OPTIONS(description='Internal ID'), assort_area_id OPTIONS(description='Assortment area ID (PK)'), assort_area_desc
OPTIONS(description='Assortmen area description'), dwh_created OPTIONS(description='DWH creation timestamp'), dwh_src
OPTIONS(description='DWH data source'))
OPTIONS(DESCRIPTION = `SAP EWM STOCK OVERVIEW - LOOKUP VIEW FOR ASSORTMENT AREA (BASED ON T_LU_STOCKOVERVIEW_ASSORTMENT_AREA)`)
AS SELECT *
FROM ldl_logop_data.t_lu_stockoverview_assortment_area;