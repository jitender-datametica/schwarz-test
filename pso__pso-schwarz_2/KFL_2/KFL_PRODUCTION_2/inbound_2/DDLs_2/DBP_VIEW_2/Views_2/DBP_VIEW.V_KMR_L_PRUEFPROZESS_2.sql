create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_L_PRUEFPROZESS_2(
	AMX_SYSTEM_ID,
	GEPR_PROZESS_ID,
	GEPR_PROZESS_IMP_REFERENZ,
	GEPR_PROZESS_BEZ
) as 
    SELECT 
        amx_system_id
        ,gepr_prozess_id
        ,gepr_prozess_imp_referenz
        ,gepr_prozess_bez


FROM DBP_DATA.KMR_L_PRUEFPROZESS_2 ;
