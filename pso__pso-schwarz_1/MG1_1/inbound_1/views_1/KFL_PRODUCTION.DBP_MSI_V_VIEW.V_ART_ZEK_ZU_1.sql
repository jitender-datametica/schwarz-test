create or replace view KFL_PRODUCTION.DBP_MSI_V_VIEW.V_ART_ZEK_ZU_1(
	ART_ID,
	MANDANT_ID,
	ZEK_ID
) as 
    SELECT 
        art_id,
        mandant_id,
        zek_id
FROM DBP_MSI_DATA.ART_ZEK_ZU_1 ;