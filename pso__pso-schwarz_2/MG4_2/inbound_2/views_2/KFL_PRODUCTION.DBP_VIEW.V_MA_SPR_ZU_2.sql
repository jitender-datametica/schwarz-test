create or replace view KFL_PRODUCTION.DBP_VIEW.V_MA_SPR_ZU_2(
	MA_ID,
	SPR_ID,
	MA_ANREDE,
	MA_NAME,
	MA_VORNAME,
	EMAIL,
	MOBIL_TEL,
	MA_LDAP,
	MANDANT_ID,
	TD_UPDATE,
	TD_INSERT
) as 
    SELECT 
        ma_id,
        spr_id,
        ma_anrede,
        ma_name,
        ma_vorname,
        email,
        mobil_tel,
        ma_ldap,
        mandant_id,
        td_update,
        td_insert
FROM DBP_DATA.ma_spr_zu_2 ;