create or replace view KFL_PRODUCTION.DBP_VIEW.V_ZEK_1(
	MANDANT_ID,
	ZEK_ID,
	WBL_ID,
	ZEK_NAME,
	ZEK_ABT_BEZ
) as 
    SELECT 
        mandant_id,
        zek_id,
        wbl_id,
        zek_name,
        zek_abt_bez
FROM DBP_DATA.ZEK_1 ;