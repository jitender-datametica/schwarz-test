/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_supplier_site_2
Description		  | This entity contains sites which are operated by supplier_2
Created on        |	19.11.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_SUPPLIER_SITE_2(
	SUPPLIER_SITE_SID
	,SUPPLIER_SID
	,COUNTRY_CD
	,COUNTRY_DESCR
	,SUPPLIER_SITE_NR
	,SUPPLIER_SITE_ABBR_NAME
	,SUPPLIER_SITE_NAME
	,SUPPLIER_SITE_TRANSPOINT_TYPE_CD
	,SUPPLIER_SITE_TRANSPOINT_TYPE_DESCR
	,LONGITUDE
	,LATITUDE
	,CITY_NAME
	,ZIP
	,STREET_NAME
	,GLN_NR
) AS
SELECT 
	SUPPLIER_SITE_SID
	,SUPPLIER_SID
	,COUNTRY_CD
	,COUNTRY_DESCR
	,SUPPLIER_SITE_NR
	,SUPPLIER_SITE_ABBR_NAME
	,SUPPLIER_SITE_NAME
	,SUPPLIER_SITE_TRANSPOINT_TYPE_CD
	,SUPPLIER_SITE_TRANSPOINT_TYPE_DESCR
	,LONGITUDE
	,LATITUDE
	,CITY_NAME
	,ZIP
	,STREET_NAME
	,GLN_NR
FROM core.t_dim_supplier_site_2
;