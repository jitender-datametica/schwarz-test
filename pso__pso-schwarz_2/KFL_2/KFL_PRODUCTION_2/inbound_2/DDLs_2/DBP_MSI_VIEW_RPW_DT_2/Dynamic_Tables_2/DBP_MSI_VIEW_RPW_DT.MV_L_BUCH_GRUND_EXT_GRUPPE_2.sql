create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_BUCH_GRUND_EXT_GRUPPE_2(
	SYSTEM_ID,
	MANDANT_ID,
	BUCH_GRUND_EXT_GRUPPE_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
             SELECT
             7,
             mandant_id,
             buch_grund_ext_gruppe_id
             FROM dbp_view.v_l_buch_grund_ext_gruppe_2
             WHERE mandant_id = 1;
