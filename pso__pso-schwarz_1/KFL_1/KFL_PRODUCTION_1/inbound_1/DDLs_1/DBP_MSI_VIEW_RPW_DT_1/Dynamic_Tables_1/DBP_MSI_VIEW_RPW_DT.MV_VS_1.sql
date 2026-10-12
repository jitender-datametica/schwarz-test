create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_VS_1(
	VS_ID,
	VS_BEZ,
	VK_ID,
	MANDANT_ID,
	VSVT_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
       vs_id,
    vs_bez,
    vk_id,
    mandant_id,
    vsvt_bez,
    7 AS system_id
    FROM dbp_view.v_vs_1
    WHERE mandant_id = 1
 ;
