create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_INT.MV_PREISINDEX_GESAMT_1(
	MANDANT_ID,
	DAT_ERFASS,
	WRG_ID,
	BETRAG_UMSATZ_ART_GESAMT
) as
SELECT 
    mandant_id, 
    dat_erfass, 
    wrg_id, 
    betrag_umsatz_art_gesamt 
FROM dbp_data.preisindex_gesamt_1;
