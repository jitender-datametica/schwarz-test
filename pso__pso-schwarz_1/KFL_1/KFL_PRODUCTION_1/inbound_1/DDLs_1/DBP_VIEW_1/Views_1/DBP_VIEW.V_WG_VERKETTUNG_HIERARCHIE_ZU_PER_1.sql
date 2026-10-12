create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WG_VERKETTUNG_HIERARCHIE_ZU_PER_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	WG_VERKETT_ID,
	WG_VERKETT_HIER_ID,
	DAT_VON,
	DAT_BIS
) as 
    SELECT 
         mandant_id
        ,wup_id
        ,nb_id
        ,wg_verkett_id
        ,wg_verkett_hier_id
        ,dat_von
        ,dat_bis

FROM DBP_DATA.WG_VERKETTUNG_HIERARCHIE_ZU_PER_1 ;
