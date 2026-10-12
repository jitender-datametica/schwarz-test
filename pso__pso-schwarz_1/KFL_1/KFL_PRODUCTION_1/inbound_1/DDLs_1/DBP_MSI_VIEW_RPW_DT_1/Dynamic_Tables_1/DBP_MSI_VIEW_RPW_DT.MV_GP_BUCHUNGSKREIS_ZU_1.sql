create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_GP_BUCHUNGSKREIS_ZU_1(
	MANDANT_ID,
	GP_ID,
	EINKAUFSORGANISATION_ID,
	BUCHUNGSKREIS_ID,
	ZAHLSPERRE_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       mandant_id,
       gp_id,
       einkaufsorganisation_id,
       buchungskreis_id,
       zahlsperre_id,
       7
       FROM dbp_view.v_gp_buchungskreis_zu_1
       WHERE mandant_id = 1;
