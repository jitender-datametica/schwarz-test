create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_TS_KMR_USER_SEC_KZ_ZU(
	USER_ID,
	SEC_KZ
) as 
    SELECT 
        user_id
        ,sec_kz


FROM DBP_MSI_DATA.ts_kmr_user_sec_kz_zu ;
