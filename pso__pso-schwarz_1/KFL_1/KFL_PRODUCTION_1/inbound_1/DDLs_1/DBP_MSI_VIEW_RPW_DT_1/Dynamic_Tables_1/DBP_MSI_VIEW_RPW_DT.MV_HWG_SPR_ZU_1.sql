create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_HWG_SPR_ZU_1(
	HWG_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	SPR_ID,
	HWG_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       hwg_id,
       arthiertyp_id,
       mandant_id,
       spr_id,
       hwg_bez,
       7
       FROM dbp_view.v_hwg_spr_zu_1
       WHERE mandant_id = 1
       AND spr_id = 22;
