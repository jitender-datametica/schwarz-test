create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_PROBLEMGRUPPE_SPR_ZU(
	SYSTEM_ID,
	MANDANT_ID,
	PROBLEMGRUPPE_ID,
	SPR_ID,
	PROBLEMGRUPPE_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       7,
       mandant_id,
       problemgruppe_id,
       spr_id,
       problemgruppe_bez
       FROM dbp_view.v_problemgruppe_spr_zu
       WHERE spr_id = 22
       AND mandant_id = 1
 ;
