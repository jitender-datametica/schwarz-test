create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_JAHR_GJ(
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    gj,
    akt_gj,
    akt_gj_komplett,
    7 AS system_id
    FROM dbp_view.v_jahr_gj
    WHERE gj >= 2005
    AND gj <= EXTRACT (YEAR FROM CURRENT_DATE);
