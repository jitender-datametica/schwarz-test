create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_VERURSACHER_SPR_ZU_1(
	SYSTEM_ID,
	MANDANT_ID,
	VERURSACHER_ID,
	SPR_ID,
	VERURSACHER_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    7,
    mandant_id,
    verursacher_id,
    spr_id,
    verursacher_bez
    FROM dbp_view.v_verursacher_spr_zu_1
    WHERE mandant_id = 1
    AND spr_id = 22
 ;
