create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_GP_LAND_ZU_1(
	LAND_ID,
	LAND_BEZ,
	MANDANT_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       a.land_id,
       b.land_bez,
       b.mandant_id,
       7
       FROM dbp_view.v_gp_1 a
       LEFT OUTER JOIN dbp_view.v_land_1 b
       ON a.land_id = b.land_id
       AND a.mandant_id=b.mandant_id
       WHERE a.mandant_id = 1
       GROUP BY 1,2,3,4;
