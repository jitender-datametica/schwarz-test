create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_LAGERORT_2(
	MANDANT_ID,
	LAGERORT_ID,
	WUP_ID,
	NB_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
          mandant_id,
          lagerort_id,
          wup_id,
          nb_id,
          7
          FROM dbp_view.v_l_lagerort_2
          WHERE mandant_id = 1;
