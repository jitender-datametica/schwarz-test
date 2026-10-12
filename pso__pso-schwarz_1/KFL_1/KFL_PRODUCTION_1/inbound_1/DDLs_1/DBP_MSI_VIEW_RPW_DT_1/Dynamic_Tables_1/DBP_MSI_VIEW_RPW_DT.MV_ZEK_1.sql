create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_ZEK_1(
	MANDANT_ID,
	ZEK_ID,
	WBL_ID,
	ZEK_NAME,
	ZEK_ABT_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    mandant_id,
    zek_id,
    wbl_id,
    zek_name,
    zek_abt_bez,
    7 AS system_id
    FROM dbp_view.v_zek_1
    WHERE mandant_id = 1;
