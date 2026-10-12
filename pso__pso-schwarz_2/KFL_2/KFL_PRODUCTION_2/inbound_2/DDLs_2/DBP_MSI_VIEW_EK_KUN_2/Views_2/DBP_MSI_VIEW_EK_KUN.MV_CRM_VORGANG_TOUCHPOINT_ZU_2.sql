create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_EK_KUN.MV_CRM_VORGANG_TOUCHPOINT_ZU_2(
	MANDANT_ID,
	CRM_VORGANG_ID,
	TOUCHPOINT_ID,
	TOUCHPOINT_COUNT,
	TOUCHPOINT_FG,
	DAT_START,
	DAT_ENDE,
	DAT_START_PROCESSING,
	DAT_END_PROCESSING,
	SEC_KZ
) as
   SELECT 
    -- STRY0048932 Umzug aus KMR nach EK_KUNDE / sschuecke 30.03.2026
    v01.MANDANT_ID
   ,v01.CRM_VORGANG_ID
   ,v01.TOUCHPOINT_ID
   ,v01.TOUCHPOINT_COUNT
   ,CASE WHEN v01.TOUCHPOINT_COUNT > 0 THEN 1 ELSE 0 END AS TOUCHPOINT_FG
   ,TO_DATE(v02.dat_start) AS dat_start
   ,TO_DATE(v02.dat_ende) AS dat_ende
   ,TO_DATE(v02.dat_start_processing) AS dat_start_processing
   ,TO_DATE(v02.dat_end_processing) AS dat_end_processing
   ,3::BYTEINT AS sec_kz
    
    FROM DBP_DATA.CRM_VORGANG_TOUCHPOINT_ZU_2 v01
    JOIN DBP_DATA.CRM_VORGANG_2 v02
    ON v01.mandant_id = v02.mandant_id
    AND v01.crm_vorgang_id = v02.crm_vorgang_id;
