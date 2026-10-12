create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_ART_WUP_ZU_PER(
	SYSTEM_ID,
	MANDANT_ID,
	WUP_ID,
	DAT_VON,
	NB_ID,
	ART_ID,
	BEZUGSWEG_ID,
	LISTUNG_ID,
	VK_BRUTTO,
	DAT_BIS,
	KDIS
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       7 AS system_id,
       mandant_id,
       wup_id,
       dat_von,
       nb_id,
       art_id,
       bezugsweg_id,
       listung_id,
       vk_brutto,
       dat_bis,
       kdis
       FROM dbp_view.v_art_wup_zu_per
       WHERE dat_bis = '9999-12-31'
       AND mandant_id = 1;
