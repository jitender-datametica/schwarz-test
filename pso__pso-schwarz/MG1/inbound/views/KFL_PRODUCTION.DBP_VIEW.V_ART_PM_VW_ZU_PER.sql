create or replace view V_ART_PM_VW_ZU_PER(
	ART_ID,
	PM_ID,
	VW_ID,
	MANDANT_ID,
	PREISTYP_ID,
	DAT_BIS,
	WRG_ID,
	DAT_VON,
	VK_BRUTTO
) as 
    SELECT 
        art_id
        ,pm_id
        ,vw_id
        ,mandant_id
        ,preistyp_id
        ,dat_bis
        ,wrg_id
        ,dat_von
        ,vk_brutto
FROM DBP_DATA.art_pm_vw_zu_per ;