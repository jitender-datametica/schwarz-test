create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_STATUSCODE_GRUPPE_ZU_1(
	SYSTEM_ID,
	MANDANT_ID,
	STATUSCODE_ID,
	STATUSGRUPPE_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       7,
       mandant_id,
       statuscode_id,
       statusgruppe_id
       FROM dbp_view.v_statuscode_gruppe_zu_1
       WHERE mandant_id = 1
 ;
