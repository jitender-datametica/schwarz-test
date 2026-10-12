create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_PAYM_TYPE_SPR_ZU_1(
	MANDANT_ID,
	SPR_ID,
	KPOS_ZAHLUNG_TYP_ID,
	KPOS_ZAHLUNG_TYP_BEZ,
	PAYM_TYPE_NAME
) as 
    SELECT 
        mandant_id,
        spr_id,
        kpos_zahlung_typ_id,
        kpos_zahlung_typ_bez,
        paym_type_name

FROM DBP_DATA.AAD_PAYM_TYPE_SPR_ZU_1 ;