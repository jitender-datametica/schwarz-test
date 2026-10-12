create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_SPR(
	SPR_ID,
	SPR_NAME,
	SPR_ISO,
	DWH_SPR,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
       spr_id,
    spr_name,
    spr_iso,
    dwh_spr,
    7
    FROM dbp_view.v_spr
    WHERE spr_id = 22
 ;
