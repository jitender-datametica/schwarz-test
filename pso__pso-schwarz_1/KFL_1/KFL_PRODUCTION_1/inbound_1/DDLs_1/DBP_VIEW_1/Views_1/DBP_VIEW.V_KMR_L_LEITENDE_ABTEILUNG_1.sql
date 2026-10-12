create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_L_LEITENDE_ABTEILUNG_1(
	AMX_SYSTEM_ID,
	LEIT_ABTEILUNG_ID,
	LEIT_ABTEILUNG_BEZ
) as 
    SELECT 
        amx_system_id
        ,leit_abteilung_id
        ,leit_abteilung_bez


FROM DBP_DATA.KMR_L_LEITENDE_ABTEILUNG_1 ;
