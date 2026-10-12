create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_LAGER_BEWGRUND_2(
	MANDANT_ID,
	SYSTEM_ID,
	GRUND_ID,
	LAGER_BEWART_ID,
	RETOURENART_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    mandant_id,
    7 AS system_id,
    grund_id,
    lager_bewart_id,
    retourenart_id

    FROM dbp_view.v_l_lager_bewgrund_2
    WHERE mandant_id = 1;
