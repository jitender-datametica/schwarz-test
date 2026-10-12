create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ART_AUSLIEFERUNGSGRUPPE_PER_1(
	MANDANT_ID,
	ART_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	DAT_VON,
	DAT_BIS
) as 
    SELECT 
        mandant_id
        ,art_id
        ,auslieferungsgruppe_id
        ,dat_von
        ,dat_bis


FROM DBP_DATA.art_auslieferungsgruppe_per_1 ;
