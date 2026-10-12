create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_LAND_2(
	LAND_BEZ,
	LAND_ISO,
	EU_LAND_FG,
	LAND_ID,
	MANDANT_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
         land_bez,
       land_iso,
       eu_land_fg,
       land_id,
       mandant_id,
       7
       FROM dbp_view.v_land_2
       WHERE mandant_id = 1
 ;
