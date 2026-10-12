create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_ARTKZ_DISPLAY(
	DISPLAY_ID,
	DISPLAY_BEZ,
	MANDANT_ID,
	SPR_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
             SELECT
               display_id,
             display_bez,
             mandant_id,
             spr_id,
             7 AS system_id
             FROM dbp_view.v_artkz_display
             WHERE mandant_id = 1
 ;
