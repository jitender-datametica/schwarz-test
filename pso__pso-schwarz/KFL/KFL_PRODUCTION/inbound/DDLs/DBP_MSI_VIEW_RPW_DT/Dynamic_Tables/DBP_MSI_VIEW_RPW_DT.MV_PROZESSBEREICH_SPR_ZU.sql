create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_PROZESSBEREICH_SPR_ZU(
	SYSTEM_ID,
	MANDANT_ID,
	PROZESSBEREICH_ID,
	SPR_ID,
	PROZESSBEREICH_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       7,
       mandant_id,
       prozessbereich_id,
       spr_id,
       prozessbereich_bez

       FROM dbp_view.v_prozessbereich_spr_zu
       WHERE mandant_id = 1
       AND spr_id = 22;
