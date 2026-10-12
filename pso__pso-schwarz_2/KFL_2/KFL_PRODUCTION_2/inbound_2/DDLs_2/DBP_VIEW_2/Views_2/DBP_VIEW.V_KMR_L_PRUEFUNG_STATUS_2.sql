create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_L_PRUEFUNG_STATUS_2(
	AMX_SYSTEM_ID,
	PRUEFUNG_STATUS_ID,
	PRUEFUNG_STATUS_BEZ
) as 
    SELECT 
        amx_system_id
        ,pruefung_status_id
        ,pruefung_status_bez


FROM DBP_DATA.KMR_L_PRUEFUNG_STATUS_2 ;
