create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_L_SYSTEM_1(
	AMX_SYSTEM_ID,
	AMX_SYSTEM_BEZ
) as 
    SELECT 
        amx_system_id
        ,amx_system_bez


FROM DBP_DATA.KMR_L_SYSTEM_1 ;
