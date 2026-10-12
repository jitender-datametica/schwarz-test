create or replace view KFL_PRODUCTION.DBP_VIEW.V_KMR_L_PRUEFUNG_STANDORT_1(
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


FROM DBP_DATA.KMR_L_PRUEFUNG_STANDORT_1 ;