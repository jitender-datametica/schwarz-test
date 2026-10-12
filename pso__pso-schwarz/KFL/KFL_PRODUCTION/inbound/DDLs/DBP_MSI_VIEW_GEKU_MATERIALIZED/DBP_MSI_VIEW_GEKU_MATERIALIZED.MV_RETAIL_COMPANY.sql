create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_RETAIL_COMPANY(
	EXT_RETAIL_COMPANY_ID,
	EXT_SYSTEM_NAME,
	MANDANT_ID,
	RETAIL_COMPANY_CODE,
	RETAIL_COMPANY_NAME,
	COMPETITOR_FG,
	SEC_KZ
) as






SELECT   v01.ext_retail_company_id
        ,v01.ext_system_name
        ,v01.mandant_id
        ,v01.retail_company_code
        ,v01.retail_company_name
        ,v01.competitor_fg
        , 2::BYTEINT AS sec_kz

FROM dbp_view.v_retail_company v01

INNER JOIN
(
	SELECT 
	v21.ext_retail_company_id
	FROM dbp_view.v_retail_store v21

	INNER JOIN dbp_view.v_retail_store_distance v22
	ON v21.ext_store_id = v22.ext_store_id

	GROUP BY v21.ext_retail_company_id

) v02
ON v01.ext_retail_company_id = v02.ext_retail_company_id
;
