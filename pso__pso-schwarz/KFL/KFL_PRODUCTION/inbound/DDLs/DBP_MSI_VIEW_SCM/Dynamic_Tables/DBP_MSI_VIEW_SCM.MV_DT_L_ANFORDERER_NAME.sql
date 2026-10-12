create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_DT_L_ANFORDERER_NAME(
	MANDANT_ID,
	ANFORDERER_NAME
) target_lag = '1 hour' refresh_mode = AUTO initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_LOG
 as
 --2026-02-04, AP0309228, SPEC0356102, initial, dknop
SELECT mandant_id, anforderer_name 
FROM dbp_data.besch_best_det
GROUP BY ALL;
