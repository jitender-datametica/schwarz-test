create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_QUARTAL_KJ_2(
	KJQU,
	KJ,
	AKT_KJQU,
	AKT_KJQU_KOMPLETT,
	AKT_KJ,
	AKT_KJ_KOMPLETT,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    kjqu,
    kj,
    akt_kjqu,
    akt_kjqu_komplett,
    akt_kj,
    akt_kj_komplett,
    7
    FROM dbp_view.v_quartal_kj_2
    WHERE kj >= 2005
    AND kj <= EXTRACT(YEAR FROM CURRENT_DATE);
