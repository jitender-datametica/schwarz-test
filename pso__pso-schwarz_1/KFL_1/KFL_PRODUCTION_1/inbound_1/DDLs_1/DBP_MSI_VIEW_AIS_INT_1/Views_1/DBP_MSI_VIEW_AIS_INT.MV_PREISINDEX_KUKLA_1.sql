create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_INT.MV_PREISINDEX_KUKLA_1(
	MANDANT_ID,
	DAT_ERFASS,
	KUKLA_ID,
	WRG_ID,
	ANZ_ART_VORKALK,
	ANZ_ART_NACHKALK,
	BETRAG_VKP_VORKALK,
	BETRAG_VKP_NACHKALK,
	RATE_KUKLA_UNGEWICHTET_VORKALK,
	RATE_KUKLA_UNGEWICHTET_NACHKALK,
	RATE_KUKLA_GEWICHTET_VORKALK,
	RATE_KUKLA_GEWICHTET_NACHKALK
) as
SELECT 
    mandant_id, 
    dat_erfass, 
    kukla_id, 
    wrg_id, 
    anz_art_vorkalk, 
    anz_art_nachkalk, 
    betrag_vkp_vorkalk, 
    betrag_vkp_nachkalk, 
    rate_kukla_ungewichtet_vorkalk, 
    rate_kukla_ungewichtet_nachkalk, 
    rate_kukla_gewichtet_vorkalk,
    rate_kukla_gewichtet_nachkalk 
FROM dbp_data.preisindex_kukla_1;
