create or replace view KFL_PRODUCTION.DBP_VIEW.V_KMR_L_TAGESZEIT_2(
	AMX_SYSTEM_ID,
	TAGESZEIT_ID,
	TAGESZEIT_BEZ
) as 
    SELECT 
        amx_system_id
        ,tageszeit_id
        ,tageszeit_bez


FROM DBP_DATA.KMR_L_TAGESZEIT_2 ;