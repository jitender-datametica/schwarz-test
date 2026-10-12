create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BUCH_GRUND_INT_GRUPPE_ZU(
	SYSTEM_ID,
	MANDANT_ID,
	BUCH_GRUND_INT_ID,
	BUCH_GRUND_INT_GRUPPE_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    7,
    mandant_id,
    buch_grund_int_id,
    buch_grund_int_gruppe_id
    FROM dbp_view.v_buch_grund_int_gruppe_zu
    WHERE mandant_id = 1;
