create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_RETAIL_STORE_2(
	EXT_STORE_ID,
	MANDANT_ID,
	EXT_SYSTEM_NAME,
	RETAIL_STORE_NAME,
	RETAIL_STORE_ADDRESS,
	BREITENGRAD,
	LAENGENGRAD,
	EXT_RETAIL_COMPANY_ID,
	COMPETITOR_WUP_ID,
	WUP_ID_INTERN_EXTERN,
	WUP_ID,
	MANDANT_ID_WUP,
	NB_ID,
	DRIVETIME_DISTANCE_KM
) as













SELECT  
	 v01.ext_store_id
	,v01.mandant_id
	,v01.ext_system_name
	,v01.retail_store_name
	,v01.retail_store_address
	,v01.breitengrad
	,v01.laengengrad
	,v01.ext_retail_company_id
	,v01.competitor_wup_id
	,CASE WHEN v01.wup_id = -1 THEN v01.ext_store_id ELSE v03.aktuell_wup_id END AS wup_id_intern_extern
	,COALESCE(v03.aktuell_wup_id, -1) AS wup_id
	,COALESCE(v02.mandant_id, -1) AS mandant_id_wup
	,COALESCE(v02.nb_id, -1) AS nb_id
	,v02.drivetime_distance_km

FROM dbp_view.v_retail_store_2 v01

INNER JOIN 
(SELECT 
  ext_store_id
 ,MAX(wup_id) AS wup_id
 ,MAX(mandant_id) AS mandant_id
 ,MAX(nb_id) AS nb_id
 ,MIN(drivetime_distance_km) AS drivetime_distance_km
 FROM dbp_view.v_retail_store_distance_2
 GROUP BY ext_store_id 
 ) v02
ON v01.ext_store_id = v02.ext_store_id

INNER JOIN dbp_view.v_wup_2 v03
ON v02.wup_id = v03.wup_id
AND v02.mandant_id = v03.mandant_id
;