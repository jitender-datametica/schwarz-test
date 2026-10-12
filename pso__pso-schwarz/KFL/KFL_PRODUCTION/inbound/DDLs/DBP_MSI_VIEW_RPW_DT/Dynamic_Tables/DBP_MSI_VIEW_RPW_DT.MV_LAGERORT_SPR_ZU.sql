create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_LAGERORT_SPR_ZU(
	WUP_ID,
	MANDANT_ID,
	LAGERORT_ID,
	NB_ID,
	SPR_ID,
	LAGERORT_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       wup_id,
       mandant_id,
       lagerort_id,
       nb_id,
       spr_id,
       lagerort_bez,
       7
       FROM dbp_view.v_lagerort_spr_zu
       WHERE mandant_id = 1
       AND spr_id = 22;
