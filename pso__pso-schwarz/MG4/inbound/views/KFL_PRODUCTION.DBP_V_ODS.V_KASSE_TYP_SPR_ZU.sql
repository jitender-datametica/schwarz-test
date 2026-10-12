create or replace view KFL_PRODUCTION.DBP_V_ODS.V_KASSE_TYP_SPR_ZU(
	KASSE_TYP_ID,
	SPR_ID,
	KASSE_TYP_BEZ,
	KASSE_NAME_BEZ
) as 
    SELECT 
        kasse_typ_id,
        spr_id,
        kasse_typ_bez,
        kasse_name_bez
FROM DBP_ODS.kasse_typ_spr_zu;