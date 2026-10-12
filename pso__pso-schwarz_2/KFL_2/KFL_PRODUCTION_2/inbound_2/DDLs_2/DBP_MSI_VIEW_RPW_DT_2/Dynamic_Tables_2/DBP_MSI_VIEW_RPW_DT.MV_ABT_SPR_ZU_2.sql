create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_ABT_SPR_ZU_2(
	ABT_ID,
	SPR_ID,
	ARTHIERTYP_ID,
	ABT_BEZ,
	MANDANT_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       abt_id,
       spr_id,
       arthiertyp_id,
       abt_bez,
       mandant_id,
       7
       FROM dbp_view.v_abt_spr_zu_2
       WHERE mandant_id = 1
       AND spr_id = 22
       AND arthiertyp_id = 2
       AND abt_id NOT IN (0,-1,-2,-3)
       ;
