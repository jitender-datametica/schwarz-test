create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_BUCH_GRUND_EXT(
	BUCH_GRUND_EXT_ID,
	MANDANT_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       buch_grund_ext_id,
       mandant_id,
       7
       FROM dbp_view.v_l_buch_grund_ext
       WHERE mandant_id = 1

       UNION

       SELECT
       '0',
       1,
       7
       FROM dbp_view.v_l_buch_grund_ext;
