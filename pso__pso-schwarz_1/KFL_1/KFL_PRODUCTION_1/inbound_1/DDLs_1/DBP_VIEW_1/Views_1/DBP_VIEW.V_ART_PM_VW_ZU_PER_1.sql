create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ART_PM_VW_ZU_PER_1(
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
FROM DBP_DATA.art_pm_vw_zu_per_1 ;
