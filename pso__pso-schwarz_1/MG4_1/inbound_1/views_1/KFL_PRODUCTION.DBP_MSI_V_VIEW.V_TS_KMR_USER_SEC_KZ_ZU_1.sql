create or replace view KFL_PRODUCTION.DBP_MSI_V_VIEW.V_TS_KMR_USER_SEC_KZ_ZU_1(
	USER_ID,
	SEC_KZ
) as 
    SELECT 
        user_id
        ,sec_kz


FROM DBP_MSI_DATA.ts_kmr_user_sec_kz_zu_1 ;