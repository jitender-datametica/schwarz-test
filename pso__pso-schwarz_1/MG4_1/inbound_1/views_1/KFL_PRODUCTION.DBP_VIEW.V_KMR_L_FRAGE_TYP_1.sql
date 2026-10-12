create or replace view KFL_PRODUCTION.DBP_VIEW.V_KMR_L_FRAGE_TYP_1(
	AMX_SYSTEM_ID,
	FRAGE_TYP_ID,
	FRAGE_TYP_BEZ
) as 
    SELECT 
        amx_system_id
        ,frage_typ_id
        ,frage_typ_bez


FROM DBP_DATA.KMR_L_FRAGE_TYP_1 ;