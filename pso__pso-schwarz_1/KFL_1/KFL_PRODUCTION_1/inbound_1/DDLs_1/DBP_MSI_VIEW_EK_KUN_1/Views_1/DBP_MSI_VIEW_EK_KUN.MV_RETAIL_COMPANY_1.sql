create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_RETAIL_COMPANY_1(
	EXT_RETAIL_COMPANY_ID,
	EXT_SYSTEM_NAME,
	MANDANT_ID,
	RETAIL_COMPANY_CODE,
	RETAIL_COMPANY_NAME,
	COMPETITOR_FG,
	SEC_KZ
) as
    SELECT
    -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
     v01.ext_retail_company_id
    ,v01.ext_system_name
    ,v01.mandant_id
    ,v01.retail_company_code
    ,v01.retail_company_name
    ,v01.competitor_fg
    ,2::BYTEINT AS sec_kz

    FROM DBP_DATA.RETAIL_COMPANY_1 v01
    INNER JOIN
    (
	SELECT 
	v21.ext_retail_company_id
	FROM DBP_DATA.RETAIL_STORE_1 v21

	INNER JOIN DBP_DATA.RETAIL_STORE_DISTANCE_1 v22
	ON v21.ext_store_id = v22.ext_store_id

	GROUP BY v21.ext_retail_company_id
    ) v02
    ON v01.ext_retail_company_id = v02.ext_retail_company_id;
