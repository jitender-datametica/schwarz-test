create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_MANDANT_WRG_ZU_PER(
	MANDANT_ID,
	WRG_ID,
	VON_WRG_ID,
	DAT_VON,
	DAT_BIS,
	UMRECHNUNGSKURS
) as 
    SELECT 
        mandant_id
        ,wrg_id
        ,von_wrg_id
        ,dat_von
        ,dat_bis
        ,umrechnungskurs


FROM DBP_DATA.mandant_wrg_zu_per ;
