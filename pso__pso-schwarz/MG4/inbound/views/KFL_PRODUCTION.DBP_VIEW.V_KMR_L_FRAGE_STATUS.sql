create or replace view KFL_PRODUCTION.DBP_VIEW.V_KMR_L_FRAGE_STATUS(
	AMX_SYSTEM_ID,
	FRAGE_STATUS_ID,
	FRAGE_STATUS_BEZ
) as 
    SELECT 
        amx_system_id
        ,frage_status_id
        ,frage_status_bez


FROM DBP_DATA.KMR_L_FRAGE_STATUS ;