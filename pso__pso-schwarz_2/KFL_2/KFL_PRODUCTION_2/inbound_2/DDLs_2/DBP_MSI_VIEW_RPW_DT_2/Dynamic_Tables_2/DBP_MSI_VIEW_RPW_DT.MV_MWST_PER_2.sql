create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_MWST_PER_2(
	DAT_VON,
	MWST_ID,
	MWST,
	DAT_BIS,
	MWST_BEZ,
	MANDANT_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       dat_von,
       mwst_id,
       mwst,
       dat_bis,
       mwst_bez,
       mandant_id,
       7
       FROM dbp_view.v_mwst_per_2
       WHERE dat_bis = '9999-12-31'
       AND mandant_id = 1;
