create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_L_TAGESZEIT_1(
	AMX_SYSTEM_ID,
	TAGESZEIT_ID,
	TAGESZEIT_BEZ
) as 
    SELECT 
        amx_system_id
        ,tageszeit_id
        ,tageszeit_bez


FROM DBP_DATA.KMR_L_TAGESZEIT_1 ;
