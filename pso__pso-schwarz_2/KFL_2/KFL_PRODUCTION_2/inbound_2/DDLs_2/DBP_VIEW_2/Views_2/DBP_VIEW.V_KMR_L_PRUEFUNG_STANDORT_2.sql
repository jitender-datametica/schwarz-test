create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_L_PRUEFUNG_STANDORT_2(
	AMX_SYSTEM_ID,
	STANDORT_ID,
	STANDORT_BEZ,
	STANDORT_TYP_ID
) as 
    SELECT 
        amx_system_id
        ,standort_id
        ,standort_bez
        ,standort_typ_id


FROM DBP_DATA.KMR_L_PRUEFUNG_STANDORT_2 ;
