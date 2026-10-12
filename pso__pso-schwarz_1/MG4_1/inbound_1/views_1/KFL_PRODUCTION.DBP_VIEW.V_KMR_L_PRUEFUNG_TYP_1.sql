create or replace view KFL_PRODUCTION.DBP_VIEW.V_KMR_L_PRUEFUNG_TYP_1(
	AMX_SYSTEM_ID,
	PRUEFUNG_TYP_ID,
	PRUEFUNG_TYP_BEZ
) as 
    SELECT 
        amx_system_id
        ,pruefung_typ_id
        ,pruefung_typ_bez


FROM DBP_DATA.KMR_L_PRUEFUNG_TYP_1 ;