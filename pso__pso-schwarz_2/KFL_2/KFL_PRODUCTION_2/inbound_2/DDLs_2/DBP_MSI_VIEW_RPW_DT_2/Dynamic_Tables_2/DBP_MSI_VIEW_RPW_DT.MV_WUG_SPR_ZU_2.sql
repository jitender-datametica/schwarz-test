create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_WUG_SPR_ZU_2(
	MANDANT_ID,
	ARTHIERTYP_ID,
	WG_ID,
	SPR_ID,
	WUG_ID,
	WUG_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
          mandant_id,
          arthiertyp_id,
          wg_id,
          spr_id,
          wug_id,
          wug_bez,
          7 AS system_id
FROM dbp_view.v_wug_spr_zu_2
WHERE mandant_id = 1
AND   spr_id = 22
AND   arthiertyp_id = 2;
