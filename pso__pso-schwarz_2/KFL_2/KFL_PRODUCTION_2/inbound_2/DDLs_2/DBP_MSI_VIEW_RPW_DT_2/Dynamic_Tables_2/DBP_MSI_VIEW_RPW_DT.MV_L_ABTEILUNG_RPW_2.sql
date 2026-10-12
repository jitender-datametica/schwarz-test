create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_ABTEILUNG_RPW_2(
	MANDANT_ID,
	ABTEILUNG_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
                SELECT
                mandant_id,
                abteilung_id,
                7
                FROM dbp_view.v_l_abteilung_rpw_2
                WHERE mandant_id = 1;
