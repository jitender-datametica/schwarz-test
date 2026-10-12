create or replace view KFL_PRODUCTION.DBP_VIEW.V_KMR_L_MASSNAHME_STATUS_2(
	AMX_SYSTEM_ID,
	MASSNAHME_STATUS_ID,
	MASSNAHME_STATUS_BEZ
) as 
    SELECT 
        amx_system_id,
        massnahme_status_id,
        massnahme_status_bez

FROM DBP_DATA.KMR_L_MASSNAHME_STATUS_2 ;