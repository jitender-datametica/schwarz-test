create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_WUG(
	WUG_ID,
	WG_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       wug_id,
       wg_id,
       arthiertyp_id,
       mandant_id,
       7
FROM dbp_view.v_wug
WHERE mandant_id = 1
AND  arthiertyp_id = 2;
