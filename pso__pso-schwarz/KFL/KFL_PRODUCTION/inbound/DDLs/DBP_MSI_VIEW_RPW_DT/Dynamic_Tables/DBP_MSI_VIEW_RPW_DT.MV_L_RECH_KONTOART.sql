create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_RECH_KONTOART(
	SYSTEM_ID,
	MANDANT_ID,
	RECH_KONTOART_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    7,
    mandant_id,
    rech_kontoart_id
    FROM dbp_view.v_l_rech_kontoart
    WHERE mandant_id = 1
 ;
