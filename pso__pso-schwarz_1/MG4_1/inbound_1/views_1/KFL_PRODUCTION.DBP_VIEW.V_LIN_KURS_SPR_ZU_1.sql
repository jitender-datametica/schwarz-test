create or replace view KFL_PRODUCTION.DBP_VIEW.V_LIN_KURS_SPR_ZU_1(
	LIN_KURS_ID,
	SPR_ID,
	MANDANT_ID,
	LIN_BERICHT,
	LIN_KURS_BEZ
) as 
    SELECT 
        lin_kurs_id,
        spr_id,
        mandant_id,
        lin_bericht,
        lin_kurs_bez

FROM DBP_DATA.LIN_KURS_SPR_ZU_1 ;