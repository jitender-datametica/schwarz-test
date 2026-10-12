create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WG_AUSLIEFERUNGSGRUPPE_PER_1(
	MANDANT_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	WG_ID,
	SORTIMENTSLISTENART_ID,
	DAT_VON,
	DAT_BIS
) as 
    SELECT 
        mandant_id
        ,auslieferungsgruppe_id
        ,wg_id
        ,sortimentslistenart_id
        ,dat_von
        ,dat_bis


FROM DBP_DATA.wg_auslieferungsgruppe_per_1 ;
