create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BELEGART_GRUPPE_SPR_ZU(
	SYSTEM_ID,
	MANDANT_ID,
	SPR_ID,
	BELEGART_GRUPPE_ID,
	BELEGART_GRUPPE_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       7,
       mandant_id,
       spr_id,
       belegart_gruppe_id,
       belegart_gruppe_bez
       FROM dbp_view.v_belegart_gruppe_spr_zu
       WHERE spr_id=22
       AND mandant_id = 1;
