create or replace view KFL_PRODUCTION.DBP_VIEW.V_KMR_L_PRUEFUNG_KLASSE(
	AMX_SYSTEM_ID,
	PRUEFUNG_KLASSE_ID,
	PRUEFUNG_KLASSE_BEZ
) as 
    SELECT 
        amx_system_id
        ,pruefung_klasse_id
        ,pruefung_klasse_bez


FROM DBP_DATA.KMR_L_PRUEFUNG_KLASSE ;