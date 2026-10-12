create or replace view KFL_PRODUCTION.DBP_VIEW.V_KMR_L_PRUEFPROZESS(
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


FROM DBP_DATA.KMR_L_PRUEFPROZESS ;