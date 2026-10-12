create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_LAGER_BEWGRUND_SPR_ZU_2(
	MANDANT_ID,
	GRUND_ID,
	SPR_ID,
	GRUND_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
            mandant_id,
          grund_id,
          spr_id,
          MAX(grund_bez),
          7
          FROM dbp_view.v_lager_bewgrund_spr_zu_2
          WHERE spr_id = 22
            AND mandant_id = 1
          GROUP BY 1,2,3,5
 ;
