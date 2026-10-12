create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_L_FRAGE_STATUS_1(
	AMX_SYSTEM_ID,
	FRAGE_STATUS_ID,
	FRAGE_STATUS_BEZ
) as 
    SELECT 
        amx_system_id
        ,frage_status_id
        ,frage_status_bez


FROM DBP_DATA.KMR_L_FRAGE_STATUS_1 ;
